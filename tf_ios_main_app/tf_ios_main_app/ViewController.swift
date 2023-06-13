//
//  ViewController.swift
//  tf_ios_main_app
//
//  Created by AL-TVO163 on 13/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblCenter : UILabel!
    @IBOutlet weak var lblApiKey : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let apiUrl = TFAppCofig.getConfigValue(key: .apiUrl)
        
        lblCenter.text = apiUrl
        
        lblApiKey.text = TFAppCofig.getConfigValue(key: .apiKey)
    }


}

