//
//  TypeViewController.swift
//  JAlert_Example
//
//  Created by JacksonJang on 2022/01/28.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import JAlert

class TypeViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data:[String] = [
        "Type : default",
        "Type : confirm",
        "Type : submit",
        "Type : date",
        "Type : image",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TypeViewController: UITableViewDelegate, UITableViewDataSource {
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
            do{
                let data = try Data(contentsOf: URL(string: "https://cdn.pixabay.com/photo/2022/01/02/04/37/animal-6909429_1280.jpg")!)
                alert.image = UIImage(data: data)!
            }catch{
                print("image type error")
            }
            alert.setButton(actionName: "OK", onActionClicked: {
                print("onActionClicked")
            })
            alert.show()
        default:
            print("the rest of index")
        }
    }
}
