//
//  ProfileViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var pickerDate = ["Классическое молоко", "Кокосовое молоко", "Миндальное молоко", "Соевое молоко", "Овсянное молоко"]
    
    private var picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
