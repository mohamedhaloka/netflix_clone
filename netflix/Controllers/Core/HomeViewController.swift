//
//  HomeViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 04/11/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sections : [String] = [
        "Trending Movie",
        "Trending TV",
        "Upcoming",
        "Popular",
    ]
    
    private let homeFeedTable : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return tableView;
        
    }()
    
    
    private let heroHeader = {
        return HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 450))
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(homeFeedTable)

        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        heroHeader.delegate = self
        
        configureNavBar()
        
        homeFeedTable.tableHeaderView = heroHeader
        getTrendingMovies()
    }
    
    
    private func getTrendingMovies(){
        APICaller.shared.getMovies(urlString: "\(Constants.baseUrl)3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1") { result in
            switch(result){
            case .success(let movies):
                DispatchQueue.main.async {
                    self.heroHeader.configue(movie:  movies.randomElement())
                }
                break;
            case .failure(_):
                break;
            }
        }
    }
    
    private func configureNavBar(){

        navigationController?.navigationBar.tintColor = .white
        
        var netflixLogo =  UIImage(named: "icon")
        netflixLogo = netflixLogo?.withRenderingMode(.alwaysOriginal)
        netflixLogo =  netflixLogo?.withTintColor(.systemRed)
        navigationItem.setLeftBarButton(UIBarButtonItem(image: netflixLogo, style: .done, target: self, action: nil), animated: true)

        
        navigationItem.setRightBarButtonItems([
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(goToProfile)),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle.on.rectangle"), style: .done, target: self, action: #selector(goToWatchList)),
        ], animated: true)

    }
    
    
    @objc private func goToProfile(){
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    @objc private func goToWatchList(){
        navigationController?.pushViewController(WatchListViewController(), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        var urlString : String? ;
        
        switch (indexPath.section){
        case 0:
            urlString = "\(Constants.baseUrl)3/trending/movie/day?api_key=\(Constants.apiKey)"
        break;
        case 1:
            urlString = "\(Constants.baseUrl)3/trending/tv/day?api_key=\(Constants.apiKey)"
        break;
        case 2:
            urlString = "\(Constants.baseUrl)3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1"
        break;
        case 3:
            urlString = "\(Constants.baseUrl)3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1"
        break;
        default:
        break;
        }
        
        guard let urlString = urlString else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        APICaller.shared.getMovies(urlString: urlString) { result in
            switch(result){
            case .success(let movies):
                cell.configure(items: movies)
                break;
            case .failure(_):
                break;
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}



extension HomeViewController : CollectionViewTableViewCellDidCellTapedDelegate {
    func collectionViewTableViewCellDidCellTaped(videoData: VideoModel, movieDetails: MovieItemResponse) {
        DispatchQueue.main.async {
            let vc = MovieDetailsViewController()
            vc.configure(videoData:videoData,movieDetails: movieDetails )
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }

}


extension HomeViewController : HeroHeaderUIViewCellDidTapped {
    func heroHeaderUIViewCellDidTapped(videoData: VideoModel, movieDetails: MovieItemResponse) {
        let vc = MovieDetailsViewController()
        vc.configure(videoData: videoData, movieDetails: movieDetails)
        navigationController?.pushViewController(vc, animated: true)
    }
}
