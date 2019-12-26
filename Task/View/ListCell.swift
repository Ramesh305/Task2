//
//  ListCell.swift
//  Task
//
//  Created by Ramesh Mishra on 25/12/19.
//  Copyright © 2019 ramesh.mishra. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configuration(person:Person){
        DispatchQueue.main.async {
            self.name.text = person.name
            self.mobileNumber.text = person.mobileNumber
        }
        
    }
    
    
    

}
