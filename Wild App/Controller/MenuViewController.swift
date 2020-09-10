//
//  MenuViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit
import Firebase
import Nuke

class MenuViewController: UIViewController, UpdateTabBar {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    var group = Group(name: "1", avalible: true)
    
    var storage: Storage?
    var groupStorageRef: StorageReference?
    
    var avalibleGroupList: [Group] = []
    var avalibleProductList: [Product] = []
    var productInGroup: [Product] = []
    
    var numberSelected = 0
    
    var oldContentOffset: CGFloat = 0
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

        progressIndicator.startAnimating()
//        WorkWithDatabase.addSyropToDatabase()
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")

        if launchedBefore {} else {
            performSegue(withIdentifier: "toRegistrationFromMenu", sender: self)
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        if !Reachability.isConnectedToNetwork(){
            showErrod(error: "Для работы приложения необходимо подключение к интернету, пожалуйста подключитесь к сети")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage = Storage.storage()
        
        self.tableView.rowHeight = 250
        
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "TableMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TableMenuCollectionViewCell")
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductReusableCell")
        
        
        WorkWithDatabase.getAllAvalibleGroup { group, error  in
            
            if group != nil{
                self.avalibleGroupList.append(contentsOf: group!)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showErrod(error: error!.localizedDescription)
            }
            
        }
        
        WorkWithDatabase.getAllAvalibleProduct { (products) in
            self.avalibleProductList.append(contentsOf: products)
            self.productInGroup = self.avalibleProductList.filter{$0.group == self.avalibleGroupList[self.numberSelected].name}
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.progressIndicator.isHidden = true
        
            }
        }
    }
    
    func updateSecondItemBadge(count: String) {
        tabBarController?.tabBar.items?[1].badgeValue = count
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


//MARK: -TableViewExtension

extension MenuViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productInGroup.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductReusableCell", for: indexPath) as! ProductCell
        
        cell.label!.text = productInGroup[indexPath.row].name
        cell.subLabel!.text = productInGroup[indexPath.row].description
        
        Nuke.loadImage(with: URL(string: productInGroup[indexPath.row].imageUrl)!, into: cell.imageForProduct)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ToCardFromMenu", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToCardFromMenu" {
            
            let destinationVC = segue.destination as! CardViewController
            
            destinationVC.delegate = self
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.product = self.productInGroup[indexPath.row]
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if scrollView == tableView {
            
            let contentOffset =  scrollView.contentOffset.y - oldContentOffset
            
            
            // Scrolls UP - we compress the top view
            if contentOffset > 0 && scrollView.contentOffset.y > 0 {
                if (imageViewTopConstraint.constant - contentOffset) > -123  {
                    imageViewTopConstraint.constant -= contentOffset
                    scrollView.contentOffset.y -= contentOffset
                }
            }
            
            // Scrolls Down - we expand the top view
            if contentOffset < 0 && scrollView.contentOffset.y < 0 {
                if (imageViewTopConstraint.constant < 10) {
                    if imageViewTopConstraint.constant - contentOffset > 10 {
                        imageViewTopConstraint.constant = 10
                    } else {
                        imageViewTopConstraint.constant -= contentOffset
                    }
                    scrollView.contentOffset.y -= contentOffset
                }
            }
            oldContentOffset = scrollView.contentOffset.y
            
        }
    }
    
}


//MARK: -CollectionViewExtension

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        avalibleGroupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableMenuCollectionViewCell", for: indexPath) as! TableMenuCollectionViewCell
        
        if numberSelected == indexPath.row {
            cell.groupName?.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            cell.backView.backgroundColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
            
        } else {
            cell.groupName?.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            cell.backView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        }
        
        
        cell.groupName?.text = avalibleGroupList[indexPath.row].name
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        numberSelected = indexPath.row
        
        self.productInGroup = avalibleProductList.filter{$0.group == self.avalibleGroupList[numberSelected].name}
        
        self.collectionView.reloadDataWithoutScroll()
        
        self.tableView.reloadData()
        
    }
    
}


extension UICollectionView {
    
    func reloadDataWithoutScroll() {
        let offset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(offset, animated: false)
    }
}
