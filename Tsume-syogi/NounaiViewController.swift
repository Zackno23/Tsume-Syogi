//
//  NounaiViewController.swift
//  Tsume-syogi
//
//  Created by 吉田力 on 2019/06/21.
//  Copyright © 2019 吉田力. All rights reserved.
//

import UIKit
var NonaiLevel = 0


class NounaiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func syoshinsya(_ sender: Any) {
        NonaiLevel = 1
        
    }
    @IBAction func cyukyusya(_ sender: Any) {
        NonaiLevel = 2
        
    }
    
    @IBAction func gachizei(_ sender: Any) {
        NonaiLevel = 3
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
