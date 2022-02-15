//
//  TypePropertyViewController.swift
//  JAlert_Example
//
//  Created by JacksonJang on 2022/01/31.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import JAlert

class TypePropertyViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data:[String] = [
        "date type) dateFormat : yyyyMMdd",
        "date type) language : selected your country",
        "image type) set UIImage",
        "submitViewHeight : 300",
        "datePickerViewHeight : 500"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TypePropertyViewController: UITableViewDelegate, UITableViewDataSource {
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
            let alert = JAlert(title: "title", message: "message", alertType: .date, onButtonClicked: { index in
                print("index : \(index)")
            })
            //default : yyyy-MM-dd HH:mm:s
            alert.dateFormat = "yyyyMMdd"
            alert.setButton(actionName: "OK", cancelName: "Cancel")
            alert.show()
        case 1:
            let alert = JAlert(title: "title", message: "message", alertType: .date, onButtonClicked: { index in
                print("index : \(index)")
            })
            alert.language = .ko_KR
            alert.setButton(actionName: "OK", cancelName: "Cancel")
            alert.show()
        case 2:
            let alert = JAlert(title: "Property Example", message: self.data[index], alertType: .image, onButtonClicked: { index in
                print("index : \(index)")
            })
            
            do{
                let data = try Data(contentsOf: URL(string: "https://cdn.pixabay.com/photo/2022/01/02/04/37/animal-6909429_1280.jpg")!)
                alert.image = UIImage(data: data)!
            }catch{
                print("image type error")
            }
            
            alert.show()
        case 3:
            let alert = JAlert(title: "Property Example", message: self.data[index], alertType: .submit, onButtonClicked: { index in
                print("index : \(index)")
            })
            alert.submitViewHeight = 300
            alert.show()
        case 4:
            let alert = JAlert(title: "Property Example", message: self.data[index], alertType: .date, onButtonClicked: { index in
                print("index : \(index)")
            })
            alert.datePickerViewHeight = 500
            alert.show()
        default:
            print("the rest of index")
        }
    }
}

