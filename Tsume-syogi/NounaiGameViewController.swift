//
//  NounaiGameViewController.swift
//  Tsume-syogi
//
//  Created by 吉田力 on 2019/06/21.
//  Copyright © 2019 吉田力. All rights reserved.
//

import UIKit

class NounaiGameViewController: UIViewController {
var furigoma_touched = false
@IBOutlet weak var furigoma: UIButton!
    @IBOutlet weak var sengoText: UILabel!
    var addTimer = Timer()
    var timerCount = 0
    let image1: UIImage = UIImage(named: "ふ_3")!
    let image2: UIImage = UIImage(named: "と")!
    let randomNumber = Int.random(in: 20 ... 30)
    
    @objc func timerCall(){
        sengoText.isHidden = true
        furigoma.isEnabled = false
        timerCount += 1
        if timerCount % 2 == 0{
            furigoma.setImage(image1, for: .normal)
            
        }else{
            furigoma.setImage(image2, for: .normal)
        }
        if timerCount == randomNumber{
            addTimer.invalidate()
            furigoma.isEnabled = true
            sengoText.isHidden = false
            if timerCount % 2 == 0{
                sengoText.text = "あなたが先手です"
            }else{
                sengoText.text = "あなたは後手です。"
            }
        }
    }
    
    

    override func viewDidLoad() {
        
        addTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
        
    }
        
        // Do any additional setup after loading the view.
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


