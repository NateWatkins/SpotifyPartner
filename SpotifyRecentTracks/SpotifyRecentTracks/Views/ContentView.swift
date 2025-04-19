import SwiftUI

struct ContentView: View {
    @State private var tracks: [SpotifyTrack] = []

    var body: some View {
        List(tracks) { track in
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: track.albumArt)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 60, height: 60)
                .cornerRadius(8)

                VStack(alignment: .leading, spacing: 4) {
                    Text(track.name)
                        .font(.headline)
                    Text(track.artists)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(track.playedAt)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 4)
        }
        .task {
            SpotifyPythonRunner.runPythonScript() // Run Python script
            //viewModel.loadTracks()                // Load Firebase data
        }
        
    }
}
