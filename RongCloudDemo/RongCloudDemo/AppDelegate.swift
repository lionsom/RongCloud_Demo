//
//  AppDelegate.swift
//  RongCloudDemo
//
//  Created by 启业云03 on 2022/11/24.
//

import NotificationToast
import RongIMKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // 连接状态监听器，设置代理委托
        RCIM.shared().connectionStatusDelegate = self

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

/*!
 IMKit连接状态的监听器
 @param status  SDK与融云服务器的连接状态
 @discussion 如果您设置了IMKit 连接监听之后，当SDK与融云服务器的连接状态发生变化时，会回调此方法。
 */
extension AppDelegate: RCIMConnectionStatusDelegate {
    func onRCIMConnectionStatusChanged(_ status: RCConnectionStatus) {
        switch status {
        case .ConnectionStatus_Connected:
            ToastView(title: "融云已连接").show()
        case .ConnectionStatus_SignOut:
            ToastView(title: "融云断开连接").show()
        default:
            ToastView(title: "融云连接状态变化啦").show()
        }
    }
}
