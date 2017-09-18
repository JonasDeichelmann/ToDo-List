//
//  ViewController.swift
//  ToDoList
//
//  Created by Jonas Deichelmann on 17.04.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import UIKit
import RealmSwift




class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    var items = List<ChecklistItem>()
    let realm = try! Realm()

    required init?(coder aDecoder: NSCoder) {
//        items = [ChecklistItem]()
    /*    let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.subText = "Things"
        row0item.checked = false
        items.append(row0item)
        let row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.subText = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        let row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.subText = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        let row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.subText = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        let row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.subText = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)*/
        super.init(coder: aDecoder)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self

        }else{
            print("Unknown Segue")
        }
    }
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem){
        let car2 = Car()
        car2.brand = "DeLorean"
        car2.name = "Outatime"
        car2.year = 1981

//        let newRowIndex = items.count
        try! realm.write {
            realm.add(car2)
//            items.insert(ChecklistItem(value: ["text": item.text, "subText": item.subText, "checked": item.checked]), at: newRowIndex)
//            let indexPath = IndexPath(row: newRowIndex, section: 0)
//            let indexPaths = [indexPath]
//            tableView.insertRows(at: indexPaths, with: .automatic)
        }

//        tableView.reloadData()
//        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return Int(items.count)
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureSubText(for: cell, with: item)
        configureCheckmark(for: cell, at: item)
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, at: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        // 1.remove the item from the datamodel
        items.remove(at: indexPath.row)
        // 2 delete the corresponding row from the table view
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    func configureCheckmark(for cell: UITableViewCell,at item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }

    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    func configureSubText(for cell: UITableViewCell,
                       with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = item.subText
    }

    //MARK: - Realm Functions for Server-Connection
/*
    func setupRealm() {
        // Log in existing user with username and password
        let username = "test"  // Default
        let password = "test"  // Default

        SyncUser.logIn(with: .usernamePassword(username: username, password: password, register: false), server: URL(string: "http://127.0.0.1:9080")!) { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }

            DispatchQueue.main.async {
                // Open Realm
                let configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://127.0.0.1:9080/~/realmtasks")!)
                )
                self.realm = try! Realm(configuration: configuration)

                // Show initial tasks
                func updateList() {
                    if self.items.realm == nil, let list = self.realm.objects(ChecklistItem.self).first {
//                        self.items = list.text
                        }
                    self.tableView.reloadData()
                }
                updateList()

                // Notify us when Realm changes
                self.notificationToken = self.realm.addNotificationBlock { _ in
                    updateList()
                }
            }
        }
    }

    deinit {
        notificationToken.stop()
    }
*/

}





