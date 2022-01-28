//
//  MainViewController.swift
//  JAlert
//
//  Created by JacksonJang on 01/02/2022.
//  Copyright (c) 2022 JacksonJang. All rights reserved.
//

import UIKit
import JAlert

class MainViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var data:[String] = [
        "Type Example",
        "Property Example",
        "Animation Example",
        "Using Delegate"
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
    
    func pushViewController(name:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
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
            pushViewController(name: "TypeViewController")
        case 1:
            pushViewController(name: "PropertyViewController")
        case 2:
            pushViewController(name: "AnimationViewController")
        case 3:
            pushViewController(name: "DelegateViewController")
        default:
            print("the rest of index")
        }
    }
}

class ExampleListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
}
