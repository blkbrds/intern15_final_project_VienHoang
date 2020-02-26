//
//  SceneDelegate.swift
//  FoodiezRestaurantApp
//
//  Created by user on 2/26/20.
//  Copyright © 2020 VienH. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    enum TypeScreen {
        case tabbar
    }

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()

        changeScreen(type: .tabbar)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

    private func createTabbar() {

        let homeVC = HomeViewController()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        homeNavi.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))

        let messagesVC = FavoritesViewController()
        let messagesNavi = UINavigationController(rootViewController: messagesVC)
        messagesNavi.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite"), selectedImage: UIImage(named: "favorite"))

        let friendsVC = SearchViewController()
        let friendsNavi = UINavigationController(rootViewController: friendsVC)
        friendsNavi.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 2)

        let profileVC = TrendingViewController()
        let profileNavi = UINavigationController(rootViewController: profileVC)
        profileNavi.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(named: "trending"), tag: 3)

        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [homeNavi, messagesNavi, friendsNavi, profileNavi]
        tabbarController.tabBar.tintColor = .red

        window?.rootViewController = tabbarController
    }

    func changeScreen(type: TypeScreen) {
        switch type {
        case .tabbar:
            createTabbar()
        }
    }
}

extension SceneDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected Tab : \(tabBarController.selectedIndex)")
    }
}
