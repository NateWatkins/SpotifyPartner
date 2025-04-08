import FirebaseDatabase
import Foundation

class SpotifyHistoryService {
    private let userID = "-ON1qc4FPniWt2irNBNx" // <-- replace with dynamic logic later
    private var ref: DatabaseReference {
        Database.database().reference(withPath: "recent_history/\(userID)")
    }

    func fetchRecentTracks(completion: @escaping ([SpotifyTrack]) -> Void) {
        print("📡 [Firebase] Fetching from path: recent_history/\(userID)")

        ref.observeSingleEvent(of: .value) { snapshot in
            print("✅ [Firebase] Received snapshot: \(snapshot.childrenCount) items")

            var tracks: [SpotifyTrack] = []

            for child in snapshot.children {
                guard let snap = child as? DataSnapshot,
                      let dict = snap.value as? [String: Any] else {
                          print("⚠️ [Firebase] Could not cast snapshot value")
                          continue
                      }

                print("🔍 [Track \(snap.key)] Raw data: \(dict)")

                if let album = dict["album"] as? String,
                   let albumArt = dict["album_art"] as? String,
                   let artists = dict["artists"] as? String,
                   let name = dict["name"] as? String,
                   let playedAt = dict["played_at"] as? String {
                    let track = SpotifyTrack(
                        id: snap.key,
                        album: album,
                        albumArt: albumArt,
                        artists: artists,
                        name: name,
                        playedAt: playedAt
                    )
                    print("🎵 [Parsed] \(track.name) by \(track.artists)")
                    tracks.append(track)
                } else {
                    print("⚠️ [Firebase] Missing expected fields in: \(dict)")
                }
            }

            let sortedTracks = tracks.sorted(by: { $0.playedAt > $1.playedAt })
            print("📦 [Result] Returning \(sortedTracks.count) tracks")
            completion(sortedTracks)
        }
    }
}
