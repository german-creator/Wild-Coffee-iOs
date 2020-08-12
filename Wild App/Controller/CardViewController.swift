//
//  CardViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit
import Nuke

protocol UpdateTabBar {
    func updateSecondItemBadge(count: String)
}


class CardViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var volumeCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imageForProduct: UIImageView!
    
    var delegate: UpdateTabBar?
    
    var product: Product?
    
    var productInBasket: ProductInBasket?
    var numberInBasket: Int?
    
    
    var pickerView = UIPickerView()
    var selectedTextField = UITextField()
    var selectedAddNumber = 0
    var count = 1
    var selectedAdd: [Int : Int] = [ : ]
    var cost = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        minusButton.layer.cornerRadius = 5
        plusButton.layer.cornerRadius = 5
        buttonAdd.layer.cornerRadius = 15
        buttonAdd.layer.borderWidth = 2
        buttonAdd.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
        tableView.rowHeight = 50
        
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardReusableCell")
        
        
        if productInBasket != nil {
            
            titleLabel.text = productInBasket?.name
            subTitleLabel.text = productInBasket?.description
            
            basketMode()
            
        } else {
            cost = product!.cost
            
            if product!.add.count != 0 {
                for i in 0...product!.add.count - 1 {
                    selectedAdd[i] = 0
                }
            }
            
            buttonAdd.setTitle("\(product!.cost) ₽", for: .normal)
            
            
            Nuke.loadImage(with: URL(string: product!.imageUrl)!, into: imageForProduct)

            titleLabel.text = product?.name
            subTitleLabel.text = product?.description
            volumeCount.text = String(product!.volume) + " мл"
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        

        
    }
    
    func basketMode() {
        
        selectedAdd = productInBasket?.selectedAdd as! [Int : Int]
        count = productInBasket!.count
        cost = productInBasket!.cost * count
        
        
        for i in 0...((productInBasket?.add.count )! - 1) {
            if productInBasket?.add[i].costOption.count !=  0 {
                cost += (productInBasket?.add[i].costOption[selectedAdd[i]!])! * count
            }
        }
        
        Nuke.loadImage(with: URL(string: productInBasket!.imageUrl)!, into: imageForProduct)

        volumeCount.text = String(productInBasket!.volume) + " мл"
        countLabel.text = String(count)
        buttonAdd.setTitle("\(cost) ₽", for: .normal)
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardReusableCell")
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        count += 1
        countLabel.text = String(count)
        updateButtonTitle()
    }
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        
        if count != 1 {
            count -= 1
            updateButtonTitle()
            countLabel.text = String(count)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        var basketList = Service.sharedInstance.baskedtList
        
        if self.productInBasket != nil {
            
            productInBasket?.count = count
            productInBasket?.selectedAdd = selectedAdd
            basketList![numberInBasket!] = productInBasket!
            
            
        } else {
            
            let productInBasket = ProductInBasket(count: count, selectedAdd: selectedAdd , product: product!)
            
            if basketList == nil {
                basketList = [productInBasket]
                
            } else {
                basketList?.append(productInBasket)
            }
        }
        
        
        var count = 0
        
        for i in basketList! {
            count += i.count
            
            Service.sharedInstance.baskedtList = basketList
            
            delegate?.updateSecondItemBadge(count: String(count))
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func updateButtonTitle() {
        
        var a = 0
        
        if productInBasket != nil {
            for i in 0...productInBasket!.add.count-1 {
                if (productInBasket!.add[i].costOption.count != 0){
                    a += productInBasket!.add[i].costOption[selectedAdd[i]!] * count
                    cost = count*productInBasket!.cost + a
                    
                }
            }
        } else {
            for i in 0...product!.add.count-1 {
                if (product!.add[i].costOption.count != 0){
                    a += product!.add[i].costOption[selectedAdd[i]!] * count
                    cost = count*product!.cost + a
                    
                }
            }
        }
        
        
        
        
        buttonAdd.setTitle(String(cost) + " ₽", for: .normal)
    }
    
}


//MARK: -TableViewExtension

extension CardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if productInBasket != nil {
            return productInBasket!.add.count
            
        } else {
            return product?.add.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardReusableCell", for: indexPath) as! CardCell
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        if productInBasket != nil {
            cell.label.text = productInBasket?.add[indexPath.row].name
            cell.textField.text = productInBasket?.add[indexPath.row].option[selectedAdd[indexPath.row]!]
        } else {
            cell.label.text = product?.add[indexPath.row].name
            cell.textField.text = product?.add[indexPath.row].option[selectedAdd[indexPath.row]!]
        }
        cell.textField.inputView = self.pickerView
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CardCell
        
        
        selectedAddNumber = indexPath.row
        selectedTextField = cell.textField
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - CardCellProtocol

extension CardViewController: CardCellProtocol {
    
    func onClickCell(indexPath: IndexPath) {
        
        selectedAddNumber = indexPath.row
        
        let cell = self.tableView.cellForRow(at: indexPath) as! CardCell
        
        selectedTextField = cell.textField
        selectedTextField.becomeFirstResponder()
        
    }
}





// MARK: - Picker View

extension CardViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if productInBasket != nil {
            return productInBasket?.add[self.selectedAddNumber].option.count ?? 0
            
        } else {
            return product?.add[self.selectedAddNumber].option.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var cost = ""
        
        if productInBasket != nil {
            if productInBasket?.add[self.selectedAddNumber].costOption.count == 0 {
                cost = (productInBasket?.add[self.selectedAddNumber].option[row])!
            } else {
                let a = productInBasket?.add[self.selectedAddNumber].costOption[row]
                cost = (productInBasket?.add[self.selectedAddNumber].option[row])! + " \(String(describing: a!)) ₽"
            }
        } else {
            
            if product?.add[self.selectedAddNumber].costOption.count == 0 {
                cost = (product?.add[self.selectedAddNumber].option[row])!
            } else {
                let a = product?.add[self.selectedAddNumber].costOption[row]
                cost = (product?.add[self.selectedAddNumber].option[row])! + " \(String(describing: a!)) ₽"
            }
        }
        
        
        return cost
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if productInBasket != nil {
            selectedTextField.text = productInBasket?.add[self.selectedAddNumber].option[row]
            
        } else {
            selectedTextField.text = product?.add[self.selectedAddNumber].option[row]
        }
        
        selectedAdd[selectedAddNumber] = row
        
        
        view.endEditing(false)
        
        updateButtonTitle()
    }
}

