//
//  StationSearchViewController.swift
//  SubwatStation
//
//  Created by 김성준 on 2022/06/19.
//

import SnapKit
import UIKit

class StationSearchViewController: UIViewController {
    private var numbrOfCells : Int = 0
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        setTableViewLayout()
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
     
    }

    private func setTableViewLayout(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
extension StationSearchViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        numbrOfCells = 10
        tableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        numbrOfCells = 0
        tableView.isHidden = true
    }
}

extension StationSearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbrOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.item)"
        
        return cell
    }
}
