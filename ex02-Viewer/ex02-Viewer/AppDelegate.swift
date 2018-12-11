//  AppDelegate.swift
//  ex02-Viewer
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
        
        window                      = UIWindow()
        window?.rootViewController  = StoryViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

