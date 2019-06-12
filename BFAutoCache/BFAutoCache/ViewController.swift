//
//  ViewController.swift
//  BFAutoCache
//
//  Created by Dennis on 2019/6/12.
//  Copyright © 2019 Dennis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var intInput: UITextField!
    @IBOutlet weak var stringInput: UITextField!
    @IBOutlet weak var doubleInput: UITextField!
    
    @IBOutlet weak var intLabel: UILabel!
    @IBOutlet weak var stringLabel: UILabel!
    @IBOutlet weak var doubleLabel: UILabel!
    
    var i = AutoCache<Int>(name: "ValueInt")
    var s = AutoCache<String>(name: "ValueString")
    
    var d = 1.0~~"ValueDouble"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        refreshUI()
    }
    
    
    func refreshUI() {
        intLabel.text = String(%%i)
        stringLabel.text = %%s
        doubleLabel.text = String(%%d)
    }

    
    @IBAction func changeInt(_ sender: Any) {
        let v = Int(intInput.text ?? "") ?? 0
        i <~ v
        
        refreshUI()
    }
    
    
    @IBAction func changeString(_ sender: Any) {
        s <~ stringInput.text
        refreshUI()
    }
    
    @IBAction func changeDouble(_ sender: Any) {
        let v = Double(doubleInput.text ?? "") ?? 0.0
        d <~ v
        
        refreshUI()
    }
}

