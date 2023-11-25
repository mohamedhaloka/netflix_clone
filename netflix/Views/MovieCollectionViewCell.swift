//
//  MovieCollectionViewCell.swift
//  netflix
//
//  Created by Mohamed Nasr on 16/11/2023.
//

import UIKit
import SDWebImage;

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "MovieCollectionViewCell"
    
    
    let movieImageView : UIImageView = {
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let movieTitle : UILabel = {
        let titleView : UILabel = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .clear
        titleView.textColor = .white
        titleView.font = UIFont.systemFont(ofSize: 12, weight: .bold)

        return titleView
    }()
    
    
    private let playButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.imageView?.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.isUserInteractionEnabled = false
        return button
    }()

    
    func sliceString(str: String, start: Int, end: Int) -> String {
        let data = Array(str)
        return data.count < end ? str :  String(data[start..<end]) + "..."
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(movieImageView)
        configureGradientBG()
        addSubview(movieTitle)
        addSubview(playButton)
        configurePlayArrowLayout()
        configureTextLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func configureGradientBG(){
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds

        layer.addSublayer(gradientLayer)
    }
    
    private func configureTextLayout(){
        let movieTitleConstrants = [
            movieTitle.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5),
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            movieTitle.widthAnchor.constraint(equalToConstant: 200),
            movieTitle.heightAnchor.constraint(equalToConstant: 30),
        ]
        
        NSLayoutConstraint.activate(movieTitleConstrants)
    }
    private func configurePlayArrowLayout(){
        let playArrowConstrants = [
            playButton.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 45),
            playButton.heightAnchor.constraint(equalToConstant: 45)
        ]
        
        NSLayoutConstraint.activate(playArrowConstrants)
    }
    
    
    func configure(movie: MovieItemResponse){
        
        if movie.poster_path != nil {
            
            let fullUrl : String = "https://image.tmdb.org/t/p/w500/\(movie.poster_path!)"
            movieImageView.sd_setImage(with: URL(string: fullUrl))

        }
        
        movieTitle.text =  sliceString(str: movie.original_title ?? movie.original_name ?? "N/A", start: 0, end: 16)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.frame = bounds
    }
    
}
