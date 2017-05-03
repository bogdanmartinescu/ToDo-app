//
//  ViewController.swift
//  ToDo-app
//
//  Created by Bogdan Martinescu on 02/05/2017.
//  Copyright © 2017 Bogdan Martinescu. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var importantCheckbox: NSButton!
    @IBOutlet weak var tableView:NSTableView!
    
    var todoItems: [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToDoItems()
        // Do any additional setup after loading the view.
    }
    
    func getToDoItems() {
        // get items from core data
        // set them to class prop
        // update the property
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                todoItems = try context.fetch(ToDoItem.fetchRequest())
                print(todoItems.count)
            } catch {
                
            }
            // update table
            tableView.reloadData()
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func addClicked(_ sender: Any) {
    
        if textField.stringValue != "" {
            if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
                let todoItem = ToDoItem(context:context)
                
                todoItem.name = textField.stringValue
                
                if importantCheckbox.state == 0 {
                    todoItem.important = false
                } else {
                    todoItem.important = true
                }
                
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                textField.stringValue = ""
                importantCheckbox.state = 0
                
                getToDoItems()
            }
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.make(withIdentifier: "importantCell", owner: self) as? NSTableCellView {
            cell.textField?.stringValue = "hello"
            return cell;
        }
        return nil
    }
    

}

