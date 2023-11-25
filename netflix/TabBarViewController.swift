//
//  ViewController.swift
//  netflix
//
//  Created by Mohamed Nasr on 04/11/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpComingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        
        vc1.tabBarItem.title = "Home"
        vc1.tabBarItem.image = UIImage(systemName: "house")

        vc2.tabBarItem.title = "Upcoming"
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")

        vc3.tabBarItem.title = "Search"
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        vc4.tabBarItem.title = "Downloads"
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        tabBar.tintColor = .label

        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }


}

