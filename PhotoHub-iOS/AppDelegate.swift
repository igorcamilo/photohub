//
//  AppDelegate.swift
//  PhotoHub-iOS
//
//  Created by Igor Camilo on 01/03/17.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow? = UIWindow()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window?.rootViewController = UINavigationController(rootViewController: PostsViewController())
    window?.makeKeyAndVisible()
    
    return true
  }
}
