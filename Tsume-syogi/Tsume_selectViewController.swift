//
//  Tsume_selectViewController.swift
//  Tsume-syogi
//
//  Created by 吉田力 on 2019/06/21.
//  Copyright © 2019 吉田力. All rights reserved.
//

import UIKit
var tsume_level = 0

class Tsume_selectViewController: UIViewController {
    @IBOutlet weak var tsume_start: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var seven: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tsume_start.isHidden = true
        tsume_level = 0
        three.backgroundColor = .yellow
        five.backgroundColor = .yellow
        seven.backgroundColor = .yellow

        // Do any additional setup after loading the view.
    }
    @IBAction func selectLevel(_ sender: UIButton) {
        switch sender.titleLabel?.text!{
        case "三手詰め":
            tsume_level = 3
            three.backgroundColor = .red
            five.backgroundColor = .yellow
            seven.backgroundColor = .yellow
            
        case "五手詰め" :
            tsume_level = 5
            three.backgroundColor = .yellow
            five.backgroundColor = .red
            seven.backgroundColor = .yellow
        case "七手詰め":
            tsume_level = 7
            three.backgroundColor = .yellow
            five.backgroundColor = .yellow
            seven.backgroundColor = .red
        default:
            break
        }
        tsume_start.isHidden = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tsume_start.isHidden = true
        tsume_level = 0
        three.backgroundColor = .yellow
        five.backgroundColor = .yellow
        seven.backgroundColor = .yellow

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
