//
//  AppDelegate.swift
//  FabbiAssigment
//
//  Created by Maoo on 03/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let vc = UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
    
}
