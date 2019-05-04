//
//  information.swift
//  Dust2.0
//
//  Created by Erie M. Adames on 4/26/19.
//  Copyright © 2019 Erie M. Adames. All rights reserved.
//

import Foundation
class Class : Equatable {
    static func == (lhs: Class, rhs: Class) -> Bool {
        if lhs.course == rhs.course && lhs.courseNum == rhs.courseNum && lhs.yearTaken == rhs.yearTaken && lhs.semesterTaken == rhs.semesterTaken {
            return true
        } else {
            return false
        }
    }
    
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

struct Response : Codable {
    var success : Bool
    var data : [Course]
}
struct getResponse : Codable {
    var success : Bool
    var data : [String]
}

