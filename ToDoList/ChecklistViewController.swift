//
//  ViewController.swift
//  ToDoList
//
//  Created by Jonas Deichelmann on 17.04.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import UIKit
import RealmSwift
import TB

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    var items: Results<ChecklistItem>!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        items = realm.objects(ChecklistItem.self)
        tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
            
        }else{
            TB.warn("Unknown Segue")
        }
    }
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem){
        let realm = try! Realm()
        try! realm.write {
            realm.add(item, update: true)
        }
        controller.dismiss(animated: true, completion: nil)
        items = realm.objects(ChecklistItem.self)
        tableView.reloadData()
    }

    // - MARK: TableView Functions
    
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            configureCheckmark(for: cell, at: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! items.realm!.write {
                let item = self.items[indexPath.row]
                self.items.realm!.delete(item)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // - MARK: configure Functions
    func configureCheckmark(for cell: UITableViewCell,at item: ChecklistItem) {
        let realm = try! Realm()
        try! realm.write {
            if item.checked {
                cell.accessoryType = .checkmark
                item.toggleChecked()
                TB.info("\(item) Checked true")
            } else {
                cell.accessoryType = .none
                item.toggleChecked()
                TB.info("\(item) Checked false")
            }
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
}





