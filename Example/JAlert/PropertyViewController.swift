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
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        default:
            print("the rest of index")
        }
    }
}
