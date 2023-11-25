//
//  UpComingTableViewCell.swift
//  netflix
//
//  Created by Mohamed Nasr on 17/11/2023.
//

import UIKit

class UpComingTableViewCell: UITableViewCell {
    
    static let idntifier : String = "UpComingTableViewCell"
    
    
    
    private let movieImageView : UIImageView = {
        let imageView : UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    private let movieTitle : UILabel = {
        let uiLabel : UILabel = UILabel()
        uiLabel.numberOfLines = 2
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()
    
    private let playIconButton : UIButton = {
        
        let button : UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(playIconButton)

        configureLayout()
    }
    
    
    private func configureLayout(){
        
        let movieImageLayoutConstraints = [
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(movieImageLayoutConstraints)
        


        let playCircleIconLayoutConstraints = [
            playIconButton.leadingAnchor.constraint(equalTo: trailingAnchor,constant: -30),
            playIconButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playIconButton.heightAnchor.constraint(equalToConstant: 30),
            playIconButton.widthAnchor.constraint(equalToConstant: 30),
        ]
        
        NSLayoutConstraint.activate(playCircleIconLayoutConstraints)

        
        let movieTitleLayoutConstraints = [
            movieTitle.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor,constant: 10),
            movieTitle.trailingAnchor.constraint(equalTo: playIconButton.leadingAnchor),
            movieTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]


        NSLayoutConstraint.activate(movieTitleLayoutConstraints)


    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func configure(movie : MovieItemResponse){
        let fullUrl : String = "https://image.tmdb.org/t/p/w500/\(movie.poster_path ?? "")"
        movieImageView.sd_setImage(with: URL(string: fullUrl))
        
        movieTitle.text = movie.original_name ?? movie.original_title ?? "N/A"
    }
    
}
