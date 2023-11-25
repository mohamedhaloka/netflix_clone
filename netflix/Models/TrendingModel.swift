
import Foundation



struct MoviesResponseModel : Codable {
    let results : [MovieItemResponse]
}

struct MovieItemResponse : Codable {
    let id : Int
    let original_title : String?
    let original_name : String?
    let overview : String?
    let poster_path : String?
    let release_date : String?
    let vote_avarage : String?
    let vote_count : Int
}
