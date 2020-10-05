//
//  UIViewController+alert.swift
//  ToDoList
//
//  Created by Jackie Cochran on 10/4/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//Hello

import UIKit
extension UIViewController {
    func oneButtonAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
