//
//  BeerListViewController.swift
//  Brewwery
//
//  Created by 김성준 on 2022/04/09.
//

import Foundation
import UIKit


class BeerListViewController: UITableViewController{
    var beerList = [Beer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar
        title = "패캠브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //UITableView 설정
        tableView.register(BeerListCelll.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150
        
    }
}

//UITableView DataSource, Delegate
extension BeerListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCelll else {return UITableViewCell()}
                
        let beer = beerList[indexPath.row]
        cell.configure(beer: beer)
        
        return cell
    }
}
