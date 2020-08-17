//
//  LoginViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 30.07.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit
import AnyFormatKit
import Firebase


protocol UpdateProfileVCToLogin {
    func starLoginMode()
}



class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewButtom: UIView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var verificationID: String?
    
    var delegate: UpdateProfileVCToLogin?
    
    var prevVC: UIViewController?

    
    
    override func viewDidLoad() {
        
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        phoneNumberTextField.resignFirstResponder()
        
        let s = phoneNumberTextField.text
        let phoneNumber = "+7" + s!.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression).dropFirst()
        
        Auth.auth().languageCode = "ru";
        
        if phoneNumber.count < 12 {
            showErrod(error: "Пожалуйста, введите ваш номер телефона")
        } else {
            
            progressIndicator.isHidden = false
            progressIndicator.startAnimating()
            viewTop.isHidden = true
            loginButton.isHidden = true
            phoneNumberTextField.isHidden = true
            titleLabel.isHidden = true
            
            
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                self.progressIndicator.isHidden = true
                
                if let error = error {
                    self.showErrod(error: error.localizedDescription)
                    self.viewTop.isHidden = false
                    self.loginButton.isHidden = false
                    self.phoneNumberTextField.isHidden = false
                    self.titleLabel.isHidden = false
                    
                    return
                }
                
                self.verificationID = verificationID
                self.codeTextField.isHidden = false
                self.viewButtom.isHidden = false
                self.codeTextField.becomeFirstResponder()
                
                
            }
            
        }
        
    }
    
    @IBAction func checkInPressed(_ sender: UIButton) {
        
        if prevVC != nil {
            self.dismiss(animated: true, completion: nil)
        }
        performSegue(withIdentifier: "toCheckImFromLogin", sender: nil)
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        
        if (sender.text!.count > 14) {
            sender.deleteBackward()
        } else{
            guard let text = sender.text else { return }
            sender.text = text.applyPatternOnNumbers(pattern: "#(###)###-####", replacmentCharacter: "#")
        }
    }
    
    @IBAction func startHighlight(_ sender: UIButton) {
        loginButton.layer.borderColor =   #colorLiteral(red: 0.3817316294, green: 0.9095525146, blue: 0.8818981051, alpha: 0.2044360017)
    }
    
    @IBAction func stopHighlight(_ sender: UIButton) {
        loginButton.layer.borderColor =  #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
    }
    
    @IBAction func doneTextField(_ sender: UITextField) {
        phoneNumberTextField.resignFirstResponder()
    }
    
    
    @IBAction func codeChanged(_ sender: UITextField) {
        
        guard let text = sender.text else { return }
        sender.text = text.applyPatternOnNumbers(pattern: "######", replacmentCharacter: "#")
        
        if sender.text!.count > 6 {
            sender.deleteBackward()
            
        }
        
        if sender.text!.count == 6{
            
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID!,
                verificationCode: sender.text!)
            
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error{
                    self.showErrod(error: error.localizedDescription)
                    return
                }
                
                self.delegate?.starLoginMode()
                self.dismiss(animated: true, completion: nil)
                self.prevVC?.dismiss(animated: false, completion: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? CheckInViewController {
            destinationVC.prevVC = self
            destinationVC.delegate = delegate

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


extension String {
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
//            let stringIndex = String.Index(encodedOffset: index)
            let stringIndex = String.Index(utf16Offset: index, in: pureNumber)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
