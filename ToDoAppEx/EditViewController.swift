//
//  EditViewController.swift
//  ToDoAppEx
//
//  Created by izumiyoshiki on 2021/03/07.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {

	@IBOutlet private weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
	}

	@IBAction private func tapAddButton(_ sender: Any) {
		guard let newList = textField.text, !newList.isEmpty else { return }

		let realm = try! Realm()
		let toDo = TodoItem()
		
		toDo.title = newList

		try! realm.write {
			realm.add(toDo)
			print("新しいリスト追加：\(newList)")
		}
		textField.text = ""
	}
}

