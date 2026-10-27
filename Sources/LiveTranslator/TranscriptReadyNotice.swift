import Foundation
import OSLog
@preconcurrency import UserNotifications

/// Tells, once a recording has stopped, that `transcript.md` now holds the whole meeting.
///
/// Recognition runs behind real time while recording and the rest is written out only
/// after the session stops, which is about a minute and a half after the meeting app
/// lets go of the microphone. Asking for minutes before that reads a transcript with
/// the end missing, so this banner marks the moment it is safe to start.
enum TranscriptReadyNotice {
    static let categoryID = "transcriptReady"

    private static let logger = Logger(subsystem: "com.minorun365.LiveDictation", category: "TranscriptReadyNotice")

    static func post(title: String, sessionDirectory: URL) {
        let content = UNMutableNotificationContent()
        content.title = "文字起こしが完了しました"
        content.body = title
        content.categoryIdentifier = categoryID
        content.sound = .default
        content.userInfo = ["sessionDirectory": sessionDirectory.path]

        let request = UNNotificationRequest(
            identifier: "\(categoryID).\(sessionDirectory.lastPathComponent)",
            content: content,
            trigger: nil
        )
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                logger.error("post failed: \(error.localizedDescription, privacy: .public)")
            }
        }
    }
}
