import Foundation
import UIKit
import CoreData

struct DataPresentManager {
    static let shared : DataPresentManager = DataPresentManager()
    
    
    func saveItem (movie : MovieItemResponse , complation : @escaping (Result<Void,Error>) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let currentContext = appDelegate.persistentContainer.viewContext
        
        let movieModel = MovieModel(context: currentContext)
        movieModel.id = Int64(movie.id)
        movieModel.original_name = movie.original_name
        movieModel.original_title = movie.original_title
        movieModel.overview = movie.overview
        movieModel.poster_path = movie.poster_path
        movieModel.vote_count = Int64(movie.vote_count)
        movieModel.vote_avarage = movie.vote_avarage
        movieModel.release_date = movie.release_date

        do {
            try currentContext.save()
            complation(.success(()))
        } catch {
            complation(.failure(error))
        }
    }
    
    func getItems (complation : @escaping (Result<[MovieModel], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let currentContext = appDelegate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<MovieModel>(entityName: "MovieModel")
        
        do {
           let movies =  try currentContext.fetch(fetch)
            complation(.success(movies))
            
        } catch {
            complation(.failure(error))
        }
    }
    
    
    func deleteItem (movie : MovieModel , complation : @escaping () -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let currentContext = appDelegate.persistentContainer.viewContext

        currentContext.delete(movie)
        complation()

    }
}
