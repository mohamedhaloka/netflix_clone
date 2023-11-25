//
//  ProfileViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 21/11/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    private let scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let imageBg : UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "personal-photo")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let profileImage : UIImageView = {
       let image = UIImageView()
         image.image = UIImage(named: "personal-photo")
         image.contentMode = .scaleToFill
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Mohamed Nasr"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    private let accountTypeView : UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let accountTypeLabel : UILabel = {
       let label = UILabel()
        label.text = "Free"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let getPremiumButton : UIButton = {
       let button = UIButton()
        button.setTitle("GET PREMIUM", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .orange
        return button
    }()
    
    private let downloadContentView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let downloadIconView : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        button.imageView?.tintColor = .white
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let downloadTitle : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Downloads"
        return label
    }()
    
    
    private let rateUsContentView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let rateUsIconView : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "highlighter"), for: .normal)
        button.imageView?.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let rateUsTitle : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Rate US"
        return label
    }()
    
    private let subscriptionContentView : UIView = {
       let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let subscriptionIconView : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "dollarsign"), for: .normal)
        button.imageView?.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let subscriptionTitle : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Your Subscription"
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)

        
        scrollView.addSubview(imageBg)
        scrollView.addSubview(profileImage)
        view.addSubview(usernameLabel)
        view.addSubview(accountTypeView)
        accountTypeView.addSubview(accountTypeLabel)
        view.addSubview(getPremiumButton)
        scrollView.addSubview(downloadContentView)
        downloadContentView.addSubview(downloadIconView)
        downloadContentView.addSubview(downloadTitle)
        scrollView.addSubview(rateUsContentView)
        rateUsContentView.addSubview(rateUsIconView)
        rateUsContentView.addSubview(rateUsTitle)
        scrollView.addSubview(subscriptionContentView)
        subscriptionContentView.addSubview(subscriptionIconView)
        subscriptionContentView.addSubview(subscriptionTitle)

        
        configureImageBG()
        configureTitleAndSubTitle()
        configureDownloadContentView()
        configureRateUsContentView()
        configureSubscriptionContentView()
    }

    
    private func configureImageBG(){
        
        let heightOfProfileHeader = 400.0
        
        ///Add Constraints
        let imageBgConstraints = [
            imageBg.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageBg.heightAnchor.constraint(equalToConstant: heightOfProfileHeader),
            imageBg.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ]
        
        NSLayoutConstraint.activate(imageBgConstraints)
        
        
        /// Add Blur to BG
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageBg.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageBg.addSubview(blurEffectView)
        
        /// Add Gradient LAyer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor,
        ]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightOfProfileHeader)
        imageBg.layer.addSublayer(gradientLayer)
    }
    
    private func configureTitleAndSubTitle(){
        let profileImageViewConstraints = [
            profileImage.centerYAnchor.constraint(equalTo: imageBg.centerYAnchor),
            profileImage.centerXAnchor.constraint(equalTo: imageBg.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
        ]
        
        NSLayoutConstraint.activate(profileImageViewConstraints)

        let usernmaeLabelConstraints = [
            usernameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(usernmaeLabelConstraints)
        
        let accountTypeViewConstraints = [
            accountTypeView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            accountTypeView.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 10),
            accountTypeView.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(accountTypeViewConstraints)
        
        let accountTypeConstraints = [
            accountTypeLabel.centerYAnchor.constraint(equalTo: accountTypeView.centerYAnchor),
            accountTypeLabel.centerXAnchor.constraint(equalTo: accountTypeView.centerXAnchor),
            accountTypeLabel.trailingAnchor.constraint(equalTo: accountTypeView.trailingAnchor,constant: -10),
            accountTypeLabel.leadingAnchor.constraint(equalTo: accountTypeView.leadingAnchor,constant: 10),
        ]
        
        NSLayoutConstraint.activate(accountTypeConstraints)


        let premiumButtonConstraints = [
            getPremiumButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getPremiumButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getPremiumButton.bottomAnchor.constraint(equalTo: imageBg.bottomAnchor, constant: -10),
            getPremiumButton.heightAnchor.constraint(equalToConstant: 55),
        ]
        
        NSLayoutConstraint.activate(premiumButtonConstraints)
        
        getPremiumButton.addTarget(self, action: #selector(goToSubscriptionSheet), for: .touchUpInside)
    }
    
    
    private func configureDownloadContentView(){
        
        let downloadContentViewButtonConstraints = [
            downloadContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            downloadContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            downloadContentView.topAnchor.constraint(equalTo: imageBg.bottomAnchor, constant: 20),
            downloadContentView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(downloadContentViewButtonConstraints)

        
        let downloadIconViewButtonConstraints = [
            downloadIconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloadIconView.widthAnchor.constraint(equalToConstant: 40),
            downloadIconView.topAnchor.constraint(equalTo: downloadContentView.topAnchor),
            downloadIconView.bottomAnchor.constraint(equalTo: downloadContentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(downloadIconViewButtonConstraints)
        
        let downloadTitleViewButtonConstraints = [
            downloadTitle.leadingAnchor.constraint(equalTo: downloadIconView.trailingAnchor, constant: 15),
            downloadTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            downloadTitle.centerYAnchor.constraint(equalTo: downloadContentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(downloadTitleViewButtonConstraints)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToDownloadPage))
        downloadContentView.addGestureRecognizer(gesture)
    }
    
    
   @objc private func goToDownloadPage(){
       self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![3]
    }
    
    private func configureRateUsContentView(){
        
        let rateUsContentViewButtonConstraints = [
            rateUsContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rateUsContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rateUsContentView.topAnchor.constraint(equalTo: downloadContentView.bottomAnchor, constant: 20),
            rateUsContentView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(rateUsContentViewButtonConstraints)

        
        let rateUsIconViewButtonConstraints = [
            rateUsIconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rateUsIconView.widthAnchor.constraint(equalToConstant: 40),
            rateUsIconView.topAnchor.constraint(equalTo: rateUsContentView.topAnchor),
            rateUsIconView.bottomAnchor.constraint(equalTo: rateUsContentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(rateUsIconViewButtonConstraints)
        
        let rateUsTitleViewButtonConstraints = [
            rateUsTitle.leadingAnchor.constraint(equalTo: rateUsIconView.trailingAnchor, constant: 15),
            rateUsTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            rateUsTitle.centerYAnchor.constraint(equalTo: rateUsIconView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(rateUsTitleViewButtonConstraints)

    }
    
    private func configureSubscriptionContentView(){
        
        let subscriptionContentViewButtonConstraints = [
            subscriptionContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subscriptionContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subscriptionContentView.topAnchor.constraint(equalTo: rateUsContentView.bottomAnchor, constant: 20),
            subscriptionContentView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(subscriptionContentViewButtonConstraints)

        let subscriptionIconViewButtonConstraints = [
            subscriptionIconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subscriptionIconView.widthAnchor.constraint(equalToConstant: 40),
            subscriptionIconView.topAnchor.constraint(equalTo: subscriptionContentView.topAnchor),
            subscriptionIconView.bottomAnchor.constraint(equalTo: subscriptionContentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(subscriptionIconViewButtonConstraints)
        
        let subscriptionTitleViewButtonConstraints = [
            subscriptionTitle.leadingAnchor.constraint(equalTo: subscriptionIconView.trailingAnchor, constant: 15),
            subscriptionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            subscriptionTitle.centerYAnchor.constraint(equalTo: subscriptionIconView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(subscriptionTitleViewButtonConstraints)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToSubscriptionSheet))
        subscriptionContentView.addGestureRecognizer(gesture)
    }
    
    @objc private func goToSubscriptionSheet(){
        let vc = SubscriptionViewController()
        present(vc, animated: true)
    }
}
