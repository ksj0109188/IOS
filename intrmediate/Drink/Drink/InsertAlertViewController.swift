//
//  InsertAlertViewController.swift
//  Drink
//
//  Created by 김성준 on 2022/03/27.
//

import Foundation
import UIKit

class InsertAlertViewController : UIViewController{
    var pickedDate : ((_ date:Date) -> Void)?
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true)
    }
    @IBOutlet weak var datePicker: UIDatePicker!
}
