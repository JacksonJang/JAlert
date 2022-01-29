//
//  PropertyViewController.swift
//  JAlert_Example
//
//  Created by JacksonJang on 2022/01/28.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import JAlert

class PropertyViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data: [String] = [
        "alertBackgroundColor : red",
        "cornerRadius : 50",
        "textAlignment : .left",
        "animationWithDuration : 2.0"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createJAlert(index: Int) -> JAlert {
        let alert = JAlert(title: "Property Example", message: self.data[index], alertType: .default)
        
        return alert
    }
}

extension PropertyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleListCell", for: indexPath) as! ExampleListCell
        let index = indexPath.row
        
        cell.titleLabel.text = data[index]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
     
        switch index {
        case 0:
            let alert = createJAlert(index: index)
            alert.alertBackgroundColor = .red
            alert.show()
        case 1:
            let alert = createJAlert(index: index)
            alert.cornerRadius = 50
            alert.show()
        case 2:
            let alert = createJAlert(index: index)
            alert.textAlignment = .left
            alert.show()
        case 3:
            let alert = createJAlert(index: index)
            alert.animationWithDuration = 2.0
            alert.show()
        default:
            print("the rest of index")
        }
    }
}
