//
//  CourseInfo.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 30/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import Foundation

struct CourseInfo {
    var name: String
    var subject: String

    var teacher: User
    var students: [User]
}
