//
//  PopUpVIewControllerViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 12.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.7058219314, green: 0.7059226036, blue: 0.7057901025, alpha: 1).withAlphaComponent(0.5)
        backView.layer.cornerRadius = 20
        imageView.layer.cornerRadius = 20
        
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
        showAnimate()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view != backView {
            removeAnimate()
        }
    }
    
    @IBAction func startHighlight(_ sender: UIButton) {
        button.layer.borderColor = #colorLiteral(red: 0.3817316294, green: 0.9095525146, blue: 0.8818981051, alpha: 0.2044360017)
    }

    @IBAction func stopHighlight(_ sender: UIButton) {
        button.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)

    }
    
    @IBAction func orderClick(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView.alpha = 0.6
            self.label.alpha = 0
            self.subLabel.alpha = 0
            self.button.alpha = 0
            
            let parentVC = self.parent?.children
            
            parentVC?.forEach({ (controller) in
                if controller is OrderViewController  {
                    let a = controller as! OrderViewController
                    a.sentOrder()
                }
            })
        });
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in self.removeAnimate() }
    }
    
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.1, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
}
