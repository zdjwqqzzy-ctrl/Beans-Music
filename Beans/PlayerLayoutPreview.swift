#if DEBUG
import SwiftUI

/// Offline, deterministic fixture for CI screenshots; excluded from Release builds.
struct PlayerLayoutPreview: View {
    @EnvironmentObject private var player: PlayerManager
    @State private var showLyrics = true
    private let song = Song(id: -1, name: "Evening Light", artists: "Beans Studio",
                            album: "Layout Study", coverURL: nil, duration: 240)
    private let lines = [
        LyricLine(time: 0, text: "The city settles into blue", translation: "城市渐渐染上蓝色"),
        LyricLine(time: 20, text: "Follow the light", translation: "循着光的方向"),
        LyricLine(time: 40, text: "Let the evening find its rhythm", translation: "让夜晚找到自己的节奏"),
        LyricLine(time: 60, text: "A little closer to the sky", translation: "离天空再近一些")
    ]

    var body: some View {
        ReferencePlaybackView(song: song, lyrics: lines, showLyrics: $showLyrics,
                              onFavorite: {}, onQueue: {}, onComments: {}, onSleepTimer: {},
                              onAddToLocalPlaylist: {}, onDownload: {}, onPlayerSettings: {})
            .onAppear {
                player.queue = [song]
                player.currentIndex = 0
                player.duration = 240
                player.progress = 24
            }
    }
}
#endif
