//
//  advertsSwiftUIApp.swift
//  advertsSwiftUI
//
//  Created by Nina Saveljeva on 10/7/2024.
//

import SwiftUI
import YandexMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    MobileAds.initializeSDK(completionHandler: {
        print("MobileAds initializeSDK completed!")
    })
    MobileAds.enableLogging()
      
    return true
  }
}


@main
struct advertsSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
