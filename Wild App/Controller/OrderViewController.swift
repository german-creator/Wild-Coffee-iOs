//
//  OrderViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit
import SwipeCellKit
import Nuke

class OrderViewController: UIViewController, UpdateTabBar {
    
    var timeArray: [String] = ["", "5 минут", "10 минут", "15 минут", "20 минут", "25 минут", "30 минут"]
    var basketList: [ProductInBasket] = []
    
    @IBOutlet weak var topLabel1: UILabel!
    @IBOutlet weak var topLabel2: UILabel!
    var pickerView = UIPickerView()
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputDateTextField: UITextField!
    @IBOutlet weak var orderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderButton.layer.cornerRadius = 15
        orderButton.layer.borderWidth = 2
        orderButton.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
        self.tableView.rowHeight = 110
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderReusableCell")
        
        pickerView.dataSource = self
        pickerView.delegate = self
        inputDateTextField.inputView = pickerView
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        basketList = Service.sharedInstance.baskedtList ?? []
        updateTopLabels()
        tableView.reloadData()
        
        
    }
    
    func updateTopLabels () {
        var count = 0
        var cost = 0
        var costNextWord = ""
        
        
        for i in basketList {
            count += i.count
            var addCost = 0
            for j in 0...i.add.count - 1 {
                if i.add[j].costOption.count != 0 {
                    addCost += i.add[j].costOption[i.selectedAdd[j]!] * i.count
                }
            }
            cost += i.cost * i.count + addCost
        }
        
        switch count {
        case 1:
            costNextWord = "напиток"
        case 2...4:
            costNextWord = "напитка"
        default:
            costNextWord = "напитков"
        }
        topLabel1.text = "В заказе \(count) \(costNextWord)"
        topLabel2.text = "на \(cost) ₽"
        
    }
    
    func updateSecondItemBadge(count: String) {
        
        if count == "0"{
            tabBarController?.tabBar.items?[1].badgeValue = nil
        } else {
            tabBarController?.tabBar.items?[1].badgeValue = count
            
        }
        viewDidAppear(true)
        
    }
    
    @IBAction func textInputButtonClick(_ sender: UIButton) {
        inputDateTextField.becomeFirstResponder()
    }
    
    @IBAction func doneTextField(_ sender: UITextField)  {
        commentTextField.resignFirstResponder()
        
    }
    
    
    @IBAction func clickOrderButton(_ sender: UIButton) {
        
        commentTextField.resignFirstResponder()
        inputDateTextField.resignFirstResponder()
        
        if !FirebaseAuthentication.checkUserLogin(){
            showErrod(error: "Для заказа напитков необходимо зарегестрироваться")
            
        } else{
            if basketList.count == 0 {
                
                showErrod(error: "Добавьте напитки в заказ")
                
            } else {
                if inputDateTextField.text == "" {
                    
                    showErrod(error: "Выберите время")
                    
                    
                } else {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popUpId") as! PopUpViewController
                    
                    self.parent!.addChild(popOverVC)
                    popOverVC.view.frame =  self.parent!.view.frame
                    self.parent!.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParent:  self.parent!)
                    
                }
            }
        }
        
    }
    
    func sentOrder()  {
        let order = Order(products: basketList, comment: commentTextField.text ?? "", timeTo: inputDateTextField.text ?? "")
        WorkWithDatabase.puchOrderToDatabase(order: order)
        Service.sharedInstance.baskedtList = []
        tabBarController?.tabBar.items?[1].badgeValue = nil
        
        viewDidAppear(true)
        inputDateTextField.text = ""
        commentTextField.text = ""
        
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
    
    @IBAction func startHighlight(_ sender: UIButton) {
        orderButton.layer.borderColor = #colorLiteral(red: 0.3817316294, green: 0.9095525146, blue: 0.8818981051, alpha: 0.2044360017)
    }

    @IBAction func stopHighlight(_ sender: UIButton) {
        orderButton.layer.borderColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
    }
    
}



// MARK: - Table View

extension OrderViewController: UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Удалить") { action, indexPath in
            
            self.basketList.remove(at: indexPath.row)
            Service.sharedInstance.baskedtList = self.basketList
            
            var count = 0
            for i in self.basketList {
                count += i.count
            }
            
            self.updateSecondItemBadge(count: String(count))
            
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        deleteAction.font = UIFont(descriptor: UIFontDescriptor(name: "SF Mono", size: 15), size: 15)
        deleteAction.image = UIImage(named: "bin")
        
        return [deleteAction]
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderReusableCell", for: indexPath) as! OrderCell
        
        cell.delegate = self
        
        var labelList: [UILabel] = []
        
        cell.subLabel1.text = ""
        cell.subLabel2.text = ""
        cell.subLabel3.text = ""
        cell.subLabel4.text = ""
        
        labelList.append(cell.subLabel1)
        labelList.append(cell.subLabel2)
        labelList.append(cell.subLabel3)
        labelList.append(cell.subLabel4)
        
        let count = basketList[indexPath.row].count
        
        cell.countLabel.text = ""
        
        if count != 1 {
            cell.countLabel.text = "\(count) шт"
        }
        
        cell.label.text = basketList[indexPath.row].name
        
        var addCost = 0
        
        for i in 0...basketList[indexPath.row].add.count - 1 {
            
            if basketList[indexPath.row].selectedAdd[i] != 0 {
                if i == 0 {
                    cell.subLabel1.text = basketList[indexPath.row].add[i].option[basketList[indexPath.row].selectedAdd[i]!]
                    if basketList[indexPath.row].add[i].costOption.count != 0 {
                        addCost +=  basketList[indexPath.row].add[i].costOption[basketList[indexPath.row].selectedAdd[i]!]
                    }
                } else {
                    if labelList[i-1].text == ""{
                        labelList[i-1].text = basketList[indexPath.row].add[i].option[basketList[indexPath.row].selectedAdd[i]!]
                        if basketList[indexPath.row].add[i].costOption.count != 0 {
                            addCost +=  basketList[indexPath.row].add[i].costOption[basketList[indexPath.row].selectedAdd[i]!]
                        }
                        
                    } else {
                        labelList[i].text = basketList[indexPath.row].add[i].option[basketList[indexPath.row].selectedAdd[i]!]
                        if basketList[indexPath.row].add[i].costOption.count != 0 {
                            
                            addCost +=  basketList[indexPath.row].add[i].costOption[basketList[indexPath.row].selectedAdd[i]!]
                        }
                    }
                }
            }
        }
        
        cell.costLabel.text = "\((basketList[indexPath.row].cost + addCost)*count) ₽"
        
        
        Nuke.loadImage(with: URL(string: basketList[indexPath.row].imageUrl)!, into: cell.imageForProduct)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ToCardFromOrder", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToCardFromOrder" {
            
            let destinationVC = segue.destination as! CardViewController
            
            destinationVC.delegate = self
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.productInBasket = self.basketList[indexPath.row]
                destinationVC.numberInBasket = indexPath.row
                
            }
        }
        
    }
}

// MARK: - Picker View

extension OrderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        timeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        timeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputDateTextField.text = timeArray[row]
        view.endEditing(false)
    }
    
}
