//
//  ViewController.swift
//  ToDoAppEx
//
//  Created by izumiyoshiki on 2021/03/07.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!

	private var todoList: Results<TodoItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
		print("viewDidload")

		tableView.dataSource = self

		let realm = try! Realm()
		todoList = realm.objects(TodoItem.self)

		tableView.reloadData()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("viewWillAppear")

		tableView.reloadData()
	}

//	private func deleteTodoItem(at index: Int) {
//		try! realm.write {
//		  realm.delete(todoList[index])
//		}
//	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todoList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath)
		cell.textLabel?.text = todoList[indexPath.row].title

		return cell
	}
}
