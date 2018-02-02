//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by Ke CAI on 2/2/18.
//  Copyright © 2018 Ke Cai. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {

    var items = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item()
        item1.title = "Get milk"
        items.append(item1)
       
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//
//            itemArray = items
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        item.done = !item.done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()

    }
    
    //MARK: - Add New Item
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textfield:UITextField!
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let item = Item()
                
                item.title = textfield.text!
            
            self.items.append(item)
            
//            self.defaults.set(self.itemArray, forKey:"TodoListArray")
            self.tableView.reloadData()
        }
        
       
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            
            textfield = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}
