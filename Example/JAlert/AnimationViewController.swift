//
//  AnimationViewController.swift
//  JAlert_Example
//
//  Created by JacksonJang on 2022/01/28.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import JAlert

class AnimationViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data:[String] = [
        "Animation : default",
        "Animation : scale"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AnimationViewController: UITableViewDelegate, UITableViewDataSource {
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
            //Actually, you don't need to set '.default', but this example is showing for you
            alert.appearType = .default
            alert.disappearType = .default
            
            alert.setButton(actionName: "OK", onActionClicked: {
                print("onActionClicked")
            })
            alert.show()
        case 1:
            let alert = JAlert(title: "title", message: "message", alertType: .default)
            alert.appearType = .scale
            alert.disappearType = .scale
            alert.setButton(actionName: "OK", onActionClicked: {
                print("onActionClicked")
            })
            alert.show()
        default:
            print("the rest of index")
        }
    }
}

