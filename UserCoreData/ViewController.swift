//
//  ViewController.swift
//  UserCoreData
//
//  Created by phonestop on 10/27/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var UserArray = [""]

    //var names = ["one","two","three"]
    
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = self
        userTableView.dataSource = self
        //createUser()
        fetchUser()
    }

   
//    func createUser(){
//
//        let user = UserEntity(context: PersistentStorage.shared.context)
//        user.uName = "Manish"
//        PersistentStorage.shared.saveContext()
//    }
//
    func fetchUser(){
        //To identify the path
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path[0])
        
        UserArray.removeAll()
        do {
            guard let result = try  PersistentStorage.shared.context.fetch(UserEntity.fetchRequest()) as? [UserEntity] else {return}
            
            
            result.forEach({debugPrint($0.uName as Any)})
            
            for name in result{
                print(name.value(forKey: "uName") as Any)
                
                let sortedName = name.value(forKey: "uName")
               
                
                UserArray.append(sortedName as! String)
                let nonOptionalNumbers: [String] = UserArray.compactMap { $0 }

                print("Sorted array",nonOptionalNumbers)
            }
            
            print("Fetched Data: \(UserArray)")
            
            DispatchQueue.main.async {
                self.userTableView.reloadData()
            }
            
        } catch let error {
            debugPrint(error)
        }
        
      
        
    }
    
    @IBAction func addUserNameBarBtn(_ sender: UIBarButtonItem) {
        
        print("Bar Button Pressed")
        //1) Create the alert Controller
        let alertAction = UIAlertController.init(title: "Enter Name", message: "Enter a text", preferredStyle: .alert)
        //2) Add the textField
        alertAction.addTextField { textField in
            textField.placeholder = "Enter name"
        }
        //3) Grab th evalue from the textField and print it when the user clicks ok
        alertAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alertAction] (_) in
            let textField = alertAction?.textFields![0]//force unwrappping we know it exists
            if !(textField?.text!.isEmpty)!{
                print("TextField text: \(textField?.text ?? "Default User")")
                let user = UserEntity(context: PersistentStorage.shared.context)
                user.uName = textField?.text
                PersistentStorage.shared.saveContext()
                self.fetchUser()
            }
            else{
                print("textfield is empty")
                let alert = UIAlertController.init(title: "Empty!!", message: "Please Enter Name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
        }))
        self.present(alertAction, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        cell.userNameLbl.text = UserArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

