//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 김성준 on 2022/03/19.
//


import UIKit
import Kingfisher
import FirebaseDatabase

class CardListViewController: UITableViewController{
    var ref:DatabaseReference! // fire base realtime database
    
    
    var creditCardList : [CreditCard] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //custom UITableCell register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        ref = Database.database().reference()
        
        ref.observe(.value){ snapshot in
            guard let value = snapshot.value as? [String : [String : Any]] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String : CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error{
                print("ERROR JSON Parsing  \(error.localizedDescription)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else {return UITableViewCell()}
        
        cell.rankLabell.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else { return }
        
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        //option1 -> 불특정 시점에 cardId가 중복될수 있는 이슈가 발생함. -> critical
        let cardId = creditCardList[indexPath.row].id
        ref.child("Item\(cardId)/isSelected").setValue(true)
        
        //option2 -> 특정 객체의 고유값 ex) id를 활용
        //realtime database에 저장된 json객체중 key값이 id인 것을 검색
        
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value) {[weak self] snapshot
//            in
//            guard let self = self,
//                  let value = snapshot.value as? [String : [String : Any]],
//                  // id를 기준으로 검색하고 해당 객체의 key값 또한 id와 동일
//                  let key = value.keys.first else { return }
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
    }
    //table cell에 swipe제스처 기능 추가
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete{
            //option 1
            //key값을 유추할 수 있을때
            let cardId = creditCardList[indexPath.row].id
//            ref.child("Item\(cardId)").removeValue()

            //option 2
            //특정 value로 key값을 유추할 때
            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardId).observe(.value) {[weak self] snapshot
                in
                guard let self = self,
                      let value = snapshot.value as? [String : [String : Any]],
                      // id를 기준으로 검색하고 해당 객체의 key값 또한 id와 동일
                      let key = value.keys.first else { return }
                self.ref.child(key).removeValue()
            }
        }
    }
}
