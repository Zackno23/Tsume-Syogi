//
//  NounaiTaikyokuViewController.swift
//  Tsume-syogi
//
//  Created by 吉田力 on 2019/06/22.
//  Copyright © 2019 吉田力. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NounaiTaikyokuViewController: UIViewController {
    @IBOutlet weak var Funyanza: UILabel!
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func gikou() -> String{
        Alamofire.request("https://17xn1ovxga.execute-api.ap-northeast-1.amazonaws.com/production/gikou?byoyomi=10000&position=sfen%20lr5nl/2g1kg1s1/p1npppbpp/2ps5/8P/2P3R2/PP1PPPP1N/1SGB1S3/LN1KG3L%20w%202Pp%201").responseJSON { (response: DataResponse<Any>) in
            if response.result.isFailure == true{
                print(response.result.error?.localizedDescription)
                return
            }
            guard let val = response.result.value as? [String: Any] else{
                self.simpleAlert(title: "通信エラー", message: "通信結果が」JSONではありませんでした")
                return
            }
            let json = JSON(val)
            let BESTmove = json["bestmove"].string
            let BESTMOVE = BESTmove!
            return BESTMOVE
        }
    }
}
