//
//  ViewController.swift
//  Table_view
//
//  Created by Dhaval Bhimani on 2022-08-04.
//

import UIKit

class listTableViewController: UITableViewController {
    
    var list:[String] = ["Eternals","Dune","No Time To Die","Last Night in Soho","Ron’s Done Wrong","Halloween Kills","Venom","Antlers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "list"
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.isEditing = true
        
        if !UserDefaults().bool(forKey: "set"){
            UserDefaults().set(true, forKey: "set")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(list, forKey: "todolist")
        updatetodoList()
    }
    
    func updatetodoList()
    {
        list.removeAll()
        let userDefaults = UserDefaults.standard
        let strlistArr: [String] = userDefaults.object(forKey: "todolist") as? [String] ?? []
        list.append(contentsOf: strlistArr)
        tableView.reloadData()
    }
    //Add new movie button click
    @IBAction func didTapAdd()
    {
        let addvc = storyboard?.instantiateViewController(withIdentifier: "add") as! AddlistTableViewController
        addvc.title = "Add list"
        addvc.update = {
            DispatchQueue.main.async{
                self.updatetodoList()
            }
            
        }
        navigationController?.pushViewController(addvc, animated: true)
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    //cell click event
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addvc = storyboard?.instantiateViewController(withIdentifier: "view") as! listViewController
        addvc.title = "View list"
        addvc.list = list[indexPath.row]
        navigationController?.pushViewController(addvc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todolist", for: indexPath)
        
        
        cell.textLabel!.text = list[indexPath.row]
        return cell
    }
  
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
   
    override func tableView(_ tableView: UITableView, moveRowAt indexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let userDefaults = UserDefaults.standard
        var strlistArr: [String] = userDefaults.object(forKey: "todoList") as? [String] ?? []
        let movedObject = strlistArr[indexPath.row]
        strlistArr.remove(at: indexPath.row)
        strlistArr.insert(movedObject, at: destinationIndexPath.row)
        userDefaults.set(strlistArr, forKey: "todoList")
    }


    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let userDefaults = UserDefaults.standard
            var strlistArr: [String] = userDefaults.object(forKey: "todoList") as? [String] ?? []
            strlistArr.remove(at: indexPath.row)
            userDefaults.set(strlistArr, forKey: "todoList")
        }
    }
}
