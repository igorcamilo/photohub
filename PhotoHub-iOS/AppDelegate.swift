//
//  AppDelegate.swift
//  PhotoHub-iOS
//
//  Created by Igor Camilo on 01/03/17.
//
//

import UIKit
import PhotoHubKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow? = UIWindow()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    Forum.get(id: "photography") { (result) in
      print("Forum", result)
    }
    Post.getList(forumId: "photography") { (result) in
      print("Posts", result)
    }
    
    window?.rootViewController = UITableViewController()
    window?.makeKeyAndVisible()
    
    return true
  }
}
