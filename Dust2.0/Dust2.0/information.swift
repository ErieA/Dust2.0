//
//  information.swift
//  Dust2.0
//
//  Created by Erie M. Adames on 4/26/19.
//  Copyright © 2019 Erie M. Adames. All rights reserved.
//

import Foundation
class Class {
    static var coursesOfStudy: [String : String] = ["Mathematics" : "MATH", "Applied Economics & Management" : "AEM", "Agricultural & Life Sciences" : "ALS", "Animal Science" : "ANSC", "Astronomy" : "ASTRO", "Computer Science" : "CS", "Physics" : "PHYS"]
    enum Semester {
        case FA, SP, SU, WI
    }
    var course : String
    var courseNum : Int
    var yearTaken : Int
    var semesterTaken : Semester
    
    init(course: String, courseNum: Int, yearTaken: Int, semesterTaken: Semester){
        self.course = course
        self.courseNum = courseNum
        self.yearTaken = yearTaken
        self.semesterTaken = semesterTaken
    }
    
    func getSem() -> String {
        switch self.semesterTaken {
        case .SP:
            return "SP"
        case .FA:
            return "FA"
        case .SU:
            return "SU"
        case .WI:
            return "WI"
        }
    }
}

struct Course : Codable {
    var course : String
    var distributions : [String]
}

struct Data : Codable {
    var requirements : [Course]
}

struct Response : Codable {
    var success : Bool
    var data : Data
}
