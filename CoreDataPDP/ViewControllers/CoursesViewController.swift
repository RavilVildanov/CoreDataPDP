//
//  CoursesViewController.swift
//  CoreDataPDP
//
//  Created by Равиль Вильданов on 29/05/2019.
//  Copyright © 2019 Vildanov. All rights reserved.
//

import UIKit

class CoursesViewController: UITableViewController {

    // MARK: - Instance Properties

    private let courseManager = CourseManager()

    private var courses = [Course]()

    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        courses = courseManager.allCourses()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCourse" {
            guard let dvc = segue.destination as? AddCourseViewController else { return }
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            dvc.course = courses[index]
        }
    }

    // MARK: - UITableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let course = courses[indexPath.row]
            courseManager.delete(course: course)
            courses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
