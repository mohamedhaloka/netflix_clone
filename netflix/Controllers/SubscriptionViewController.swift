//
//  SubscriptionViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 23/11/2023.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    
    private let featuresList  = [
        FeatureModel(title: "+1,000",
                     subTitle: "Movies",
                     imageSrcNamed: "image1",
                     gradientLayerColors: [
                        UIColor.systemRed.withAlphaComponent(0.8).cgColor,
                        UIColor.systemPurple.withAlphaComponent(0.8).cgColor
                     ]),
        FeatureModel(title: "+1,500",
                     subTitle: "TV Series",
                     imageSrcNamed: "image2",
                     gradientLayerColors: [
                        UIColor.systemGreen.withAlphaComponent(0.8).cgColor,
                        UIColor.systemCyan.withAlphaComponent(0.8).cgColor
                     ]
                    ),
        FeatureModel(title: "Unlimited",
                     subTitle: "Downloads",
                     imageSrcNamed: "image3",
                     gradientLayerColors: [
                        UIColor.systemMint.withAlphaComponent(0.8).cgColor,
                        UIColor.systemPink.withAlphaComponent(0.8).cgColor
                     ]
                    ),
        FeatureModel(title: "Monthly",
                     subTitle: "Suggestion",
                     imageSrcNamed: "image4",
                     gradientLayerColors: [
                        UIColor.systemBlue.withAlphaComponent(0.8).cgColor,
                        UIColor.systemIndigo.withAlphaComponent(0.8).cgColor
                     ]
                    ),
    ]
    
    private let scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
  private  let bannerImage : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "banner")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let closeButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private  let bannerContent : UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let appNameTextView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Movietflix"
        label.numberOfLines = 0
        label.tintColor = .white
        return label
    }()
    
    private let proVersionView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let proVersionTextView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pro".uppercased()
        label.font = .systemFont(ofSize: 14,weight: .bold)
        return label
    }()
    
    private let bannerTitleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "Unlock all features"
        label.numberOfLines = 0
        return label
    }()
    
    private let bannerSubTitleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Over 10,000 movies, tv series & more"
        label.numberOfLines = 0
        return label
    }()
    
    private  let featuresContentView : UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let featureTitleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "What's Included"
        label.numberOfLines = 0
        return label
    }()
    
    private let featureSubTitleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Plus daily updates to out massive library"
        label.numberOfLines = 0
        return label
    }()
    
    private let featuresTableView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.itemSize = CGSize(width: 180, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let plansView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let planTitleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGray2
        label.text = "Plan after 7-day free trial end"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let expireOfferTextView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemRed
        label.text = "Offer expires after 8h"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let startMy7DayTrialButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START MY 7-DAY FREE TRIAL", for: .normal)
        button.backgroundColor =  UIColor.init(0xFea5550)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    private let perYearPlanView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemRed.cgColor
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let perYearPlanTitleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 Year".uppercased()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let perYearPlanPriceView : UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "$29.99".uppercased()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 22,weight: .semibold)
         return label
    }()
    
    private let perYearPlanSubTitleView : UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Just $2.49 per month!".uppercased()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 12,weight: .semibold)
         label.numberOfLines = 0
         label.textColor = .systemRed
         return label
    }()
    
    private let perMonthPlanView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let perMonthPlanTitleView : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 Month"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let perMonthPlanPriceView : UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "$4.99/mo".uppercased()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22,weight: .semibold)
         return label
    }()
    
    private let perMonthPlanSubTitleView : UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "$4.99 billed monthly".uppercased()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12,weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .systemGray2
         return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        featuresTableView.delegate = self
        featuresTableView.dataSource = self
        configureScrollView()
        configureImageBanner()
        configureBannerContent()
        configureContentView()
        configurePlansView()
    }
    
    private func configureScrollView(){
        view.addSubview(scrollView)
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
    }
    
    
    private func configureImageBanner(){
        let heightOfBanner = 180.0
        scrollView.addSubview(bannerImage)
        
        let bannerImageConstraints = [
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImage.heightAnchor.constraint(equalToConstant: heightOfBanner),
        ]
        
        NSLayoutConstraint.activate(bannerImageConstraints)
        
        let gradientLayer  = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.systemBlue.withAlphaComponent(0.8).cgColor,
            UIColor.purple.withAlphaComponent(0.8).cgColor
        ]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: heightOfBanner)
        
        bannerImage.layer.addSublayer(gradientLayer)
        
        view.addSubview(closeButton)
        
        let closeButtonConstraints = [
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
        ]
        
        NSLayoutConstraint.activate(closeButtonConstraints)
        
        closeButton.addTarget(self, action: #selector(onCloseTapped), for: .touchUpInside)
    }

    
    @objc func onCloseTapped (button : UIButton) {
        dismiss(animated: true)
    }
    
    
    private func configureBannerContent(){
        bannerImage.addSubview(bannerContent)
        
        let bannerContentConstraints = [
            bannerContent.topAnchor.constraint(equalTo: view.topAnchor,constant: 35),
            bannerContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            bannerContent.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -20),
            bannerContent.bottomAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(bannerContentConstraints)
        
        bannerContent.addSubview(appNameTextView)
        bannerContent.addSubview(bannerTitleView)
        bannerContent.addSubview(bannerSubTitleView)
        
        let appNameTextViewConstraints = [
            appNameTextView.topAnchor.constraint(equalTo: bannerContent.topAnchor),
            appNameTextView.leadingAnchor.constraint(equalTo: bannerContent.leadingAnchor),
        ]
        
        NSLayoutConstraint.activate(appNameTextViewConstraints)
        
        
        bannerContent.addSubview(proVersionView)
        
        let proVersionConstraints = [
            proVersionView.leadingAnchor.constraint(equalTo: appNameTextView.trailingAnchor,constant: 10),
        ]
        
        NSLayoutConstraint.activate(proVersionConstraints)

        proVersionView.addSubview(proVersionTextView)
        
        let proVersionTextViewConstraints = [
            proVersionTextView.topAnchor.constraint(equalTo: proVersionView.topAnchor,constant: 5),
            proVersionTextView.leadingAnchor.constraint(equalTo: proVersionView.leadingAnchor,constant: 10),
            proVersionTextView.trailingAnchor.constraint(equalTo: proVersionView.trailingAnchor,constant: -10),
            proVersionTextView.bottomAnchor.constraint(equalTo: proVersionView.bottomAnchor,constant: -5),
        ]
        
        NSLayoutConstraint.activate(proVersionTextViewConstraints)

        
        
        let bannerTitleViewConstraints = [
            bannerTitleView.topAnchor.constraint(equalTo: appNameTextView.bottomAnchor,constant:35),
            bannerTitleView.leadingAnchor.constraint(equalTo: bannerContent.leadingAnchor),
            bannerTitleView.trailingAnchor.constraint(equalTo: bannerContent.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(bannerTitleViewConstraints)
        
        let bannerSubTitleViewConstraints = [
            bannerSubTitleView.topAnchor.constraint(equalTo: bannerTitleView.bottomAnchor,constant:20),
            bannerSubTitleView.leadingAnchor.constraint(equalTo: bannerContent.leadingAnchor),
            bannerSubTitleView.trailingAnchor.constraint(equalTo: bannerContent.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(bannerSubTitleViewConstraints)
        
    }
    
    
    private func configureContentView() {
        scrollView.addSubview(featuresContentView)
        
        
        let featuresContentViewConstraints = [
            featuresContentView.topAnchor.constraint(equalTo: bannerImage.bottomAnchor,constant: 10),
            featuresContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            featuresContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            featuresContentView.heightAnchor.constraint(equalToConstant: 200),
        ]
        
        NSLayoutConstraint.activate(featuresContentViewConstraints)
        
        
        featuresContentView.addSubview(featureTitleView)
        
        let fearureTitleViewConstraints = [
            featureTitleView.topAnchor.constraint(equalTo: featuresContentView.topAnchor),
            featureTitleView.leadingAnchor.constraint(equalTo: featuresContentView.leadingAnchor,constant: 10),
            featureTitleView.trailingAnchor.constraint(equalTo: featuresContentView.trailingAnchor,constant: -10),
        ]
        
        NSLayoutConstraint.activate(fearureTitleViewConstraints)
        
        featuresContentView.addSubview(featureSubTitleView)
        
        let fearureSubTitleViewConstraints = [
            featureSubTitleView.topAnchor.constraint(equalTo: featureTitleView.bottomAnchor,constant: 8),
            featureSubTitleView.leadingAnchor.constraint(equalTo: featuresContentView.leadingAnchor,constant: 10),
            featureSubTitleView.trailingAnchor.constraint(equalTo: featuresContentView.trailingAnchor,constant: -10),
        ]
        
        NSLayoutConstraint.activate(fearureSubTitleViewConstraints)
        
        featuresContentView.addSubview(featuresTableView)
        
        let fearureTableViewConstraints = [
            featuresTableView.topAnchor.constraint(equalTo: featureSubTitleView.bottomAnchor,constant: 10),
            featuresTableView.leadingAnchor.constraint(equalTo: featuresContentView.leadingAnchor),
            featuresTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            featuresTableView.bottomAnchor.constraint(equalTo: featuresContentView.bottomAnchor,constant: -20),
        ]
        
        NSLayoutConstraint.activate(fearureTableViewConstraints)
    }
    
    private func configurePlansView() {
        scrollView.addSubview(plansView)
        
        let plansViewConstraints = [
            plansView.topAnchor.constraint(equalTo: featuresContentView.bottomAnchor),
            plansView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            plansView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            plansView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(plansViewConstraints)
        
        
        plansView.addSubview(planTitleView)
     
        let planTitleViewConstraints = [
            planTitleView.topAnchor.constraint(equalTo: plansView.topAnchor,constant: 10),
            planTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            planTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(planTitleViewConstraints)
        
        
        plansView.addSubview(perYearPlanView)
        
        let perYearPlanViewConstraints = [
            perYearPlanView.topAnchor.constraint(equalTo: planTitleView.bottomAnchor,constant: 10),
            perYearPlanView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            perYearPlanView.widthAnchor.constraint(equalToConstant: (view.bounds.width/2)-20),
            perYearPlanView.heightAnchor.constraint(equalToConstant: 180),
        ]
        
        NSLayoutConstraint.activate(perYearPlanViewConstraints)
        
        
        ///Add Year Plan Layout
        perYearPlanView.addSubview(perYearPlanTitleView)
        
        let perYearPlanTitleViewConstraints = [
            perYearPlanTitleView.topAnchor.constraint(equalTo: perYearPlanView.topAnchor,constant: 20),
            perYearPlanTitleView.leadingAnchor.constraint(equalTo: perYearPlanView.leadingAnchor,constant: 10),
            perYearPlanTitleView.trailingAnchor.constraint(equalTo: perYearPlanView.trailingAnchor,constant: -10),
        ]
        
        NSLayoutConstraint.activate(perYearPlanTitleViewConstraints)
        
        perYearPlanView.addSubview(perYearPlanPriceView)
        
        let perYearPlanPriceViewConstraints = [
            perYearPlanPriceView.leadingAnchor.constraint(equalTo: perYearPlanView.leadingAnchor,constant: 10),
            perYearPlanPriceView.trailingAnchor.constraint(equalTo: perYearPlanView.trailingAnchor,constant: -10),
            perYearPlanPriceView.centerYAnchor.constraint(equalTo: perYearPlanView.centerYAnchor),
            perYearPlanPriceView.centerXAnchor.constraint(equalTo: perYearPlanView.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(perYearPlanPriceViewConstraints)
        
        perYearPlanView.addSubview(perYearPlanSubTitleView)
        
        let perYearPlanSubTitleViewConstraints = [
            perYearPlanSubTitleView.bottomAnchor.constraint(equalTo: perYearPlanView.bottomAnchor,constant: -20),
            perYearPlanSubTitleView.leadingAnchor.constraint(equalTo: perYearPlanView.leadingAnchor,constant: 10),
            perYearPlanSubTitleView.trailingAnchor.constraint(equalTo: perYearPlanView.trailingAnchor,constant: -10),
        ]
        
        NSLayoutConstraint.activate(perYearPlanSubTitleViewConstraints)
        
        
        plansView.addSubview(perMonthPlanView)
        
        let perMonthPlanViewConstraints = [
            perMonthPlanView.topAnchor.constraint(equalTo: planTitleView.bottomAnchor,constant: 10),
            perMonthPlanView.leadingAnchor.constraint(equalTo: perYearPlanView.trailingAnchor,constant: 10),
            perMonthPlanView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            perMonthPlanView.heightAnchor.constraint(equalToConstant: 180),
        ]
        
        NSLayoutConstraint.activate(perMonthPlanViewConstraints)
        
        ///Add Month Plan Layout
        perMonthPlanView.addSubview(perMonthPlanTitleView)
        
        let perMonthPlanTitleViewConstraints = [
            perMonthPlanTitleView.topAnchor.constraint(equalTo: perMonthPlanView.topAnchor,constant: 20),
            perMonthPlanTitleView.leadingAnchor.constraint(equalTo: perMonthPlanView.leadingAnchor,constant: 10),
            perMonthPlanTitleView.trailingAnchor.constraint(equalTo: perMonthPlanView.trailingAnchor,constant: -10),
        ]
        
        NSLayoutConstraint.activate(perMonthPlanTitleViewConstraints)
        
        perMonthPlanView.addSubview(perMonthPlanPriceView)
        
        let perMonthPlanPriceViewConstraints = [
            perMonthPlanPriceView.leadingAnchor.constraint(equalTo: perMonthPlanView.leadingAnchor,constant: 10),
            perMonthPlanPriceView.trailingAnchor.constraint(equalTo: perMonthPlanView.trailingAnchor,constant: -10),
            perMonthPlanPriceView.centerYAnchor.constraint(equalTo: perMonthPlanView.centerYAnchor),
            perMonthPlanPriceView.centerXAnchor.constraint(equalTo: perMonthPlanView.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(perMonthPlanPriceViewConstraints)
        
        perMonthPlanView.addSubview(perMonthPlanSubTitleView)
        
        let perMonthPlanSubTitleViewConstraints = [
            perMonthPlanSubTitleView.bottomAnchor.constraint(equalTo: perMonthPlanView.bottomAnchor,constant: -20),
            perMonthPlanSubTitleView.leadingAnchor.constraint(equalTo: perMonthPlanView.leadingAnchor,constant: 10),
            perMonthPlanSubTitleView.trailingAnchor.constraint(equalTo: perMonthPlanView.trailingAnchor,constant: -10),
        ]
        
        NSLayoutConstraint.activate(perMonthPlanSubTitleViewConstraints)
        
        ///Add Expire Offer Text
        plansView.addSubview(expireOfferTextView)
     
        let expireOfferTextViewConstraints = [
            expireOfferTextView.topAnchor.constraint(equalTo: perMonthPlanView.bottomAnchor,constant: 20),
            expireOfferTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expireOfferTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(expireOfferTextViewConstraints)
        
        ///Add Button in the end of page

        plansView.addSubview(startMy7DayTrialButton)
        
        let startMy7DayTrialButtonConstraints = [
            startMy7DayTrialButton.topAnchor.constraint(equalTo: expireOfferTextView.bottomAnchor,constant: 10),
            startMy7DayTrialButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            startMy7DayTrialButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            startMy7DayTrialButton.heightAnchor.constraint(equalToConstant: 50),
            startMy7DayTrialButton.bottomAnchor.constraint(equalTo: plansView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(startMy7DayTrialButtonConstraints)
        
        startMy7DayTrialButton.addTarget(self, action: #selector(proccessPayment), for: .touchUpInside)
        
        let yearPlanGesture = UITapGestureRecognizer(target: self, action: #selector(onYearPlanTapped))
        perYearPlanView.addGestureRecognizer(yearPlanGesture)


        let monthPlanGesture = UITapGestureRecognizer(target: self, action: #selector(onMonthlyPlanTapped))
        perMonthPlanView.addGestureRecognizer(monthPlanGesture)
    }
    
    
    @objc  private func proccessPayment(button : UIButton){
        let alert = UIAlertController(title: nil, message: "Proccess Payment", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)

        present(alert, animated: true)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.dismessAlert), userInfo: nil, repeats: false)

    }
    
    @objc private func dismessAlert() {
        dismiss(animated: true)
    }
    
    
    @objc private func onYearPlanTapped(){
        perYearPlanView.layer.borderColor = UIColor.systemRed.cgColor
        perYearPlanView.layer.borderWidth = 2
        perYearPlanView.backgroundColor = .systemBackground
        perYearPlanSubTitleView.textColor = .systemRed

        perMonthPlanView.layer.borderWidth = 0
        perMonthPlanView.backgroundColor = .black
        perMonthPlanSubTitleView.textColor = .systemGray2

    }
    
    @objc private func onMonthlyPlanTapped(){
        perMonthPlanView.layer.borderColor = UIColor.systemRed.cgColor
        perMonthPlanView.layer.borderWidth = 2
        perMonthPlanView.backgroundColor = .systemBackground
        perMonthPlanSubTitleView.textColor = .systemRed

        perYearPlanView.layer.borderWidth = 0
        perYearPlanView.backgroundColor = .black
        perYearPlanSubTitleView.textColor = .systemGray2

    }
    
    
}

extension SubscriptionViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuresList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCollectionViewCell.identifier, for: indexPath) as? FeatureCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(feature: featuresList[indexPath.row])
        return cell
    }
}
