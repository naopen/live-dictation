import Foundation

/// The one-time reminder, shown on first launch, that people in a meeting should be told
/// it is being recorded. It informs rather than gates: recording works the same whether
/// or not the dialog was ever dismissed, and it never comes back once acknowledged.
enum RecordingNotice {
    static let acknowledgedKey = "recordingNoticeAcknowledged"

    static let title = "録音を始める前に"
    static let message = """
    文字起こしちゃんは、Web会議を検知すると自動で録音を始めます。録音や文字起こしをするときは、参加者へ事前に伝えてください。

    社外の方との会議では、秘密保持契約や先方の方針で録音が認められていない場合があります。

    録音とログはこのMacの中だけに保存されます。
    """
    static let buttonTitle = "わかりました"

    static func needsShowing(in defaults: UserDefaults) -> Bool {
        !defaults.bool(forKey: acknowledgedKey)
    }

    static func markAcknowledged(in defaults: UserDefaults) {
        defaults.set(true, forKey: acknowledgedKey)
    }
}
