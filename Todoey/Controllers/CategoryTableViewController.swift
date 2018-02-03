//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Ke CAI on 3/2/18.
//  Copyright © 2018 Ke Cai. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addCategory(_ sender: Any) {
        
       let alert = UIAlertController(title: "Add Category", message: "Add new Category", preferredStyle: .alert)
        
        var textfield:UITextField!
        
        alert.addTextField { (field) in
            
            textfield = field
        }
        
        let action = UIAlertAction(title: "OK", style: .default) { ( action ) in
            
            //add category
            let category = Category(context: self.context)
            category.name = textfield.text!
            
            do {
                try self.context.save()
            }catch{
                
            }
            self.categories.append(category)
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadCategories() {
        
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try context.fetch(request)
        } catch {
            
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToList" {
            let controller = segue.destination as! TodoListTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                controller.category = categories[indexPath.row]
            }
            
        }
    }
}
