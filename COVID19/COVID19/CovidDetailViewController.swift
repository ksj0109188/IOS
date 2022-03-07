//
//  CovidDetailViewController.swift
//  COVID19
//
//  Created by 김성준 on 2022/03/07.
//

import UIKit

class CovidDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

 
    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var recorveredCell: UITableViewCell!
    @IBOutlet weak var deathCell: UITableViewCell!
    @IBOutlet weak var percentageCell: UITableViewCell!
    @IBOutlet weak var overseasInflowCell: UITableViewCell!
    @IBOutlet weak var regionalOutbreakCell: UITableViewCell!
    
}
