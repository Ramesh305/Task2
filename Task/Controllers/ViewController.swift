//
//  ViewController.swift
//  Task
//
//  Created by Ramesh Mishra on 25/12/19.
//  Copyright © 2019 ramesh.mishra. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var refreshControl = UIRefreshControl()
    var person:[Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User List"
        
        tableview.delegate = self
        tableview.dataSource = self
        if(ReachabilityTest.isConnectedToNetwork()){
            
             getDataFromserver()
            
        }else{
          AlertShow.showMessage(vc:self, message:"No InterNet Connection")
            let fecthData:NSFetchRequest<Person> = Person.fetchRequest()
            do{
                let person12 = try PersistanceData.context.fetch(fecthData)
                print("ramesh",person12.count)
                self.person = person12
            }catch{

            }

            
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableview.addSubview(refreshControl)
        
    }
   
    @objc func refresh(_ sender: Any) {
        if(ReachabilityTest.isConnectedToNetwork()){
            getDataFromserver()
             refreshControl.endRefreshing()
            print("loding data")
        }else{
            AlertShow.showMessage(vc:self, message:"No InterNet Connection")
            refreshControl.endRefreshing()
            let fecthData:NSFetchRequest<Person> = Person.fetchRequest()
            do{
                let person12 = try PersistanceData.context.fetch(fecthData)
                print("ramesh",person12.count)
                self.person = person12
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    
                }
            }catch{

            }
            
        }
        
        
    }

}


//MARK:Get data from server
extension ViewController{
    
    func getDataFromserver(){
        NetWorkingOperation.shared.fetchDataFromServer { (data,error) in
            
                  
            if let error = error{
                AlertShow.showMessage(vc: self, message:error.localizedDescription)
                return
            }
            
                   guard let data = data else{
                    AlertShow.showMessage(vc: self, message:"Error from server")
                       return
                   }
                   do{
                       self.person.removeAll()
                       let fecthData:NSFetchRequest<Person> = Person.fetchRequest()
                        let person12 = try PersistanceData.context.fetch(fecthData)
                       for person in person12{
                           PersistanceData.context.delete(person)
                           PersistanceData.saveContext()
                           print("ok")
                       }
                       
                       let json = try JSON(data: data)
                                      print(json)
                       if let jsonArray = json.array{
                           for i in 0..<jsonArray.count{
                               let person = Person(context:PersistanceData.context)
                               person.name = jsonArray[i]["name"].string ?? ""
                               person.emailId = jsonArray[i]["email"].string ?? ""
                               person.userName = jsonArray[i]["username"].string ?? ""
                               person.mobileNumber = jsonArray[i]["phone"].string ?? ""
                               person.city = jsonArray[i]["address"]["city"].string ?? ""
                               person.street = jsonArray[i]["address"]["street"].string ?? ""
                               person.zipcode = jsonArray[i]["address"]["zipcode"].string ?? ""
                               person.website = jsonArray[i]["website"].string ?? ""
                               person.companyName = jsonArray[i]["company"]["name"].string ?? ""
                               PersistanceData.saveContext()
                               self.person.append(person)
                               print("save data")
                               
                           }
                       }
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                       
                       }catch{
                           print(error.localizedDescription)
                   }
                   print(data)
               }
        
    }
}


//MARK:UITableViewDataSource

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.person.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as?ListCell
        cell?.configuration(person: self.person[indexPath.row])
        cell?.selectionStyle = .none
        return cell!
    }
    
}

//MARK:UITableViewDelegate

extension ViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsControllers") as! DetailsControllers
        nextViewController.details = self.person[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
