//
//  ChangeNameViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 07.08.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit
import Firebase


class ChangeNameViewController: UIViewController {
    
    @IBOutlet weak var oldNameTextField: UITextField!
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    
    var delegate: UpdateProfileVCToLogin?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        changeButton.layer.cornerRadius = 15
        changeButton.layer.borderWidth = 2
        changeButton.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
         FirebaseAuthentication.getCurrentUserName(completionHandler: { (oldName) in
            self.oldNameTextField.text = oldName
        })
    }
    
    
    @IBAction func startHighlight(_ sender: UIButton) {
        changeButton.layer.borderColor =   #colorLiteral(red: 0.3817316294, green: 0.9095525146, blue: 0.8818981051, alpha: 0.2044360017)
    }
    
    @IBAction func stopHighlight(_ sender: UIButton) {
        changeButton.layer.borderColor =  #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
    }
    
    @IBAction func newNameDonePressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    

    @IBAction func changeAction(_ sender: UIButton) {
        
        if newNameTextField.text == "" {
            showErrod(error: "Пожалуйста, введите новое имя")
        } else {
            FirebaseAuthentication.setUserToDatabase(uid: Auth.auth().currentUser!.uid, name: newNameTextField.text!, phoneNumber: Auth.auth().currentUser!.phoneNumber!)
            self.delegate?.starLoginMode()
            self.dismiss(animated: true, completion: nil)
        }
    
        
    }
    
    
    func showErrod(error: String) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "SFMono-Regular", size: 17.0)!]
        let titleAttrString = NSMutableAttributedString(string: error, attributes: titleFont)
        
        alert.setValue(titleAttrString, forKey: "attributedMessage")
        alert.view.tintColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
}
