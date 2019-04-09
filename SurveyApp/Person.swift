//
//  Person.swift
//  SurveyApp
//
//  Created by Stefan Diaconu on 05/03/2019.
//  Copyright © 2019 Stefan Diaconu. All rights reserved.
//

import Foundation

class Person {
    
    var firstName:String = ""
    var lastName:String = ""
    var id:String = ""
    var dateOfBirth:String = ""
    var q1:Bool = false
    var q2:String = ""
    var q3:Bool = false
    
    init(firstName:String, lastName:String, id:String, dateOfBirth:String, q1:Bool, q2:String, q3:Bool){
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.dateOfBirth = dateOfBirth
        self.q1 = q1
        self.q2 = q2
        self.q3 = q3
    }
    
    init(){}
    
    func printPerson(){
        print("Name: \(self.firstName), last name: \(self.lastName), id: \(self.id), date of birth: \(self.dateOfBirth), question 1: \(self.q1), question 2: \(self.q2), question 3: \(self.q3)")
    }
}
