
import Foundation
 
// MARK: - Audd
struct Audd: Codable {
    let status: String?
    let result: Result?
    
}
 
// MARK: - Result
struct Result: Codable {
    let artist, title, album, releaseDate: String?
    let label, timecode: String?
    let songLink: String?
    let appleMusic: AppleMusic?
    let spotify: Spotify?
    let lyrics: String?
 
    enum CodingKeys: String, CodingKey {
        case artist, title, album
        case releaseDate = "release_date"
        case label, timecode
        case songLink = "song_link"
        case appleMusic = "apple_music"
        case spotify
        case lyrics
    }
}
 
// MARK: - AppleMusic
struct AppleMusic: Codable {
    let previews: [Preview]?
    let artwork: Artwork?
    let artistName: String?
    let url: String?
    let discNumber: Int?
    let genreNames: [String]?
    let durationInMillis: Int?
    let releaseDate, name, isrc, albumName: String?
    let playParams: PlayParams?
    let trackNumber: Int?
    let composerName: String?
}
 
// MARK: - Artwork
struct Artwork: Codable {
    let width, height: Int?
    let url, bgColor, textColor1, textColor2: String?
    let textColor3, textColor4: String?
}
 
// MARK: - PlayParams
struct PlayParams: Codable {
    let id, kind: String?
}
 
// MARK: - Preview
struct Preview: Codable {
    let url: String?
}
 
// MARK: - Spotify
struct Spotify: Codable {
    let album: Album?
    let artists: [Artist]?
    let availableMarkets: JSONNull?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let isLocal: Bool?
    let name: String?
    let popularity, trackNumber: Int?
    let type, uri: String?
 
    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case trackNumber = "track_number"
        case type, uri
    }
}
 
// MARK: - Album
struct Album: Codable {
    let albumType: String?
    let artists: [Artist]?
    let availableMarkets: JSONNull?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [SongImage]?
    let name, releaseDate, releaseDatePrecision: String?
    let totalTracks: Int?
    let type, uri: String?
 
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}
 
// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name, type, uri: String?
 
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}
 
// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String?
}
 
// MARK: - Image
struct SongImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}
 
// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String?
}
 
// MARK: - Encode/decode helpers
 
class JSONNull: Codable, Hashable {
 
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
 
    public var hashValue: Int {
        return 0
    }
 
    public init() {}
 
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
 
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
 
//struct Sheet: Codable{
//    let SongName: String
//    let ArtistName: String
//    let RootChord: String
//    let text: String
//}
