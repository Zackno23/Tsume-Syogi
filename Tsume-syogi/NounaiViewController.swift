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

    @IBOutlet weak var syoshinsya: UIButton!
    @IBOutlet weak var fu: UIButton!
    @IBOutlet weak var cyukyusya: UIButton!
    @IBOutlet weak var gin: UIButton!
    @IBOutlet weak var gachizai: UIButton!
    @IBOutlet weak var hisya: UIButton!
    @IBOutlet weak var cyosen: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cyosen.isHidden = true
        syoshinsya.backgroundColor = .yellow
        fu.backgroundColor = .yellow
        cyukyusya.backgroundColor = .yellow
        gin.backgroundColor = .yellow
        gachizai.backgroundColor = .yellow
        hisya.backgroundColor = .yellow

        // Do any additional setup after loading the view.
    }
    
    @IBAction func syoshinsya(_ sender: Any) {
        NonaiLevel = 1
        syoshinsya.backgroundColor = .red
        fu.backgroundColor = .red
        cyukyusya.backgroundColor = .yellow
        gin.backgroundColor = .yellow
        gachizai.backgroundColor = .yellow
        hisya.backgroundColor = .yellow
        cyosen.isHidden = false
        
    }
    @IBAction func cyukyusya(_ sender: Any) {
        NonaiLevel = 2
        syoshinsya.backgroundColor = .yellow
        fu.backgroundColor = .yellow
        cyukyusya.backgroundColor = .red
        gin.backgroundColor = .red
        gachizai.backgroundColor = .yellow
        hisya.backgroundColor = .yellow
        cyosen.isHidden = false
        
    }
    
    @IBAction func gachizei(_ sender: Any) {
        NonaiLevel = 3
        syoshinsya.backgroundColor = .yellow
        fu.backgroundColor = .yellow
        cyukyusya.backgroundColor = .yellow
        gin.backgroundColor = .yellow
        gachizai.backgroundColor = .red
        hisya.backgroundColor = .red
        cyosen.isHidden = false
        cyosen.isEnabled = true
        print("gachizei")
    }
    
    @IBAction func tappedCyosen(_ sender: UIButton) {
        print("cyosen")
        
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
