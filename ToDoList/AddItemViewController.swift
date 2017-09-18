//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Jonas Deichelmann on 30.05.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController,didFinishAdding item: ChecklistItem)
}


class AddItemViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    weak var delegate: AddItemViewControllerDelegate?
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    let categories = ["E-Mail","Wohnung", "Hochschule", "Einkaufen", "Auto", "Sonstiges"]
    var selectedCategorie = ""	

    //MARK: - PickerView -
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String?{
        let test = categories[row]
        return test
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch row {
        case 0:
            selectedCategorie = "E-Mail"
        case 1:
            selectedCategorie = "Wohnung"
        case 2:
            selectedCategorie = "Hochschule"
        case 3:
            selectedCategorie = "Einkaufen"
        case 4:
            selectedCategorie = "Auto"
        case 5:
            selectedCategorie = "Sonstiges"
        default:
            selectedCategorie = "Unknown"
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return categories.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    //MARK: - Own Functions -
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func done(){
        if selectedCategorie == "" { selectedCategorie = "E-Mail"}
        let item = ChecklistItem()
        item.text = textField.text!
        item.subText = selectedCategorie
        item.checked = false


        delegate?.addItemViewController(self, didFinishAdding: item)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string )as NSString
        if newText.length > 0 {
            doneButton.isEnabled = true
        }else{
            doneButton.isEnabled = false
        }
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
