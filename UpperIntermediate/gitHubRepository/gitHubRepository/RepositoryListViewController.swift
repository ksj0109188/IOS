//
//  RepositoryListViewController.swift
//  gitHubRepository
//
//  Created by 김성준 on 2022/07/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class RepositoryListViewController: UITableViewController {
    private let organization = "Apple"
    private let repositories = BehaviorSubject<[Repsitory]>(value: [])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + "Repositories"
        
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl
        refreshControl?.backgroundColor = .white
        refreshControl?.tintColor = .darkGray
        refreshControl?.attributedTitle = NSAttributedString("당겨서 새로고침")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(RepositroyListCell.self, forCellReuseIdentifier: "RepositroyListCell")
        tableView.rowHeight = 140
    }
    
    @objc func refresh(){
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {return}
            self.fetchRepositries(of: self.organization)
        }
    }
    
    func fetchRepositries(of organization: String){
        Observable.from([organization])
            .map{ organization -> URL in
                return URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map{ url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            .flatMap{ request -> Observable<(response: HTTPURLResponse, data:Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter { response, _ in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [[String:Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data,options: []),
                        let result = json as? [[String:Any]] else {
                    return []
                }
                return result
            }
            .filter{result in
                return result.count > 0
            }
            .map{ objects in
                return objects.compactMap { dic -> Repsitory? in
                    guard let id = dic["id"] as? Int,
                          let name = dic["name"] as? String,
                          let desciprtion = dic["description"] as? String,
                          let stargazersCount = dic["stargazersCount"] as? Int,
                          let language = dic["language"] as? String else{
                        return nil
                    }
                    return Repsitory(id: id, name: name, description: desciprtion, stargazersCount: stargazersCount, language: language)
                }
            }
            .subscribe(
                onNext: { [weak self] newRepositrories in
                    self?.repositories.onNext(newRepositrories)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.refreshControl?.endRefreshing()
                    }
               })
            .disposed(by: disposeBag)
    }
}

//UITableView datasource delegate
extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        do {
            return try repositories.value().count
        } catch {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositroyListCell", for: indexPath) as? RepositroyListCell else {return UITableViewCell()}
        var currentrepo:Repsitory? {
            do {
                return try repositories.value()[indexPath.row]
            }catch {
                return nil
            }
        }
        cell.repository = currentrepo
        return cell
    }
}
