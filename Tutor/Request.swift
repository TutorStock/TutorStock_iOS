//
//  Request.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit

class Request: NSObject {

    var tutor_id: String
    var user_id: String
    var message: String
    var date: Date
    var approval: Int
    var name: String
    var subject: String
    var id: String
    
    init(dict: NSDictionary){
        self.tutor_id = dict["tutor_id"] as! String
        self.user_id = dict["user_id"] as! String
        self.message = dict["message"] as! String
        self.date = dict["date"] as! Date
        self.approval = dict["approval"] as! Int
        self.name = dict["name"] as! String
        self.subject = dict["subject"] as! String
        self.id = dict["id"] as! String
    }
    func getDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self.date)
    }
}
