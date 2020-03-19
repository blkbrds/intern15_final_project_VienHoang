//
//  SceneDelegate.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let homeVC = HomeViewController()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        homeNavi.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))

        let favoritesVC = FavoritesViewController()
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesNavi.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite"), selectedImage: UIImage(named: "favorite"))

        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchNavi.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 2)

        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [homeNavi, favoritesNavi, searchNavi]
        tabbarController.tabBar.tintColor = #colorLiteral(red: 0.2078431373, green: 0.1843137255, blue: 0.3294117647, alpha: 1)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabbarController
        self.window = window
        window.makeKeyAndVisible()

        let Tcontroller = self.window?.rootViewController as? UITabBarController
        Tcontroller?.tabBar.barTintColor = #colorLiteral(red: 0.2588235294, green: 0.2470588235, blue: 0.3725490196, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.2588235294, green: 0.2470588235, blue: 0.3725490196, alpha: 1)
    }
}
