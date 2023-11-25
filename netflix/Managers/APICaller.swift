
import Foundation


struct APICaller {
    static let shared = APICaller()
    
    
    
    func getMovies(urlString : String,complition : @escaping ( Result<[MovieItemResponse],Error>)->Void ){
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, resposne, error in
            guard let data = data, error == nil else {
                return
            }
            do {

                let results = try JSONDecoder().decode(MoviesResponseModel.self, from: data)
                complition(.success(results.results))
            }
            catch {
                complition(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func searchForMovie(searchTxt : String ,page: Int,complition : @escaping ( Result<[MovieItemResponse],Error>)->Void ){
        guard let url = URL(string: "\(Constants.baseUrl)3/search/movie?api_key=\(Constants.apiKey)&query=\(searchTxt)&include_adult=false&language=en-US&page=\(page)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, resposne, error in
            guard let data = data, error == nil else {
                return
            }
            do {

                let results = try JSONDecoder().decode(MoviesResponseModel.self, from: data)
                complition(.success(results.results))
            }
            catch {
                complition(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getYoutubeVideoDetials(videoTitle: String, compliation : @escaping( Result<VideoModel,Error>) -> Void ){
        guard let url = URL(string: "\(Constants.youtubeAPIBaseUrl)?q=\(videoTitle + " trailer")&key=\(Constants.googleCloudAPIKey)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, resposne, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeResponseModel.self, from: data)
                
                guard let movieItem = results.items.first else {
                    return
                }
                compliation(.success(movieItem))
            }
            catch {
                compliation(.failure(error))
            }
        }
        
        task.resume()
    }
    
    

}
