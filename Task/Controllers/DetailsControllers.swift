//
//  DetailsControllers.swift
//  Task
//
//  Created by Ramesh Mishra on 25/12/19.
//  Copyright © 2019 ramesh.mishra. All rights reserved.
//

import UIKit

class DetailsControllers: UIViewController {
    var details:Person?
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
      
        
    }
    
    
   
    
}





//MARK:UITableViewDataSource

extension DetailsControllers: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier:"userDetailsCell", for: indexPath) as? UserDetailsCell
            cell?.name.text = details?.name
            cell?.userName.text = details?.userName
            cell?.eamilId.text = details?.emailId
            cell?.phone.text = details?.mobileNumber
            return cell!
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier:"address", for: indexPath) as? AddressCell
            cell?.streetName.text = details?.street
            cell?.cityName.text = details?.city
            cell?.zipName.text = details?.zipcode
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier:"companyDetails", for: indexPath) as? CompanyDetails
            cell?.companyName.text = self.details?.companyName
            cell?.websiteName.text = self.details?.website
            return cell!
        }
    }
    
}

//MARK: UITableViewDelegate

extension DetailsControllers : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 170
        }else if indexPath.row == 1{
            return 140
        }else if indexPath.row == 2{
            return 110
        }else{
            return 0
        }
    }
    
}
