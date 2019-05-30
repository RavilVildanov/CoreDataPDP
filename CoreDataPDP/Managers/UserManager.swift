//
//  UserManager.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 29/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import Foundation
import CoreData

class UserManager {

    // MARK: - Instance Properties

    private let context = CoreDataManager.shared.persistentContainer.viewContext

    // MARK: - Instance Methods

    // Private Methods

    private func saveContext() {
        CoreDataManager.shared.saveContext()
    }

    // Public Methods

    func allUsers() -> [User] {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")

        do {
            let resultArray = try context.fetch(fetchRequest)
            return resultArray
        } catch {
            print(error)
        }

        return []
    }

    func createUser(with userData: UserData) {
        let user = User(context: context)
        user.name = userData.name
        user.surname = userData.surname
        user.email = userData.email

        saveContext()
    }

    func update(user: User, with userData: UserData) {
        user.name = userData.name
        user.surname = userData.surname
        user.email = userData.email

        saveContext()
    }

    func delete(user: User) {
        context.delete(user)
        saveContext()
    }
}
