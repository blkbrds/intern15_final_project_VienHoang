//
//  AppDelegate.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = self.window
        
        let homeVC = HomeViewController()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        homeNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))

        let favoritesVC = FavoriteViewController()
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorite"), selectedImage: UIImage(named: "favorite"))

        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchNavi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search"), tag: 2)

        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [homeNavi, favoritesNavi, searchNavi]
        tabbarController.tabBar.tintColor = #colorLiteral(red: 0.2078431373, green: 0.1843137255, blue: 0.3294117647, alpha: 1)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabbarController
        self.window = window
        window.makeKeyAndVisible()

        let Tcontroller = self.window?.rootViewController as? UITabBarController
        Tcontroller?.tabBar.barTintColor = #colorLiteral(red: 0.2588235294, green: 0.2470588235, blue: 0.3725490196, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.2588235294, green: 0.2470588235, blue: 0.3725490196, alpha: 1)
        return true
    }
}

