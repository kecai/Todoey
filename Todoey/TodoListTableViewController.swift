//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by Ke CAI on 2/2/18.
//  Copyright © 2018 Ke Cai. All rights reserved.
//

import UIKit
import CoreData

class TodoListTableViewController: UITableViewController {

    var items = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
       
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
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()

    }
    
    //MARK: - Add New Item
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textfield:UITextField!
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let item = Item(context: self.context)
                
                item.title = textfield.text!
                item.done = false
            
                self.items.append(item)
            
                self.saveItems()

            self.tableView.reloadData()
        }
        
       
        
            alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            
            textfield = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    func loadItems() {
        
        do {
            
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        items = try context.fetch(request)
        print(items.count)
            
        } catch {
            
        }
    }
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            
        }
    }
}
