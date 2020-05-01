//
//  MenuViewController.swift
//  Wild App
//
//  Created by Герман Иванилов on 01.05.2020.
//  Copyright © 2020 Герман Иванилов. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController, UpdateTabBar {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var group = Group(name: "1", avalible: true)
    var product = Product()
    
    var avalibleGroupList: [Group] = []
    var avalibleProductList: [Product] = []
    
    var numberSelected = 0
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
//        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 230
        
        
        avalibleGroupList = Service.sharedInstance.allGroupList.filter{$0.avalible == true}
        avalibleProductList = Service.sharedInstance.allProductList.filter{$0.avalible == true && $0.group == avalibleGroupList[numberSelected].name}
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "TableMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TableMenuCollectionViewCell")
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductReusableCell")
        
        
    }
    
    func updateSecondItemBadge(count: String) {
        tabBarController?.tabBar.items?[1].badgeValue = count
        
    }
}


//MARK: -TableViewExtension

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        avalibleProductList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductReusableCell", for: indexPath) as! ProductCell
        
        cell.label!.text = avalibleProductList[indexPath.row].name
        cell.subLabel!.text = avalibleProductList[indexPath.row].description
        
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
                destinationVC.product = self.avalibleProductList[indexPath.row]
            }
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
            cell.groupName?.textColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        } else {
            cell.groupName?.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
        
        
        cell.groupName?.text = avalibleGroupList[indexPath.row].name
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        numberSelected = indexPath.row
        
        avalibleProductList = Service.sharedInstance.allProductList.filter{$0.avalible == true && $0.group == avalibleGroupList[numberSelected].name}
        
        self.collectionView.reloadDataWithoutScroll()
        
        self.tableView.reloadData()
    }
    
    func updateTableView (groupName : String) {
        
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
