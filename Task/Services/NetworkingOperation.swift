//
//  NetworkingOperation.swift
//  Task
//
//  Created by Ramesh Mishra on 25/12/19.
//  Copyright © 2019 ramesh.mishra. All rights reserved.
//

import UIKit
class NetWorkingOperation{
    
    private init(){
        
    }
    
    static var shared:NetWorkingOperation = NetWorkingOperation()
    func fetchDataFromServer(complition:@escaping (Data?,Error?)->Void){
        guard let urlString = URL(string:"https://jsonplaceholder.typicode.com/users") else {
            complition(nil,nil)
            return ;
        }
        
        let shared = URLSession.shared
        let task = shared.dataTask(with:urlString) { (data, respose, error) in
            if let error = error{
                complition(nil,error)
                return
            }

            if let data = data{
                print(data)
                complition(data,nil)
                
            }
        }
        task.resume()
        
    }
    
    
    
    
}
