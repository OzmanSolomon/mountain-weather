//
//  AppDelegate.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 21/08/2021.
//

import Foundation
import SwiftUI
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerBackgroundTaks()
        registerLocalNotification()
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        cancelAllPandingBGTask()
        scheduleAppRefresh()
        scheduleImageFetcher()
    }
    
    //MARK: Regiater BackGround Tasks
    private func registerBackgroundTaks() {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.oz.fetchWeather", using: nil) { task in
            //This task is cast with processing request (BGProcessingTask)
            self.scheduleLocalNotification()
            self.handleImageFetcherTask(task: task as! BGProcessingTask)
        }
        
        
    }
}

//MARK:- BGTask Helper
extension AppDelegate {
    
    func cancelAllPandingBGTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    
    func scheduleImageFetcher() {
        let request = BGProcessingTaskRequest(identifier: "com.oz.fetchWeather")
        request.requiresNetworkConnectivity = true // Need to true if your task need to network process. Defaults to false.
        request.requiresExternalPower = false
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 5) // Featch Image Count after 1 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule image featch: \(error)")
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.SO.apprefresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 2 * 60) // App Refresh after 2 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        //Todo Work
        /*
         //AppRefresh Process
         */
        task.expirationHandler = {
            //This Block call by System
            //Canle your all tak's & queues
        }
        scheduleLocalNotification()
        //
        task.setTaskCompleted(success: true)
    }
    
    func handleImageFetcherTask(task: BGProcessingTask) {
        scheduleImageFetcher() // Recall
        
        //Todo Work
        task.expirationHandler = {
            //This Block call by System
            //Canle your all tak's & queues
        }
        
        //Get & Set New Data
        //        let interator =  ListInterator()
        //        let presenter =  ListPresenter()
        //        presenter.interator = interator
        //
        //        presenter.setNewData()
        
        //
        task.setTaskCompleted(success: true)
        
    }
}

//MARK:- Notification Helper
extension AppDelegate {
    
    func registerLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func scheduleLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                self.fireNotification()
            }
        }
    }
    
    func fireNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "Bg"
        notificationContent.body = "BG Notifications."
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
}
