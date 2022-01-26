//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by 김성준 on 2022/01/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    let quotes = [
    Quote(contents: "죽음을 두려워하는 나머지 삶을 시작조차 못하는 사람이 많다.", name: "밴다이크"),
    Quote(contents: "죽고자 하면 살것이고 살고자 하면 죽을것이다.", name: "이순신"),
    Quote(contents: "나는 나 자신을 빼 놓고는 모두 안다.",name: "비용")

    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tabQuoteGeneratorButton(_ sender: Any) {
        let random = Int(arc4random_uniform(3)) //난수 발생 코드 arcrandom_uniform함수 0~(매개변수-1)까지 난수 발생
        let quote = quotes[random]
        self.quoteLabel.text = quote.contents
        self.nameLabel.text = quote.name
    }
    
}

