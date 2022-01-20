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
        "Type : confirm, animation : default",
        "Type : submit, animation : default",
        "Type : date",
        "Type : image",
        "Animation : scale",
        "Use JAlertDelegate"
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
            let alert = JAlert(title: "title", message: "message", alertType: .default)
            alert.setButton(actionName: "OK")
            alert.show()
        case 1:
            let alert = JAlert(title: "title", message: "message", alertType: .confirm)
            alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
                print("onActionClicked")
            }, onCancelClicked: {
                print("onCancelClicked")
            })
            alert.show()
        case 2:
            let alert = JAlert(title: "title", message: "message", alertType: .submit)
            alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
                print("text : \(alert.getSubmitText())")
                print("onActionClicked")
            }, onCancelClicked: {
                print("onCancelClicked")
            })
            alert.show()
        case 3:
            let alert = JAlert(title: "title", message: "message", alertType: .date)
            alert.setButton(actionName: "OK", cancelName: "Cancel", onActionClicked: {
                print("date : \(alert.getDate())")
                print("onActionClicked")
            })
            alert.show()
        case 4:
            let alert = JAlert(title: "title", alertType: .image)
            alert.urlString = "https://cdn.pixabay.com/photo/2022/01/02/04/37/animal-6909429_1280.jpg"
            alert.setButton(actionName: "OK", onActionClicked: {
                print("onActionClicked")
            })
            alert.show()
        case 5:
            let alert = JAlert(title: "title", message: "message", alertType: .default)
            alert.appearType = .scale
            alert.disappearType = .scale
            alert.setButton(actionName: "OK", onActionClicked: {
                print("onActionClicked")
            })
            alert.show()
        case 6:
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

extension ViewController:JAlertDelegate {
    func alertView(_ alertView: JAlert, clickedButtonAtIndex buttonIndex: Int) {
        print("buttonIndex : ", buttonIndex)
    }
}

class ExampleListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
}
