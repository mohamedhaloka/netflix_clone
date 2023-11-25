
import Foundation



struct TrendingTVResponseModel : Codable {
    let results : [TVResponse]
}



struct TVResponse : Codable {
    let id : Int
    let original_name : String?
    let overview : String?
    let poster_path : String?
    let release_date : String?
    let vote_avarage : String?
    let vote_count : Int
}
