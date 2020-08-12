//
//  FirebaseAuthentication.swift
//  Wild App
//
//  Created by Герман Иванилов on 30.07.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseAuthentication {
    
    static func checkUserLogin() -> Bool  {
        
        if Auth.auth().currentUser?.uid != nil {
            
            return true
            
        }else{
            return false
            
        }
    }
    
    static func getCurrentUserName(completionHandler: @escaping (String) -> Void)  {
        
        let userUid = Auth.auth().currentUser!.uid
        
        Service.sharedInstance.ref.child("Users").child(userUid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as! [String: Any]
            
            let name = snapshotValue["name"] as! String
            
            completionHandler(name)
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func checkUserExist(phoneNumber: String, completionHandler: @escaping (Bool) -> Void){
        
        var exist = false
        
        Service.sharedInstance.ref.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for i in snapshot.children.allObjects as! [DataSnapshot] {
                let snapshotValue = i.value as! [String: Any]
                
                let phone = snapshotValue["phoneNumber"] as! String
                
                if phoneNumber == phone{
                    exist = true
                }
            
            }
            
            completionHandler(exist)


        }) { (error) in
            print(error.localizedDescription)
        }

        
    }
    
    static func setUserToDatabase(uid: String, name: String, phoneNumber: String){
        
        var userToDatabase: [String : Any] = [ : ]
        
        userToDatabase["name"] = name
        userToDatabase["phoneNumber"] = phoneNumber
        
        Service.sharedInstance.ref.child("Users").child(uid).setValue(userToDatabase)
        
    }
}



