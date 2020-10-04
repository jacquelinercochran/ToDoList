//
//  ToDoItems.swift
//  ToDoList
//
//  Created by Jackie Cochran on 10/2/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//

import Foundation
import UserNotifications

class ToDoItems{
    var itemsArray: [ToDoItem] = []
    
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(itemsArray)
        do{
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch{
            print("ERROR: Could not save data")
        }
        setNotifications()
    }
    
    func loadData(completed: @escaping ()->()){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecorder = JSONDecoder()
        do {
            itemsArray = try jsonDecorder.decode(Array<ToDoItem>.self, from: data)
        } catch{
            print("Error: Could not laod data")
        }
        completed()
    }
    
    
    func setNotifications(){
        guard itemsArray.count > 0 else{
            return
        }
        //remove all notificaitons
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    // let's recreate them with update data
        for index in 0..<itemsArray.count{
            if itemsArray[index].reminderSet {
                let toDoItem = itemsArray[index]
                itemsArray[index].notificationID = LocalNotificationManager.setCalenderNotification(title: toDoItem.name, subtitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
            }
        }
    }
    
}
