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
    var currentPage = 1
    var dataTasks = [URLSessionTask]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar
        title = "패캠브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //UITableView 설정
        tableView.register(BeerListCelll.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150
        tableView.prefetchDataSource = self
        fetchBeer(of: currentPage)
        
    }
}

//UITableView DataSource, Delegate
extension BeerListViewController: UITableViewDataSourcePrefetching{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCelll else {return UITableViewCell()}
                
        let beer = beerList[indexPath.row]
        cell.configure(beer: beer)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeeer = beerList[indexPath.row]
        let detailviewController = BeerDetailViewController()
        
        detailviewController.beer = selectedBeeer
        self.show(detailviewController, sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        guard currentPage != 1 else {return}
        //현재 페이지 값
        indexPaths.forEach{
            if ($0.row+1)/25 + 1 == currentPage{
                self.fetchBeer(of: currentPage)
            }
        }
    }
}

private extension BeerListViewController{
    func fetchBeer(of page: Int)  {
        //이미 실행된 페이지는 pass
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
              dataTasks.firstIndex(where: {
                  $0.originalRequest?.url == url
              }) == nil else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request){[weak self] data,response,error in
            guard error == nil,
                    let self = self,
                    let response = response as? HTTPURLResponse,
                    let data = data,
                    let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("ERROR : URLSession data task \(error?.localizedDescription)")
                return
            }
            switch response.statusCode{
            case (200...299):
                self.beerList += beers
                self.currentPage += 1
                
                //GCD 개념임
                //UITableView는 Main Thred에서 실행되야함
                //GCD가 관리하는 DispatchQueue객체를 통해 스레드를 Push, pop (스케줄링해서)
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            case (400...499):
                print("""
                    ERROR: Client ERROR \(response.statusCode)
                    RESPONSE: \(response)
                """)
            case (500...599):
                print("""
                    ERROR: Server ERROR \(response.statusCode)
                    RESPONSE: \(response)
                """)
            default :
                print("""
                    ERROR: \(response.statusCode)
                    RESPONSE: \(response)
                """)
            }
        }
        dataTask.resume()
        //실행된 페이지 task배열에 추가
        dataTasks.append(dataTask)
        
    }
}
