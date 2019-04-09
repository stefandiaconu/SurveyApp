//
//  Screen5ViewController.swift
//  SurveyApp
//
//  Created by Stefan Diaconu on 04/03/2019.
//  Copyright © 2019 Stefan Diaconu. All rights reserved.
//

import UIKit
import CoreData

class Screen5ViewController: UIViewController {
    
    var person:Person!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        person.printPerson()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitButton(_ sender: Any) {
        savingData()
    }
    
    @IBAction func myUnwindFunction(unwindSegue: UIStoryboardSegue) {
    }

    func savingData(){
        
        // refer to container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // create entity and new user records
        let userEntity = NSEntityDescription.entity(forEntityName: "Data", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(person.firstName, forKeyPath: "firstName")
        user.setValue(person.lastName, forKeyPath: "lastName")
        user.setValue(person.id, forKeyPath: "id")
        user.setValue(person.dateOfBirth, forKeyPath: "dateOfBirth")
        user.setValue(person.q1, forKey: "q1")
        user.setValue(person.q2, forKey: "q2")
        user.setValue(person.q3, forKey: "q3")
        
        // save inside the Core Data
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
