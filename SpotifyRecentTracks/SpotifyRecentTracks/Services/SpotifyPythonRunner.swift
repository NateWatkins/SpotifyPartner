import Foundation

class SpotifyPythonRunner {
    static func runPythonScript() {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/python3")

        // Full path to your Python file
        process.arguments = ["/Users/natwat/Desktop/CPSC_Projects/SpotifyRecentHistory/main.py"]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
            process.waitUntilExit()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                print("🐍 [Python Output] \(output)")
            }
        } catch {
            print("❌ Failed to run Python script: \(error)")
        }
    }
}
