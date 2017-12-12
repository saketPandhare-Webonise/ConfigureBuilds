//
//  ViewController.swift
//  GSDemo
//
//  Created by Saket.Webonise Pandhare on 12/12/17.
//  Copyright © 2017 Saket.Webonise Pandhare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelPointingUrl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBaseUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func getBaseUrl() {
        let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASEURL")
        labelPointingUrl.text = baseURL as! String?
    }
}

