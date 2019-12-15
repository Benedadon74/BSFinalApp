//
//  Inventory.swift
//  BSFinalApp
//
//  Created by Bernard Slater on 12/7/19.
//  Copyright © 2019 Bernard Slater. All rights reserved.
//

import UIKit
import CoreData

class InventoryPage: UIViewController {

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBAction func btnSave(_ sender: UIButton) {
        if (inventorydb  != nil)
        {
            
            inventorydb.setValue(itemName.text, forKey: "itemName")
            inventorydb.setValue(quantity.text, forKey: "quantity")
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Inventory",in: managedObjectContext)
            
            let inventory = Inventory(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            inventory.itemName = itemName.text!
            inventory.quantity = quantity.text!
        
            
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            //if error occurs
           // status.text = err.localizedFailureReason
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
    itemName.isEnabled = true
    quantity.isEnabled = true
    btnSave.isHidden = false
    btnEdit.isHidden = true
    itemName.becomeFirstResponder()    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        
                //**Begin Copy**
                //2) Dismiss ViewController
               self.dismiss(animated: true, completion: nil)
        //       let detailVC = ContactTableViewController()
        //        detailVC.modalPresentationStyle = .fullScreen
        //        present(detailVC, animated: false)
                //**End Copy**
            }
            
            //**Begin Copy**
            //3) Add ManagedObject Data Context
            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //**End Copy**
            
            
            //**Begin Copy**
            //4) Add variable contactdb (used from UITableView
            var inventorydb:NSManagedObject!
            //**End Copy**
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                //**Begin Copy**
                //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
                
                
                if (inventorydb != nil)
                {
                    itemName.text = inventorydb.value(forKey: "itemName") as? String
                    quantity.text = inventorydb.value(forKey: "quantity") as? String
                    
                    
                    btnSave.setTitle("Update", for: UIControl.State())
                   
                    btnEdit.isHidden = false
                    itemName.isEnabled = false
                    
                    btnSave.isHidden = true
                }else{
                  
                    btnEdit.isHidden = true
                    itemName.isEnabled = true
                    
                }
                itemName.becomeFirstResponder()
                // Do any additional setup after loading the view.
                //Looks for single or multiple taps
                let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InventoryPage.DismissKeyboard))
                //Adds tap gesture to view
                view.addGestureRecognizer(tap)
                
                
                // Do any additional setup after loading the view, typically from a nib.
                
                //**End Copy**
            }
            
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            
            //**Begin Copy**
            //6 Add to hide keyboard
            
            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                super.touchesBegan(touches , with:event)
                if (touches.first as UITouch?) != nil {
                    DismissKeyboard()
                }
            }
            //**End Copy**
            
            
            //**Begin Copy**
            //7 Add to hide keyboard
            
            @objc func DismissKeyboard(){
                //forces resign first responder and hides keyboard
                itemName.endEditing(true)
                quantity.endEditing(true)
                
            }
            //**End Copy**
            
            //**Begin Copy**
            
            //8 Add to hide keyboard
            
            func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
                textField.resignFirstResponder()
                return true;
            }
            //**End Copy**
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


