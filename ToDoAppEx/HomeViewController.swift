//
//  ViewController.swift
//  ToDoAppEx
//
//  Created by izumiyoshiki on 2021/03/07.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
	private var realm: Realm!
	private var todoList: Results<TodoItem>!
	private var token: NotificationToken!

	@IBOutlet private weak var tableView: UITableView!
	//    @IBAction func shareButton(_ sender: Any) {
//        let shareVC = storyboard?.instantiateViewController(withIdentifier: "ShareViewController") as! ShareViewController
//        shareVC.modalPresentationStyle = .fullScreen
//        self.present(shareVC, animated: true, completion: nil)
//
//    }
//    @IBAction func searchButton(_ sender: Any) {
//        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
//        searchVC.modalPresentationStyle = .fullScreen
//        self.present(searchVC, animated: true, completion: nil)
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

		realm = try! Realm()
		todoList = realm.objects(TodoItem.self)
		token = todoList.observe { [weak self] _ in
		  self?.reload()
		}
    }

	override func awakeFromNib() {
		super.awakeFromNib()

		guard tableView != nil else { return}
		
		realm = try! Realm()
		todoList = realm.objects(TodoItem.self)
		token = todoList.observe { [weak self] _ in
		  self?.reload()
		}
	}

	private func deleteTodoItem(at index: Int) {
		try! realm.write {
		  realm.delete(todoList[index])
		}
	}

	func addTodoItem(title: String) {
		try! realm.write {
		  realm.add(TodoItem(value: ["title": title]))
		}
	}

	private func reload() {
		tableView.reloadData()
	}

	deinit {
		token.invalidate()
	}


//    
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if(item.tag == 1) {
//            let editVC = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
//            editVC.modalPresentationStyle = .fullScreen
//            self.present(editVC, animated: true, completion: nil)
//        } else if(item.tag == 2) {
//            let settingVC = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
//            settingVC.modalPresentationStyle = .fullScreen
//            self.present(settingVC, animated: true, completion: nil)
//        }
//    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todoList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath)
		cell.textLabel?.text = todoList[indexPath.row].title
		return cell
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
				   forRowAt indexPath: IndexPath) {
		deleteTodoItem(at: indexPath.row)
	}
}



