//
//  MovieDetailsViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 19/11/2023.
//

import UIKit
import WebKit

class MovieDetailsViewController: UIViewController {
    
    var videoId : String = ""
    
    private let bgImage : UIImageView = {
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gradientView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieImage : UIImageView = {
        let imageView : UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieTitle : UILabel = {
        let label : UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.numberOfLines = 4
        return label
    }()
    
    private let movieSeasonBtn : UIButton = {
        let button : UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(0xFd9d9d9)
        button.layer.cornerRadius = 12
        button.setTitleColor(UIColor.init(0xF474546), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)

        return button
    }()
    
    private let movieRate : UILabel = {
        let label : UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let movieDescription : UILabel = {
        let label : UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    
    private let watchButton : UIButton = {
        let button : UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Watch", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(0xFe20914)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.showsVerticalScrollIndicator = true
        v.isDirectionalLockEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        configureBG()
        view.addSubview(scrollView)

        _configureMovieImage()

        scrollView.addSubview(movieTitle)
        scrollView.addSubview(movieSeasonBtn)
        scrollView.addSubview(movieRate)
        scrollView.addSubview(watchButton)
        scrollView.addSubview(gradientView)
        scrollView.addSubview(movieDescription)

        
        _configureLayout()

        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    private func configureBG(){
        view.addSubview(bgImage)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        bgImage.frame = view.bounds
        blurEffectView.frame = bgImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    
    private func _configureMovieImage(){
        scrollView.addSubview(movieImage)

        let posterHeight = UIScreen.main.bounds.height/1.8
        let movieImageConstrainets = [
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: posterHeight),
        ]
        
        NSLayoutConstraint.activate(movieImageConstrainets)

        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor,
        ]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: posterHeight)

        scrollView.layer.addSublayer(gradientLayer)
        
    }
    
    
    private func _configureLayout(){
        let scrollViewConstrainets = [
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(scrollViewConstrainets)


        let movieTitleConstrainets = [
            movieTitle.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor,constant: -160),
            movieTitle.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor,constant: 20),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        ]
        NSLayoutConstraint.activate(movieTitleConstrainets)

        
        let movieSeasonBtnConstrainets = [
            movieSeasonBtn.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant: 20),
            movieSeasonBtn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            movieSeasonBtn.widthAnchor.constraint(equalToConstant: 150),
        ]
        NSLayoutConstraint.activate(movieSeasonBtnConstrainets)

        let movieRateConstrainets = [
            movieRate.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor,constant: -110),
            movieRate.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        ]
        NSLayoutConstraint.activate(movieRateConstrainets)
        
        let gradientViewConstrainets = [
            gradientView.topAnchor.constraint(equalTo: movieImage.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 60),
        ]
        
        NSLayoutConstraint.activate(gradientViewConstrainets)
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.clear.cgColor,
        ]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)

        gradientView.layer.addSublayer(gradientLayer)
        
        let movieDescriptionConstrainets = [
            movieDescription.topAnchor.constraint(equalTo: movieImage.bottomAnchor,constant: 15),
            movieDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            movieDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(movieDescriptionConstrainets)


        let watchButtonConstrainets = [
            watchButton.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor,constant: -30),
            watchButton.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor,constant: 20),
            watchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            watchButton.heightAnchor.constraint(equalToConstant: 60),
        ]
        
        NSLayoutConstraint.activate(watchButtonConstrainets)

    }
    
    
    
    func configure(videoData : VideoModel,movieDetails : MovieItemResponse ){
        
        videoId = videoData.id!.videoId!
        movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails.poster_path!)"))
        bgImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails.poster_path!)"))
        movieTitle.text = movieDetails.original_name ?? movieDetails.original_title ?? "N/A"
        movieDescription.text = movieDetails.overview
        movieSeasonBtn.setTitle("Season2 . 9 Episods", for: .normal)
        movieRate.text = "9.0/10 (\(movieDetails.vote_count))"
        
        watchButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    }
    
    
    @objc func handleRegister(sender: UIButton){
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(videoId)"), UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }

}

extension UIScrollView {
   func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
