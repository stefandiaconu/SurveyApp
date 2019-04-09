//
//  Screen3aViewController.swift
//  SurveyApp
//
//  Created by Stefan Diaconu on 04/03/2019.
//  Copyright © 2019 Stefan Diaconu. All rights reserved.
//

import UIKit
import CoreData

class Screen3aViewController: UIViewController {

    var person:Person!
    
    @IBAction func answerButton(_ sender: UIButton) {
        // set the answer according the button pressed
        switch sender.tag {
        case 0: person.q2 = "Work"
        case 1: person.q2 = "Games"
        case 2: person.q2 = "Internet"
        case 3: person.q2 = "Social networking"
        case 4: person.q2 = "Others"
        default: print("no selection")
        }
        confirm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        person.printPerson()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // set segue to next view controller
        if segue.destination is Screen4ViewController{
            let vc = segue.destination as? Screen4ViewController
            // pass the person object to next view controller
            vc?.person = person
        }
    }
    
    func confirm(){
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let titFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 25.0)!]
        let msgFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 20.0)!]
        
        let titAttrString = NSMutableAttributedString(string: "Confirm", attributes: titFont)
        let msgAttrString = NSMutableAttributedString(string: "Please confirm your answer and proceed to next question or Cancel to review your answer", attributes: msgFont)
        
        alertController.setValue(titAttrString, forKey: "attributedTitle")
        alertController.setValue(msgAttrString, forKey: "attributedMessage")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        let confirmAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:{(_) in self.performSegue(withIdentifier: "fourthView", sender: self)})
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
