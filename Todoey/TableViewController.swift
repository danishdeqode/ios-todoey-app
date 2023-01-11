//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let db = UserDefaults.standard
    var items: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let list = db.array(forKey: "todoItems") as? [String]{
            items = list
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.mainCell, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) {
            (action) in
            print("done")
            print(textfield.text)
            if let task = textfield.text{
                self.items.append(task)
                self.db.set(self.items, forKey: "todoItems")
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        
        alert.addTextField{
            (alertTextField) in
            alertTextField.placeholder = "Task title..."
            textfield = alertTextField
            
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}

