

import SwiftUI
import AVKit

struct Response: Codable {
    var results: [Audd]
}

struct DataAPIView: View {
    
    var body: some View {
        DataAPIView()
    }
}

struct APIResultsSearch: Decodable {
        let result: [TrackInfo]
    }

struct TrackInfo:Decodable {
    let haslyrics: Bool
    let api_lyrics: String
    let artist: String
    let track: String
    let cover: String
}
    
struct APIResultsLyric: Decodable {
    let result: lyricsInfor
}

struct lyricsInfor:Decodable {
    let lyrics: String
}

