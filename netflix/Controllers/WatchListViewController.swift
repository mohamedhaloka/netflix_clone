//
//  WatchListViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 22/11/2023.
//

import UIKit
import WebKit

class WatchListViewController: UIViewController {

    private var movies  : [MovieItemResponse] = []
    
    private var page = 1;
    
    private  let webView : WKWebView = {
          let webView = WKWebView()
          webView.translatesAutoresizingMaskIntoConstraints = false
          return webView
      }()
    
    private  let movieTitle : UILabel = {
          let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
          return label
      }()
    
  private  let collectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.itemSize = CGSize(width: 130, height: 200)
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(movieTitle)
        view.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self

        _configureWebView()
        _configureMovieTitle()
        _configureCollectionView()
        getTrendingMovies()
    }
    
    
    private func getTrendingMovies(){
        APICaller.shared.getMovies(urlString: "\(Constants.baseUrl)3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=\(page)") { result in
            switch(result){
            case .success(let movies):
                self.movies.append(contentsOf: movies)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                guard self.page == 1 else {
                    return
                }
                
                    if movies.isEmpty {
                        return
                    }
                    
                    guard let movieTitle = movies.first?.original_name ?? movies.first?.original_title else {
                        return
                    }
                
                    self.openMovieTrailler(movieTitle: movieTitle)
            
                break;
            case .failure(_):
                self.page = self.page  - 1
                break;
            }
        }
    }
    
    
    private func showAlertDialog(withMessage: String?){
        let alert = UIAlertController(title: nil, message:withMessage, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)

    }
    
    
    private func openMovieTrailler(movieTitle : String) {
        DispatchQueue.main.async {
            self.showAlertDialog(withMessage: "Please wait ...")
            self.movieTitle.text = movieTitle
        }
        
        APICaller.shared.getYoutubeVideoDetials(videoTitle: movieTitle) { result in
            switch result {
            case .success(let videoDetails):
                guard let videoIdModel = videoDetails.id , let videoId = videoIdModel.videoId , let url = URL(string: "https://www.youtube.com/watch?v=\(videoId)") else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.webView.load(URLRequest(url: url))
                    self.dismiss(animated: true, completion: nil)
                }
                break;
            case .failure(let error):
                print("Error while getting error '\(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    
                    let alertDialog = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                    self.present(alertDialog, animated: true)
                }
                break;
            }
        }
    }
    
    @objc func dismessDialog() {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    private func _configureWebView(){
        webView.scrollView.isScrollEnabled = false
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 190)
        ]
        NSLayoutConstraint.activate(webViewConstraints)
    }
    
    private func _configureMovieTitle(){

        let movieTitleConstraints = [
            movieTitle.topAnchor.constraint(equalTo: webView.bottomAnchor,constant: 5),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(movieTitleConstraints)
    }
    
    private func _configureCollectionView(){
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}


extension WatchListViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(movie: movies[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            
            guard let movieTitle = self.movies[indexPath.row].original_name ?? self.movies[indexPath.row].original_title else {
                return
            }
            
            self.openMovieTrailler(movieTitle: movieTitle)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 {
            self.page = self.page + 1
            
            getTrendingMovies()
        }
    }

}
