import Foundation

@main
struct RecordingNoticeSelfTest {
    static func main() throws {
        let suite = "RecordingNoticeSelfTest-\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite)!
        defer { defaults.removePersistentDomain(forName: suite) }

        try check(RecordingNotice.needsShowing(in: defaults), "初回は出す")
        RecordingNotice.markAcknowledged(in: defaults)
        try check(!RecordingNotice.needsShowing(in: defaults), "確認したら二度と出さない")
        print("RecordingNoticeSelfTest OK")
    }

    static func check(_ condition: Bool, _ label: String) throws {
        guard condition else { throw TestFailure(label: label) }
    }

    struct TestFailure: Error, CustomStringConvertible {
        let label: String
        var description: String { "NG: \(label)" }
    }
}
