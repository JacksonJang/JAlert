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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO: 2줄 처리 필요
        let view = JAlert(title: "알림", message: "내용", alertType: .default)
        view.show()
        
        view.onButtonClicked = { buttonIndex in
            print("\(buttonIndex)")
        }

        view.onCancelClicked = {
            print("Cancel Button Clicked")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

