//
//  SearchViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 04/11/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    private var movies : [MovieItemResponse] = []
    
    var page : Int = 1;
    var searchTxt : String = "";
    
    private let moviesTableView : UITableView = {
       let tableView = UITableView()
        tableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.idntifier)
        return tableView
    }()
    
    
    lazy var searchBar:UISearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        view.addSubview(moviesTableView)
        
        configureSearchBar()

        navigationItem.title = "Search"
        self.navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    private func configureSearchBar(){
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.returnKeyType = .search
        searchBar.placeholder = " Type a movie, tv or actor..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    
    private func searchForMovie(){
        APICaller.shared.searchForMovie(searchTxt: searchTxt, page: page) { result in
            switch(result){
            case .success(let movies):
                self.movies.append(contentsOf: movies)
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
                break;
            case .failure(let error):
                self.page = self.page - 1
                print("Error while search \(error.localizedDescription)")
                break;
            }
        }
    }

    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        moviesTableView.frame = view.bounds
    }
    
    
    

}


extension SearchViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.idntifier, for: indexPath) as? UpComingTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(movie: movies[indexPath.row])
        return cell
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
        
        APICaller.shared.getYoutubeVideoDetials(videoTitle: movieTitle) { result in
            switch(result){
            case .success(let video):
                DispatchQueue.main.async {
                    let vc = MovieDetailsViewController()
                    vc.configure(videoData: video, movieDetails: self.movies[indexPath.row])
                    self.navigationController?.pushViewController(vc, animated: true)

                }

                break;
            case .failure(let error):
                print("ERROR VIDEO DATA \(error.localizedDescription)")
                break;
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1  {
            self.page = self.page + 1
            searchForMovie()
            return;
        }
    }
}


extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTxt = searchText
        
        if searchText.isEmpty {
            movies.removeAll()
            moviesTableView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.page = 1
        movies.removeAll()
        moviesTableView.reloadData()
        searchForMovie()
        searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}
