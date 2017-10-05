//
//  Protocols.swift
//  ToDoList
//
//  Created by Jonas Deichelmann on 05.10.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation
protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController,didFinishAdding item: ChecklistItem)
}
