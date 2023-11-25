//
//  DownloadsViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 04/11/2023.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    
    var movies : [MovieModel] = []
    
    let tableView : UITableView = {
        let uiTableView : UITableView = UITableView()
        uiTableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.idntifier)
        return uiTableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.frame = view.bounds

        tableView.delegate = self
        tableView.dataSource = self

        
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloads()
    }
    
    
    private func getDownloads(){
        movies.removeAll()
        DataPresentManager.shared.getItems { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.movies.append(contentsOf: movies)
                    self?.tableView.reloadData()
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}



extension DownloadsViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.idntifier, for: indexPath) as?  UpComingTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let movieDetails = movies[indexPath.row]
        
        let movieResponseItem = MovieItemResponse(id: Int(movieDetails.id), original_title: movieDetails.original_title, original_name: movieDetails.original_name, overview: movieDetails.overview, poster_path: movieDetails.poster_path, release_date: movieDetails.release_date, vote_avarage: movieDetails.vote_avarage, vote_count: Int(movieDetails.vote_count))
        cell.configure(movie: movieResponseItem)
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieTitle = movies[indexPath.row].original_name ?? movies[indexPath.row].original_title else {
            return
        }
        
        APICaller.shared.getYoutubeVideoDetials(videoTitle: movieTitle) { [weak self] result in
            switch(result){
            case .success(let video):
                DispatchQueue.main.async {
                    
                    let vc = MovieDetailsViewController()
                    guard let movieDetails = self?.movies[indexPath.row] else {
                        return
                    }

                    let movieResponseItem = MovieItemResponse(id: Int(movieDetails.id), original_title: movieDetails.original_title, original_name: movieDetails.original_name, overview: movieDetails.overview, poster_path: movieDetails.poster_path, release_date: movieDetails.release_date, vote_avarage: movieDetails.vote_avarage, vote_count: Int(movieDetails.vote_count))

                    vc.configure(videoData: video, movieDetails: movieResponseItem)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                break;
            case .failure(let error):
                print("ERROR VIDEO DATA \(error.localizedDescription)")
                break;
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete :
            DataPresentManager.shared.deleteItem(movie: self.movies[indexPath.row]) {
                DispatchQueue.main.async {
                    self.movies.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            }
            break;
        default :
            break;
        }
    }
}
