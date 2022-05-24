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
        "Basic Example",
        "Properties Example"
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
    
    func pushViewController(_ vc:UIViewController) {
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
            pushViewController(name: "BasicViewController")
        case 1:
            if #available(iOS 11.0, *) {
                pushViewController(PropertiesViewController())
            }
        default:
            print("the rest of index")
        }
    }
}

class ExampleListCell: UITableViewCell {
    static let identifier = String(describing: ExampleListCell.self)
    
    @IBOutlet var titleLabel: UILabel!
    
    func createTitleLabel(text:String) {
        self.selectionStyle = .none
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel.text = text
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            ])
        }
    }
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//    }
}
