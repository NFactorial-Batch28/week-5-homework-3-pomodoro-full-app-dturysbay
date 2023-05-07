//
//  ViewController.swift
//  PomodoroUIKit
//
//  Created by Dinmukhambet Turysbay on 07.05.2023.
//

import UIKit



class TabBarView: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .white
        tabBar.tintColor = .white
        setupVCs()

    }

    func setupVCs(){
        viewControllers = [
            wrapInNavigationController(with: MainViewController(), tabTitle: "Main", tabImage: UIImage(named: "main-icon")!),
//            wrapInNavigationController(with: SettingsViewController(), tabTitle: "Settings", tabImage: UIImage(named: "settings-icon")!)
        ]
    }

    fileprivate func createNavController(
                                for rootViewController: UIViewController,
                                title: String,
                                image: UIImage) -> UIViewController{
        let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.title = title
                                    navController.tabBarItem.image = image
                                    return navController
    }
    
    
    func wrapInNavigationController(with rootViewController: UIViewController,
                                    tabTitle: String,
                                    tabImage: UIImage) -> UINavigationController
    {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = tabTitle
        navigationController.tabBarItem.image = tabImage
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationController?.title = tabTitle
        return navigationController
    }
    
}

