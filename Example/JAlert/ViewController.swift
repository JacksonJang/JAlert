//
//  ViewController.swift
//  JAlert
//
//  Created by 장효원 on 01/02/2022.
//  Copyright (c) 2022 장효원. All rights reserved.
//

import UIKit
import JAlert

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data:[String] = [
        "Type : default, animation : default",
        "Type : default, animation : scale",
        "Type : confirm, animation : default",
        "Type : confirm, animation : scale",
        "Type : multi, animation : default",
        "Type : multi, animation : scale"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        registerDelegate()
    }

    func registerDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
            let alert = JAlert(title: "Title", message: "Content", alertType: .default)
            alert.delegate = self
            
            alert.onActionButtonClicked = {
                print("onActionButtonClicked")
            }
            alert.show()
        case 1:
            let alert = JAlert(title: "Title", message: "Content", alertType: .default)
            alert.delegate = self
            
            alert.appearType = .scale
            alert.disappearType = .scale
            
            alert.onActionButtonClicked = {
                print("onActionButtonClicked")
            }
            
            alert.onCancelClicked = {
                print("onCancelClicked")
            }
            
            alert.show()
        case 2:
            let alert = JAlert(title: "Title", message: "Content", alertType: .confirm)
            alert.delegate = self
            
            alert.onActionButtonClicked = {
                print("onActionButtonClicked")
            }
            
            alert.onCancelClicked = {
                print("onCancelClicked")
            }
            
            alert.show()
        case 3:
            let alert = JAlert(title: "Title", message: "Content", alertType: .confirm)
            alert.delegate = self
            
            alert.appearType = .scale
            alert.disappearType = .scale
            
            alert.onActionButtonClicked = {
                print("onActionButtonClicked")
            }
            
            alert.onCancelClicked = {
                print("onCancelClicked")
            }
            
            alert.show()
        case 4:
            let alert = JAlert(title: "Title", message: "Content", alertType: .multi)
            alert.delegate = self
            alert.setMultiButton(titles: ["OK", "Cancel", "TEST"])
            
            alert.show()
        case 5:
            let alert = JAlert(title: "Title", message: "Content", alertType: .multi)
            alert.delegate = self
            
            alert.setMultiButton(titles: ["OK", "Cancel", "TEST"])
            alert.appearType = .scale
            alert.disappearType = .scale
            
            alert.show()
        default:
            print("the rest of index")
        }
    }
}

extension ViewController:JAlertDelegate {
    func alertView(_ alertView: JAlert, clickedButtonAtIndex buttonIndex: Int) {
        print("buttonIndex : ", buttonIndex)
    }
}

class ExampleListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
}
