//
//  AddUserViewController.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 29/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import UIKit

class AddUserViewController: UITableViewController {

    // MARK: - Instance Properties

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!

    private let userManager = UserManager()

    // MARK: -

    var user: User?

    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = user?.name
        surnameTextField.text = user?.surname
        emailTextField.text = user?.email
    }

    // UITableView

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textFields = [nameTextField, surnameTextField, emailTextField]
        textFields[indexPath.row]?.becomeFirstResponder()
    }

    // Actions

    @IBAction func onSaveTapped(_ sender: Any) {
        guard let name = nameTextField.text, let surname = surnameTextField.text, let email = emailTextField.text else {
            print("Error")
            return
        }

        let userData = UserData(name: name, surname: surname, email: email)

        if user == nil {
            userManager.createUser(with: userData)
        } else {
            userManager.update(user: user!, with: userData)
        }

        navigationController?.popViewController(animated: true)
    }
}
