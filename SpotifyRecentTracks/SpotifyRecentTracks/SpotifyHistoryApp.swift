import SwiftUI
import Firebase

@main
struct SpotifyHistoryApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
