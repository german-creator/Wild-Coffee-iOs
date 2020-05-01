//
//  RegistrationViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }
    @IBAction func registrationTapped(_ sender: UIButton) {
        
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

    }
}
