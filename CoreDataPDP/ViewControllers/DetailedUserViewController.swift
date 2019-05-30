//
//  DetailedUserViewController.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 29/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import UIKit

class DetailedUserViewController: UITableViewController {

    // MARK: - Instance Properties

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!

    // MARK: -

    var user: User?

    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = user?.name
        surnameLabel.text = user?.surname
        emailLabel.text = user?.email
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddUser" {
            guard let dvc = segue.destination as? AddUserViewController else { return }
            dvc.user = user
        }
    }
}
