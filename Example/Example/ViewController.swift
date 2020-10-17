//
//  ViewController.swift
//  Example
//
//  Created by hoangnc on 18/10/20.
//

import UIKit
import DropDown

class ViewController: UIViewController {
    @IBOutlet weak var dropDown: DropDown!
    
    var items: [String] = ["Chicken Rice", "Noddle", "Duck Roasted", "Seafood", "Hamburger"]

    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.placeHolder = "Food"
        dropDown.iconUp = UIImage(named: "up")
        dropDown.iconDown = UIImage(named: "down")
        dropDown.dataSource = self
        dropDown.isExpand = false
    }
}
extension ViewController: DropDownDataSource {
    
    func numberOfSelections(dropDown: DropDown) -> [String] {
        return items
    }
}
