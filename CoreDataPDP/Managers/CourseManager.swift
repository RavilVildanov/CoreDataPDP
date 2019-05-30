//
//  CourseManager.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 29/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import Foundation
import CoreData

class CourseManager {

    // MARK: - Instance Properties

    private let context = CoreDataManager.shared.persistentContainer.viewContext

    // MARK: - Instance Methods

    // Private Methods

    private func saveContext() {
        CoreDataManager.shared.saveContext()
    }

    // Public Methods

    func allCourses() -> [Course] {
        //let fetchRequest = NSFetchRequest<Course>(entityName: "Course")
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            print(error)
        }
        return []
    }

    func createCourse(with courseInfo: CourseInfo) {
        let course = Course(context: context)

        course.name = courseInfo.name
        course.subject = courseInfo.subject
        course.teacher = courseInfo.teacher
        course.students = NSSet(array: courseInfo.students)

        saveContext()
    }

    func update(course: Course, with courseInfo: CourseInfo) {
        course.name = courseInfo.name
        course.subject = courseInfo.subject
        course.teacher = courseInfo.teacher
        course.students = NSSet(array: courseInfo.students)

        saveContext()
    }

    func delete(course: Course) {
        context.delete(course)
        saveContext()
    }
}
