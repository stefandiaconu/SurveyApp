//
//  ViewController.swift
//  SurveyApp
//
//  Created by Stefan Diaconu on 04/03/2019.
//  Copyright © 2019 Stefan Diaconu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    let pass = "Pass1234" // Password to access the stats table
    var person:Person!
    
    // person's attributes
    var first:String = ""
    var last:String = ""
    var idPerson = ""
    var date:String = ""
    var question1 = false
    var question2 = ""
    var question3 = false

    @IBOutlet weak var firstNameText: UITextField!
    
    @IBOutlet weak var lastNameText: UITextField!
    
    @IBOutlet weak var idText: UITextField!
    
    @IBOutlet weak var dateText: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        // format the datepicker to UK format
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateText.text = strDate
    }
    
    @IBAction func statsButton(_ sender: Any) {
        stats()
    }
    
    @IBAction func startButton(_ sender: UIBarButtonItem) {
        
        // check first if there is any input, if not, error
        if (firstNameText.text != "" && lastNameText.text != "" && idText.text != "" && dateText.text != ""){
            confirm()
            
            // get the data from associated text fields and asign to person's attributes
            first = firstNameText.text!
            last = lastNameText.text!
            idPerson = idText.text!
            date = dateText.text!
            
            person = Person(firstName: first, lastName: last, id: idPerson, dateOfBirth: date, q1: question1, q2: question2, q3: question3)
            
            person.printPerson()
        }
        else {
            // alert the user to fill all the text fields in order to proceed
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            // set the title and body message  font and size of the alert
            let titFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 25.0)!]
            let msgFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 20.0)!]
            
            // asign the title and body message
            let titAttrString = NSMutableAttributedString(string: "Error", attributes: titFont)
            let msgAttrString = NSMutableAttributedString(string: "Please fill all the fields and press OK to proceed", attributes: msgFont)
            
            alertController.setValue(titAttrString, forKey: "attributedTitle")
            alertController.setValue(msgAttrString, forKey: "attributedMessage")
            
            let confirmAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default)
            
            alertController.addAction(confirmAction)
            
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstNameText.becomeFirstResponder()
        _ = UIKeyboardType(rawValue: 0)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func myUnwindFunction(unwindSegue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.destination is Screen2ViewController{
            let vc = segue.destination as? Screen2ViewController
            vc?.person = person
        }
    }

    func confirm(){
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        // set the title and body message  font and size of the alert
        let titFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 25.0)!]
        let msgFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 20.0)!]
        
        let titAttrString = NSMutableAttributedString(string: "Confirm", attributes: titFont)
        let msgAttrString = NSMutableAttributedString(string: "Please confirm your answer and proceed to next question or Cancel to review your answer", attributes: msgFont)
        
        alertController.setValue(titAttrString, forKey: "attributedTitle")
        alertController.setValue(msgAttrString, forKey: "attributedMessage")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        let confirmAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:{(_) in self.performSegue(withIdentifier: "secondView", sender: self)})
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func stats(){
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        // set the title and body message  font and size of the alert
        let titFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 25.0)!]
        let msgFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 20.0)!]
        
        let titAttrString = NSMutableAttributedString(string: "Login", attributes: titFont)
        let msgAttrString = NSMutableAttributedString(string: "Please enter your password", attributes: msgFont)
        
        alertController.setValue(titAttrString, forKey: "attributedTitle")
        alertController.setValue(msgAttrString, forKey: "attributedMessage")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(cancelAction)
        
        // set a text field on the alert
        alertController.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        alertController.addAction(UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:{(_) in
            // add action to the alert
            // if the text entered is the same with password, give access to stats
            let textField = alertController.textFields![0]
            if (textField.text == self.pass) {
                self.performSegue(withIdentifier: "tableView", sender: self)
            }
        }))
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

