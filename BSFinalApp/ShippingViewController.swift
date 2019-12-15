//
//  ShippingViewController.swift
//  BSFinalApp
//
//  Created by Bernard Slater on 12/11/19.
//  Copyright © 2019 Bernard Slater. All rights reserved.
//

import UIKit
import CoreData

class ShippingViewController: UIViewController {
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        if (shippingdb != nil)
        {
            
            shippingdb.setValue(fullname.text, forKey: "fullname")
            shippingdb.setValue(address.text, forKey: "address")
            shippingdb.setValue(city.text, forKey: "city")
            shippingdb.setValue(state.text, forKey: "state")
            shippingdb.setValue(zip.text, forKey: "zip")
            
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Shipping",in: managedObjectContext)
            
            let shipping = Shipping(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            shipping.fullname = fullname.text!
            shipping.address = address.text!
            shipping.city = city.text!
            shipping.state = state.text!
            shipping.zip = zip.text!
            
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
        fullname.isEnabled = true
        address.isEnabled = true
        city.isEnabled = true
        state.isEnabled = true
        zip.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        fullname.becomeFirstResponder()
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
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
            var shippingdb:NSManagedObject!
            //**End Copy**
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                //**Begin Copy**
                //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
                
                
                if (shippingdb != nil)
                {
                    fullname.text = shippingdb.value(forKey: "fullname") as? String
                    address.text = shippingdb.value(forKey: "address") as? String
                    city.text = shippingdb.value(forKey: "city") as? String
                    state.text = shippingdb.value(forKey: "state") as? String
                    zip.text = shippingdb.value(forKey: "zip") as? String
                    
                    btnSave.setTitle("Update", for: UIControl.State())
                   
                    btnEdit.isHidden = false
                    fullname.isEnabled = false
                    address.isEnabled = false
                    city.isEnabled = false
                    state.isEnabled = false
                    zip.isEnabled = false
                    btnSave.isHidden = true
                }else{
                  
                    btnEdit.isHidden = true
                    fullname.isEnabled = true
                    address.isEnabled = true
                    city.isEnabled = true
                    state.isEnabled = true
                    zip.isEnabled = true
                }
                fullname.becomeFirstResponder()
                // Do any additional setup after loading the view.
                //Looks for single or multiple taps
                let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShippingViewController.DismissKeyboard))
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
                fullname.endEditing(true)
                address.endEditing(true)
                city.endEditing(true)
                state.endEditing(true)
                zip.endEditing(true)
            }
            //**End Copy**
            
            //**Begin Copy**
            
            //8 Add to hide keyboard
            
            func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
                textField.resignFirstResponder()
                return true;
            }
}
