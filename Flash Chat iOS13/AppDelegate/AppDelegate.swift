//
//  AppDelegate.swift
//  Flash Chat iOS13
//
//  Created by Shruti on 21/05/2020.
//  Copyright © 2020 Shruti. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    let db = Firestore.firestore()
    print("db is - \(db)")
    
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.enableAutoToolbar = false
    IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    
    return true
  }

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role
    )
  }
  
  func application(
    _ application: UIApplication,
    didDiscardSceneSessions sceneSessions: Set<UISceneSession>
  ) {
  }
}
