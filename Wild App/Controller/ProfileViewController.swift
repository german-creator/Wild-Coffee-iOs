//
//  ProfileViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit
import Firebase



class ProfileViewController: UIViewController, UpdateProfileVCToLogin {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var logOffButton: UIButton!
    @IBOutlet weak var pleaseRegisterLabel: UILabel!
    @IBOutlet weak var buttonsToLoginStackView: UIStackView!
    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var bottomLineConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonToChangeName: UIButton!
    
    private var picker = UIPickerView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInButton.layer.cornerRadius = 15
        checkInButton.layer.borderWidth = 2
        checkInButton.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
        
        
        if FirebaseAuthentication.checkUserLogin() {
            starLoginMode()
        } else {
            starLogoutMode()
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toLoginFromProfile" {
            let destinationVC = segue.destination as! LoginViewController
            destinationVC.delegate = self
        }
        
        if segue.identifier == "toCheckInFormProfile" {
            let destinationVC = segue.destination as! CheckInViewController
            destinationVC.delegate = self
        }
        
        if segue.identifier == "toChangeNameFromProfile" {
            let destinationVC = segue.destination as! ChangeNameViewController
            destinationVC.delegate = self
        }
        
        
        
    }
    
    
    @IBAction func logOffButtonPressed(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let error as NSError {
            showErrod(error: error.localizedDescription )
        }
        
        starLogoutMode()
        
    }
    
    func starLogoutMode () {
        
        nameLabel.isHidden = true
        phoneLabel.isHidden = true
        topLineView.isHidden = true
        logOffButton.isHidden = true
        buttonToChangeName.isHidden = true
        bottomLineConstraint.constant = 20
        
        
        pleaseRegisterLabel.isHidden = false
        buttonsToLoginStackView.isHidden = false
        
        
    }
    
    func starLoginMode () {
        
        nameLabel.isHidden = false
        phoneLabel.isHidden = false
        topLineView.isHidden = false
        logOffButton.isHidden = false
        buttonToChangeName.isHidden = false
        bottomLineConstraint.constant = -20
        
        FirebaseAuthentication.getCurrentUserName { (name) in
            self.nameLabel.text = name
        }
        
        let phoneName = Auth.auth().currentUser!.phoneNumber!
        phoneLabel.text = "+7(***)***" + phoneName.suffix(4)
        
        
        pleaseRegisterLabel.isHidden = true
        buttonsToLoginStackView.isHidden = true
        
        
    }
    
    @IBAction func startHighlightLogin(_ sender: UIButton) {
        loginButton.layer.borderColor = #colorLiteral(red: 0.3817316294, green: 0.9095525146, blue: 0.8818981051, alpha: 0.2044360017)
    }
    
    
    @IBAction func stopHighlightLogin(_ sender: UIButton) {
        loginButton.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
    }
    
    
    
    @IBAction func startHighlightCheckIn(_ sender: UIButton) {
        checkInButton.layer.borderColor =   #colorLiteral(red: 0.3817316294, green: 0.9095525146, blue: 0.8818981051, alpha: 0.2044360017)
    }
    
    @IBAction func stopHighlightCheckIn(_ sender: UIButton) {
        checkInButton.layer.borderColor =  #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
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
