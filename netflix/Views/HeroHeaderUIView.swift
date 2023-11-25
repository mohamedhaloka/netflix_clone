//
//  HeroHeaderUIView.swift
//  netflix
//
//  Created by Mohamed Nasr on 09/11/2023.
//

import UIKit

protocol HeroHeaderUIViewCellDidTapped : AnyObject {
    func heroHeaderUIViewCellDidTapped(videoData : VideoModel,movieDetails : MovieItemResponse)
}

class HeroHeaderUIView: UIView {
    
    
    private var movieDetails : MovieItemResponse?
    
   weak var delegate : HeroHeaderUIViewCellDidTapped?
    
    private let downloadButton : UIButton =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemRed
        return button
    }()
    
    
    private let playButton : UIButton =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView;
    }()
    
    private let netflixLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "netflix-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerImageView)

        _addGradientLayer();
        
        addSubview(playButton)
        addSubview(downloadButton)
        addSubview(netflixLogo)
        _addConstrants();

    }
    
    private func _addGradientLayer(){
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor,
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    
    private func _addConstrants(){
        let playButtonConstraints = [
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 80),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(playButtonConstraints)


        let downlaodButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -80),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(downlaodButtonConstraints)
        
        let netflixLogoConstraints = [
            netflixLogo.widthAnchor.constraint(equalToConstant: 60),
            netflixLogo.heightAnchor.constraint(equalToConstant: 70),
            netflixLogo.leadingAnchor.constraint(equalTo: leadingAnchor),

        ]
        NSLayoutConstraint.activate(netflixLogoConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = bounds
    }
    
    
    
    func configue(movie : MovieItemResponse?){
        guard let movie = movie, let posterPath = movie.poster_path ,let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
            return
        }
        
        movieDetails = movie
        headerImageView.sd_setImage(with: url)
        
        playButton.addTarget(self, action: #selector(onTapPlay), for: .touchUpInside)
    }
    
    @objc func onTapPlay(button: UIButton){
        
        guard let movie = movieDetails, let movieTitle = movie.original_name ?? movie.original_title else {
            return
        }
        APICaller.shared.getYoutubeVideoDetials(videoTitle: movieTitle) { result in
            switch(result){
            case .success(let video):
                DispatchQueue.main.async {
                    self.delegate?.heroHeaderUIViewCellDidTapped(videoData: video, movieDetails: movie)
                }
                break;
            case .failure(let error):
                print("ERROR VIDEO DATA \(error.localizedDescription)")
                break;
            }
        }
    }

}
