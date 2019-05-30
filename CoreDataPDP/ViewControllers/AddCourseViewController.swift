//
//  AddCourse.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 30/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import UIKit

class AddCourseViewController: UITableViewController {

    // MARK: - Instance Properties

    private weak var nameTextFiled: UITextField?
    private weak var subjectTextField: UITextField?

    // MARK: -

    var course: Course?
    private var selectedUsers = [User]()
    private var teacher: User?

    // MARK: -

    private let courseManager = CourseManager()

    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let course = course else { return }
        selectedUsers = course.students?.allObjects as! [User]
        teacher = course.teacher
        nameTextFiled?.text = course.name
        subjectTextField?.text = course.subject
    }

    // MARK: - UITableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return selectedUsers.count + 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CourseInfoCell", for: indexPath) as? CourseInfoCell
                cell?.titleLabel.text = "Name: "
                self.nameTextFiled = cell?.textFiled
                self.nameTextFiled?.text = course?.name
                return cell!
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CourseInfoCell", for: indexPath) as? CourseInfoCell
                cell?.titleLabel.text = "Subject: "
                self.subjectTextField = cell?.textFiled
                self.subjectTextField?.text = course?.subject
                return cell!
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
                if teacher == nil {
                    cell?.textLabel?.text = "Choose teacher"
                } else {
                    cell?.textLabel?.text = "Teacher: " + teacher!.surname!.capitalized + " " + teacher!.name!.capitalized
                }
                cell?.selectionStyle = .none
                return cell!
            }
        } else if indexPath.section == 1 {
            if indexPath.row == selectedUsers.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
                cell?.textLabel?.text = "Add User"
                return cell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
                cell?.textLabel?.text = selectedUsers[indexPath.row].name
                return cell!
            }
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Course Info"
        } else {
            return "Students"
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                nameTextFiled?.becomeFirstResponder()
            } else if indexPath.row == 1 {
                subjectTextField?.becomeFirstResponder()
            } else if indexPath.row == 2 {
                showChooseTeacher()
            }
        } else if indexPath.section == 1, indexPath.row == selectedUsers.count {
            showChooseStudents()
        }
    }

    // MARK: - Navigation

    func showChooseTeacher() {
        let chooseUserViewController = ChooseUserViewController()
        chooseUserViewController.delegate = self
        navigationController?.pushViewController(chooseUserViewController, animated: true)
    }

    func showChooseStudents() {
        let chooseUsersViewController = ChooseUsersViewController()
        chooseUsersViewController.delegate = self
        chooseUsersViewController.selectedUsers = self.selectedUsers
        navigationController?.pushViewController(chooseUsersViewController, animated: true)
    }

    // MARK: - Actions

    @IBAction func onSaveTaped(_ sender: UIBarButtonItem) {
        guard let courseName = nameTextFiled?.text, !courseName.isEmpty else {
            print("Enter course name!")
            return
        }

        guard let subject = subjectTextField?.text, !subject.isEmpty else {
            print("Enter subject!")
            return
        }

        guard let teacher = self.teacher else {
            print("Choose Teacher!")
            return
        }

        let courseInfo = CourseInfo(name: courseName, subject: subject, teacher: teacher, students: selectedUsers)

        if course == nil {
            courseManager.createCourse(with: courseInfo)
        } else {
            courseManager.update(course: course!, with: courseInfo)
        }

        navigationController?.popToRootViewController(animated: true)
    }
}

extension AddCourseViewController: ChooseUserDelegate {
    func didChose(user: User) {
        self.teacher = user
        let indexPath = IndexPath(row: 2, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension AddCourseViewController: ChooseUsersDelegate {
    func didChose(users: [User]) {
        self.selectedUsers = users
        let indexSet = IndexSet(arrayLiteral: 1)
        tableView.reloadSections(indexSet, with: .automatic)
    }
}
