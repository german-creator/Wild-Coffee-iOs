//
//  AboutUsViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 17.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var instImageView: UIImageView!
    @IBOutlet weak var callImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        instImageView.isUserInteractionEnabled = true
        instImageView.addGestureRecognizer(instTapGestureRecognizer)
        
        let callTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(callTapped(tapGestureRecognizer:)))
        callImageView.isUserInteractionEnabled = true
        callImageView.addGestureRecognizer(callTapGestureRecognizer)
        
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let instagramHooks = "https://www.instagram.com/wild_coffee_/"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/wild_coffee_/")! as URL)
        }
    }
    
    @objc func callTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let url: NSURL = URL(string: "TEL://+73822231266")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
}
