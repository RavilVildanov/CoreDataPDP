//
//  ChooseUsersViewController.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 30/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import UIKit

protocol ChooseUsersDelegate {
    func didChose(users: [User])
}

class ChooseUsersViewController: UITableViewController {

    // MARK: - Instance Properties

    private var users = [User]()

    private let userManager = UserManager()

    var selectedUsers = [User]()
    
    var delegate: ChooseUsersDelegate?

    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = userManager.allUsers()
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didChose(users: selectedUsers)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = "\(users[indexPath.row].name!) \(users[indexPath.row].surname!)"

        let user = users[indexPath.row]

        if selectedUsers.contains(user) {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)

        if selectedUsers.contains(selectedUser) {
            selectedUsers.removeAll { user -> Bool in
                return selectedUser == user
            }
            cell?.accessoryType = .none
        } else {
            selectedUsers.append(selectedUser)
            cell?.accessoryType = .checkmark
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

