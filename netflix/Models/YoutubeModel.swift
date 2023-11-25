
import Foundation



struct YoutubeResponseModel : Codable {
    let items : [VideoModel]
}

struct VideoModel : Codable {
    let id : VideoIdModel?
}

struct VideoIdModel : Codable {
    let kind : String?
    let videoId : String?
}
