//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 김성준 on 2022/08/15.
//

import Foundation
import UIKit

protocol AlertActionConvertible {
    var title: String {get}
    var style: UIAlertAction.Style{get}
}
