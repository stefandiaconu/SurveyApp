//
//  TableViewController.swift
//  SurveyApp
//
//  Created by Stefan Diaconu on 21/03/2019.
//  Copyright © 2019 Stefan Diaconu. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var persons:[Person] = []
    var table:[String] = []
    let simpleTableIdentifier = "SimpleTableIdentifier"
    var p:Person!
    
    var first:String = ""
    var last:String = ""
    var idPerson = ""
    var date:String = ""
    var question1 = false
    var question2 = ""
    var question3 = false
    //Person p = new Person(firstName:first, lastName:last, id:idPerson, dateOfBirth:date, q1:question1, q2:question2, q3:question3)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        // Do any additional setup after loading the view.
    }
    
    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        
        //fetchRequest.fetchLimit = 1
        //fetchRequest.predicate = NSPredicate(format: "id = %@", idText.text!)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: false)]
        //p = Person(firstName: first, lastName: last, id: idPerson, dateOfBirth: date, q1: question1, q2: question2, q3: question3)
//        p = Person()
//        print(p)
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for data in result as! [NSManagedObject] {
                p = Person()
                p.printPerson()
                print(result)
                print(data.value(forKey: "firstName") as? String ?? "")
                print(data.value(forKey: "lastName") as? String ?? "")
                print(data.value(forKey: "id") as? String ?? "")
                print(data.value(forKey: "dateOfBirth") as? String ?? "")
                print(data.value(forKey: "q1") as? Bool ?? false)
                print(data.value(forKey: "q2") as? String ?? "")
                print(data.value(forKey: "q3") as? Bool ?? false)
                p.firstName = (data.value(forKey:"firstName") as? String ?? "")
                p.lastName = (data.value(forKey:"lastName") as? String ?? "")
                p.id = (data.value(forKey:"id") as? String ?? "")
                p.dateOfBirth = (data.value(forKey:"dateOfBirth") as? String ?? "")
                p.q1 = (data.value(forKey:"q1") as? Bool ?? false)
                p.q2 = (data.value(forKey:"q2") as? String ?? "")
                p.q3 = (data.value(forKey:"q3") as? Bool ?? false)
                p.printPerson()
                let s = "Name: \(p.firstName) \(p.lastName), id: \(p.id), date of birth:: \(p.dateOfBirth), answer question 1: \(String(describing: p.q1)), answer question2: \(p.q2), answer question 3: \(String(describing: p.q3))"
                table.append(s)
                print("\(table), Abracadabra")
            }
//            p.printPerson()
//            let s = "\(p.firstName), \(p.lastName), \(p.id), \(p.dateOfBirth), \(String(describing: p.q1)), \(p.q2), \(String(describing: p.q3))"
//            table.append(s)
            
        } catch {
            
            print("Failed")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if (cell == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: simpleTableIdentifier)
        }
        cell?.textLabel?.text = table[indexPath.row]

        return cell!
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
