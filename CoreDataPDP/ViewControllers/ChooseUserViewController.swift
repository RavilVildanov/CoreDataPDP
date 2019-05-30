//
//  ChooseUserViewController.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 30/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import UIKit

protocol ChooseUserDelegate {
    func didChose(user: User)
}

class ChooseUserViewController: UITableViewController {

    // MARK: - Instance Properties

    private var users = [User]()

    private let userManager = UserManager()

    var delegate: ChooseUserDelegate?

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = "\(users[indexPath.row].name!) \(users[indexPath.row].surname!)"
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        delegate?.didChose(user: user)
        navigationController?.popViewController(animated: true)
    }
}
