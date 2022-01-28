//
//  DelegateViewController.swift
//  JAlert_Example
//
//  Created by JacksonJang on 2022/01/28.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import JAlert

class DelegateViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data: [String] = [
        "Use JAlertDelegate"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DelegateViewController: UITableViewDelegate, UITableViewDataSource {
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
            let alert = JAlert(title: "title", message: "message", alertType: .default)
            alert.delegate = self
            alert.setButton(actionName: "OK", onActionClicked: {
                print("onActionClicked")
            })
            alert.show()
        default:
            print("the rest of index")
        }
    }
}

extension DelegateViewController:JAlertDelegate {
    func alertView(_ alertView: JAlert, clickedButtonAtIndex buttonIndex: Int) {
        print("buttonIndex : ", buttonIndex)
    }
}
