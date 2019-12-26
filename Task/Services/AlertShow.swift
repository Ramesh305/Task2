//
//  AlertShow.swift
//  Task
//
//  Created by Ramesh Mishra on 26/12/19.
//  Copyright © 2019 ramesh.mishra. All rights reserved.
//

import UIKit
class AlertShow{
    
    private init(){
        
    }
    static var shared = AlertShow()
    static func showMessage(vc:UIViewController,message:String) {
        
        let alert = UIAlertController(title:"Alert", message:nil, preferredStyle:.alert)
        let actionAlert = UIAlertAction(title:message, style:.default) { (_) in
            print("ok")
        }
        
        alert.addAction(actionAlert)
        vc.present(alert, animated: true, completion:nil)
        
        
        
    }
    
    
    
}
