//  AppDelegate.swift
//  ex01-Viewer
//
//  Created by CHH51 on 12/6/18.

import UIKit
import layout
import model

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LayoutNode.useLegacyLayoutMode = false
        model.FixedAssets.loadAll()

        window = UIWindow()
        window?.rootViewController = TableViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

