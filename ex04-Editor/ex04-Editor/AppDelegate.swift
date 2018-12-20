//  AppDelegate.swift
//  ex04-Editor
//
//  Created by CHH51 on 12/6/18.

import UIKit
import Layout
import Model

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_                              : UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LayoutNode.useLegacyLayoutMode = false
        Model.AssetsStory01.loadAll()
        Model.AssetsStory02.loadAll()
        
        let storiesController = StoriesViewController()
        let navController     = UINavigationController(rootViewController: storiesController)
        
        window                      = UIWindow()
        window?.rootViewController  = navController
        window?.makeKeyAndVisible()
        return true
    }
}

