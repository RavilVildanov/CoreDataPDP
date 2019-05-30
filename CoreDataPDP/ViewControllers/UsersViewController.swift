//
//  StudentsViewController.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 29/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import UIKit

class UsersViewController: UITableViewController {

    // MARK: - Instance Properties

    private var userManager = UserManager()

    // MARK: - 

    private var users = [User]()

    // MARK: - Instance Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = userManager.allUsers()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedUser" {
            guard let dvc = segue.destination as? DetailedUserViewController else { return }
            guard let index = tableView.indexPathForSelectedRow?.row else { return }

            dvc.user = users[index]
        }
    }

    // MARK: - UITableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userManager.delete(user: users[indexPath.row])
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
