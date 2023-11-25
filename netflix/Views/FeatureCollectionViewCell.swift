//
//  FeatureCollectionViewCell.swift
//  netflix
//
//  Created by Mohamed Nasr on 24/11/2023.
//

import UIKit

class FeatureCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeatureCollectionViewCell"
    
    private let contentBGView : UIView  = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let checkButton : UIButton  = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        let imageView = UIImage(systemName: "checkmark")
        button.setImage(imageView, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        return button
    }()
    
    private let contentImageView : UIImageView  = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "banner")
        return imageView
    }()
    
    private let titleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "+1,000"
        label.numberOfLines = 0
        return label
    }()
    
    private let subTitleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Templates"
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureContentView()
        configureImageContentView()
        configureTitleAndSubTitle()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureContentView(){
        addSubview(contentBGView)

        let contentBGViewConstraints = [
            contentBGView.topAnchor.constraint(equalTo: topAnchor,constant: 42),
            contentBGView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBGView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            contentBGView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -32),
        ]
        
        NSLayoutConstraint.activate(contentBGViewConstraints)
        
        addSubview(checkButton)

        let checkButtonConstraints = [
            checkButton.topAnchor.constraint(equalTo: topAnchor,constant: 32),
            checkButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 25),
            checkButton.widthAnchor.constraint(equalToConstant: 25),
        ]
        
        NSLayoutConstraint.activate(checkButtonConstraints)
    }
    
    private func configureImageContentView(){
        contentBGView.addSubview(contentImageView)
        
        let contentImageViewConstraints = [
            contentImageView.topAnchor.constraint(equalTo: topAnchor),
            contentImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(contentImageViewConstraints)
        
    }
    
    
    private func configureTitleAndSubTitle(){
        contentBGView.addSubview(titleView)
        
        let titleViewConstraints = [
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 10),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
        ]
        
        NSLayoutConstraint.activate(titleViewConstraints)
        
        contentBGView.addSubview(subTitleView)
        
        let subTitleViewConstraints = [
            subTitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor,constant: 5),
            subTitleView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 10),
            subTitleView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            subTitleView.bottomAnchor.constraint(equalTo: contentBGView.bottomAnchor,constant: -15)
        ]
        
        NSLayoutConstraint.activate(subTitleViewConstraints)
    }
    
    func configure(feature : FeatureModel){
        titleView.text = feature.title
        subTitleView.text = feature.subTitle
        
        contentImageView.image = UIImage(named: feature.imageSrcNamed)
        setGradientLayer(feature.gradientLayerColors)
    }
    
    
    private func setGradientLayer(_ gradientLayerColors : [Any]){
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientLayerColors
        contentImageView.layer.addSublayer(gradientLayer)
    }
}
