//
//  Tutor.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit

class Tutor: NSObject {

    var firstName: String?
    var lastName: String?
    var email: String?
    var phoneNumber: String?
    var bio: String?
    var subjects: [String]?
    var time: String?
    var id: String?
    
    init(dict: NSDictionary) {
        self.firstName = dict["first_name"] as? String
        self.lastName = dict["last_name"] as? String
        self.email = dict["email"] as? String
        self.phoneNumber = dict["phone_number"] as? String
        self.bio = dict["bio"] as? String
        self.subjects = dict["subjects"] as? [String]
        self.time = dict["time_available"] as? String
        self.id = dict["tutor_id"] as? String
    }
    
    func getRating(){
        //lookup ratings and calculate an average :) sorry future me
    }
    
    func getName() -> String{
        return self.firstName! + " " + self.lastName!
    }
    
    func getSubjects() -> String{
        var sub_string = ""
        var index = 0
        for subject in self.subjects!{
            if index != (subjects?.count)! - 1{
                sub_string += subject + ", "
            }
            else{
                sub_string += subject
            }
            index += 1
        }
        return sub_string
    }
}
