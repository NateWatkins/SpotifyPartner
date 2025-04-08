import SwiftUI

struct ContentView: View {
    @State private var tracks: [SpotifyTrack] = []

    var body: some View {
        List(tracks) { track in
            VStack(alignment: .leading) {
                Text(track.name).font(.headline)           // Fixed
                Text(track.artists).font(.subheadline)     // Fixed
                Text(track.playedAt).font(.caption)
            }
        }
        .onAppear {
            SpotifyHistoryService().fetchRecentTracks { tracks in
                print("🎯 [ContentView] Final fetched: \(tracks.count) tracks")
                self.tracks = tracks
            }
        }
        
    }
}
