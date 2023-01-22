//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Beliy.Bear on 23.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
    
    func createHabitViewController() -> UINavigationController {
        let habitsViewController = HabitsViewController()
        habitsViewController.title = "Привычки"
        habitsViewController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        return UINavigationController(rootViewController: habitsViewController)
    }
    
    func createInfoViewController() -> UINavigationController {
    let infoViewController = InfoViewController()
    infoViewController.tabBarItem = UITabBarItem(title: "Инфо", image: UIImage(systemName: "info.circle.fill"), tag: 1)
    return UINavigationController(rootViewController: infoViewController)
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().tintColor = UIColor(named: "CustomViolet")
        UITabBar.appearance().backgroundColor = UIColor(named: "CustomGrey")
        tabBarController.viewControllers = [createHabitViewController(), createInfoViewController()]
        return tabBarController
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


}
