//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Jackie Cochran on 9/26/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//
//Hello

import Foundation

struct ToDoItem: Codable{
    var name: String
    var date: Date
    var notes: String
    var reminderSet: Bool
    var notificationID: String?
    var completed: Bool
}

