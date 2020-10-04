//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by Jackie Cochran on 10/3/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//

import UIKit
import UserNotifications

struct LocalNotificationManager{
    static func authorizeLocalNotification(viewController: UIViewController){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard error == nil else{
                print("Boooo error \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Permission granted to have notfiications")
            }else{
                print("Permission not granted for notifications")
                DispatchQueue.main.async{
                    viewController.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To receive alerts for reminders, open the Settings app, select To Do List > Notifications > Allow Notifications")
                }
            }
        }
    }
    
    
    static func isAuthorized(completed: @escaping (Bool) -> ()){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard error == nil else{
                print("Boooo error \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("Permission granted to have notfiications")
                completed(true)
            }else{
                print("Permission not granted for notifications")
                completed(false)
            }
        }
    }
    
    
    static func setCalenderNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        //create content:
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        //create trigger
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        //register request with the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("ERROR")
            }else{
                print("Notification schedule \(notificationID), title: \(content.title)")
            }
        }
        return notificationID
    }
    
}
