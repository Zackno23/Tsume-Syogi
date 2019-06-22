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

class NounaiTaikyokuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selected == 1{
            return suji_list.count
        }else if selected == 2{
            return dan_list.count
        }else if selected == 3{
            return koma_list.count
        }else{
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selected == 1{
            return suji_list[row]
        }else if selected == 2{
            return dan_list[row]
        }else if selected == 3{
            return koma_list[row]
        }else{
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selected == 1{
            sujiButton.titleLabel?.text! = suji_list[row]
            picker.isHidden = true
        }else if selected == 2{
            picker.isHidden = true
            danButton.titleLabel?.text! = dan_list[row]
        }else if selected == 3{
            picker.isHidden = true
            komaButton.titleLabel?.text! = koma_list[row]

        }
    }
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var sujiButton: UIButton!
    @IBOutlet weak var danButton: UIButton!
    @IBOutlet weak var komaButton: UIButton!
    
    @IBAction func SujiButton(_ sender: UIButton) {
        picker.isHidden = false
        selected = 1
        picker.reloadAllComponents()
    }
    
    @IBAction func DanButton(_ sender: UIButton) {
        picker.isHidden = false
        selected = 2
        picker.reloadAllComponents()

    }
    
    @IBAction func KomaButton(_ sender: UIButton) {
        picker.isHidden = false
        selected = 3
        picker.reloadAllComponents()
    
    }
    let suji_list = ["1","2","3","4","5","6","7","8","9"]
    let dan_list = ["1","2","3","4","5","6","7","8","9"]
    let koma_list = ["歩","香","桂","銀","金","玉","と","杏","圭","全","龍","馬"]
    var selected = 0
    
    
    
    
    var dan1: Array  = [["1","香"],["1","桂"],["1","銀"],["1","金"],["1","王"],["1","金"],["1","銀"],["1","桂"],["1","香"]]
    var dan2: Array  = [["2","　"],["1","飛"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["1","角"],["2","　"]]
    var dan3: Array  = [["1","歩"],["1","歩"],["1","歩"],["1","歩"],["1","歩"],["1","歩"],["1","歩"],["1","歩"],["1","歩"]]
    var dan4: Array  = [["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"]]
    var dan5: Array  = [["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"]]
    var dan6: Array  = [["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"]]
    var dan7: Array  = [["0","歩"],["0","歩"],["0","歩"],["0","歩"],["0","歩"],["0","歩"],["0","歩"],["0","歩"],["0","歩"]]
    var dan8: Array  = [["2","　"],["0","角"],["2","　"],["2","　"],["2","　"],["2","　"],["2","　"],["0","飛"],["2","　"]]
    var dan9: Array  = [["0","香"],["0","桂"],["0","銀"],["0","金"],["0","王"],["0","金"],["0","銀"],["0","桂"],["0","香"]]
    
    var 将棋盤:[[[String]]] = []
    var 先手駒リスト : [[Int]] = [[9,7], [8,7], [7,7], [6,7], [5,7], [4,7], [3,7], [2,7], [1,7], [8,8], [2,8], [9,9], [9,8], [9,7], [9,6], [9,5], [9,4], [9,3], [9,2], [9,1]]
    var 後手駒リスト : [[Int]] = [[9,1], [8,1], [7,1], [6,1], [5,1], [4,1], [3,1], [2,1], [1,1], [8,2], [2,2], [9,3], [8,3], [7,3], [6,3], [5,3], [4,3], [3,3], [2,3], [1,3]]
    
    
    var 先後 = false //先手はtrue 後手はfalse
    
    var 先手持ち駒: Array <String> = []
    var 後手持ち駒: Array <String> = []
    var 対局 = false

    @IBOutlet weak var Funyanza: UILabel!
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        将棋盤 = [dan1,dan2,dan3,dan4,dan5,dan6,dan7,dan8,dan9]

        picker.delegate = self
        picker.dataSource = self
        //danButton.isEnabled = false
        //komaButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    //実際の符号からそこにどの駒があるのか、またその駒は先手後手どちらのものなのかを判定する
    func 譜号変換(筋:Int, 段:Int) -> [String]{
        return 将棋盤[Int(段) - 1][9-Int(筋)]
    }
    
    
    
    //コンソールに出力とともに、先手、後手それぞれの駒の配置をリスト化
//    func 盤面表示(){
//        print("後手: ", terminator: "")
//        if 後手持ち駒.count == 0{
//            print("なし")
//        }else{
//            print(後手持ち駒)
//        }
//        var 駒表示 = ""
//        for a in 将棋盤{
//            for b in a{
//                駒表示 += b[1]
//
//            }
//            print(駒表示)
//            駒表示 = ""
//        }
//        print("先手: ",terminator: "")
//        if 先手持ち駒.count == 0{
//            print("なし")
//        }else{
//            print(先手持ち駒)
//        }
//        print("")
//    }

    //駒の動ける範囲を返す
    //無効な動きに関しては、この関数では処理しない
    //駒は全て有効な位置にいる前提での処理(1段目の歩・教などは、入力するときに弾く)
    //桂馬を除く飛び道具は、まず自分の駒リストフィルターをかけ、次に相手の駒フィルターをかける
//    func 駒の動き(駒:String, 筋: Int, 段: Int, 先後: Bool, 先手駒リスト: [[Int]], 後手駒リスト:[[Int]]) -> [[Int]]{
//        var 動ける範囲: [[Int]] = []
//        var すじ = 筋
//        var だん = 段
//        switch 駒{
//        //どこにいても動けるわけではない駒
//        case "歩":
//            if 先後{
//                動ける範囲.append([筋,段 - 1])
//            }else{
//                動ける範囲.append([筋,段 + 1])
//            }
//        case "香":
//            if 先後{
//                while だん > 1{
//                    if 先手駒リスト.contains([筋,だん - 1]){
//                        break
//                    }
//                    if 後手駒リスト.contains([筋,だん - 1]){
//                        動ける範囲.append([筋,だん - 1])
//                        break
//                    }
//                    動ける範囲.append([筋,だん - 1])
//                    だん -= 1
//                }
//            }else{
//                while だん < 9{
//                    if 先手駒リスト.contains([筋,だん + 1]){
//                        break
//                    }
//                    if 後手駒リスト.contains([筋,だん + 1]){
//                        動ける範囲.append([筋,だん + 1])
//                        break
//                    }
//                    動ける範囲.append([筋, だん + 1])
//                    だん += 1
//                }
//            }
//            だん = 段
//        case "桂":
//            if 先後{
//                switch 筋{
//                case 1:
//                    動ける範囲.append([筋 - 1, 段 - 2])
//                case 9:
//                    動ける範囲.append([筋 + 1, 段 - 2])
//                default:
//                    動ける範囲.append([筋 - 1, 段 - 2])
//                    動ける範囲.append([筋 + 1, 段 - 2])
//                }
//            }else{
//                switch 筋{
//                case 1:
//                    動ける範囲.append([筋 + 1, 段 + 2])
//                case 9:
//                    動ける範囲.append([筋 - 1, 段 + 2])
//                default:
//                    動ける範囲.append([筋 + 1, 段 + 2])
//                    動ける範囲.append([筋 - 1, 段 + 2])
//                }
//            }
//        //ここからはどこにいても動ける駒
//        case "銀":
//            var 銀の動ける範囲: [[Int]] = []
//            if 先後{
//                銀の動ける範囲 = [[筋+1,段-1],[筋,段-1],[筋-1,段-1],[筋+1,段+1],[筋-1,段+1]]
//            }else{
//                銀の動ける範囲 = [[筋+1,段+1],[筋,段+1],[筋-1,段+1],[筋-1,段+1],[筋-1,段-1]]
//            }
//            for i in 0 ... 銀の動ける範囲.count - 1{
//                if 銀の動ける範囲[i].contains(10) || 銀の動ける範囲[i].contains(0){
//                    銀の動ける範囲.remove(at: i)
//                    動ける範囲 = 銀の動ける範囲
//                }
//            }
//
//        case "金","と","杏","圭","全":
//            var 金の動ける範囲: [[Int]] = []
//            if 先後{
//                金の動ける範囲 = [[筋+1,段-1],[筋,段-1],[筋-1,段-1],[筋+1,段],[筋-1,段],[筋,段+1]]
//            }else{
//                金の動ける範囲 = [[筋+1,段+1],[筋,段+1],[筋-1,段+1],[筋+1,段],[筋-1,段],[筋,段-1]]
//            }
//            for i in 0 ... 金の動ける範囲.count - 1{
//                if 金の動ける範囲[i].contains(10) || 金の動ける範囲[i].contains(0){
//                    金の動ける範囲.remove(at: i)
//                    動ける範囲 = 金の動ける範囲
//                }
//            }
//
//        case "玉":
//            var 玉の動ける範囲:[[Int]] = [[筋+1,段+1],[筋+1,段],[筋+1,段-1],[筋,段+1],[筋,段-1],[筋-1,段-1],[筋-1,段],[筋-1,段+1]]
//            for i in 0...玉の動ける範囲.count{
//                if 玉の動ける範囲[i].contains(0)||玉の動ける範囲[i].contains(10){
//                    玉の動ける範囲.remove(at: i)
//                    動ける範囲 = 玉の動ける範囲
//                }
//            }
//
//        case "飛":
//            var 飛車の動ける範囲: [[Int]] = []
//            while すじ < 9{
//                if 先手駒リスト.contains([すじ + 1,段]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ + 1,段]){
//                    飛車の動ける範囲.append([すじ + 1,段])
//                    break
//                }
//                飛車の動ける範囲.append([すじ + 1,段])
//                すじ += 1
//            }
//            すじ = 筋
//            while すじ > 0{
//                if 先手駒リスト.contains([すじ - 1,段]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ - 1,段]){
//                    飛車の動ける範囲.append([すじ - 1,段])
//                    break
//                }
//                飛車の動ける範囲.append([すじ - 1,段])
//                すじ -= 1
//            }
//            すじ = 筋
//            while だん < 9{
//                if 先手駒リスト.contains([筋,だん + 1]){
//                    break
//                }
//                if 後手駒リスト.contains([筋,だん + 1]){
//                    飛車の動ける範囲.append([筋,だん + 1])
//                    break
//                }
//                飛車の動ける範囲.append([筋,だん + 1])
//                だん += 1
//            }
//            だん = 段
//            while だん < 0{
//                if 先手駒リスト.contains([筋,だん - 1]){
//                    break
//                }
//                if 後手駒リスト.contains([筋,だん - 1]){
//                    飛車の動ける範囲.append([筋,だん - 1])
//                    break
//                }
//                飛車の動ける範囲.append([筋,だん - 1])
//                すじ -= 1
//            }
//            だん = 段
//            動ける範囲 = 飛車の動ける範囲
//
//
//        case "角":
//            var 角の動ける範囲: [[Int]] = []
//            while すじ < 9 || だん < 9{
//                if 先手駒リスト.contains([すじ + 1, だん + 1]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ + 1, だん + 1]){
//                    角の動ける範囲.append([すじ + 1, だん + 1])
//                    break
//                }
//                角の動ける範囲.append([すじ + 1, だん + 1])
//            }
//            すじ = 筋
//            だん = 段
//            while すじ > 0 || だん > 9{
//                if 先手駒リスト.contains([すじ - 1, だん - 1]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ - 1, だん - 1]){
//                    角の動ける範囲.append([すじ - 1, だん - 1])
//                    break
//                }
//                角の動ける範囲.append([すじ - 1, だん - 1])
//            }
//            すじ = 筋
//            だん = 段
//            while すじ > 0 || だん < 9{
//                if 先手駒リスト.contains([すじ - 1, だん + 1]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ - 1, だん + 1]){
//                    角の動ける範囲.append([すじ - 1, だん + 1])
//                    break
//                }
//                角の動ける範囲.append([すじ - 1, だん + 1])
//            }
//            すじ = 筋
//            だん = 段
//            while すじ < 9 || だん > 0{
//                if 先手駒リスト.contains([すじ + 1, だん - 1]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ + 1, だん - 1]){
//                    角の動ける範囲.append([すじ + 1, だん - 1])
//                    break
//                }
//                角の動ける範囲.append([すじ + 1, だん - 1])
//            }
//            すじ = 筋
//            だん = 段
//            動ける範囲 = 角の動ける範囲
//
//
//        case "龍":
//            var 龍の動ける範囲: [[Int]] = []
//            while すじ < 9{
//                if 先手駒リスト.contains([すじ + 1,段]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ + 1,段]){
//                    龍の動ける範囲.append([すじ + 1,段])
//                    break
//                }
//                龍の動ける範囲.append([すじ + 1,段])
//                すじ += 1
//            }
//            すじ = 筋
//            while すじ > 0{
//                if 先手駒リスト.contains([すじ - 1,段]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ - 1,段]){
//                    龍の動ける範囲.append([すじ - 1,段])
//                    break
//                }
//                龍の動ける範囲.append([すじ - 1,段])
//                すじ -= 1
//            }
//            すじ = 筋
//            while だん < 9{
//                if 先手駒リスト.contains([筋,だん + 1]){
//                    break
//                }
//                if 後手駒リスト.contains([筋,だん + 1]){
//                    龍の動ける範囲.append([筋,だん + 1])
//                    break
//                }
//                龍の動ける範囲.append([筋,だん + 1])
//                だん += 1
//            }
//            だん = 段
//            while だん < 0{
//                if 先手駒リスト.contains([筋,だん - 1]){
//                    break
//                }
//                if 後手駒リスト.contains([筋,だん - 1]){
//                    龍の動ける範囲.append([筋,だん - 1])
//                    break
//                }
//                龍の動ける範囲.append([筋,だん - 1])
//                すじ -= 1
//            }
//            だん = 段
//            龍の動ける範囲.append([筋+1,段+1])
//            龍の動ける範囲.append([筋+1,段-1])
//            龍の動ける範囲.append([筋-1,段+1])
//            龍の動ける範囲.append([筋-1,段-1])
//            for i in 0 ... 龍の動ける範囲.count - 1{
//                if 龍の動ける範囲[i].contains(10) || 龍の動ける範囲[i].contains(0){
//                    龍の動ける範囲.remove(at: i)
//                    動ける範囲 = 龍の動ける範囲
//                }
//            }
//            動ける範囲 = 龍の動ける範囲
//        case "馬":
//            var 馬の動ける範囲: [[Int]] = []
//            while すじ < 9 || だん < 9{
//                if 先手駒リスト.contains([すじ + 1, だん + 1]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ + 1, だん + 1]){
//                    馬の動ける範囲.append([すじ + 1, だん + 1])
//                    break
//                }
//                馬の動ける範囲.append([すじ + 1, だん + 1])
//            }
//            すじ = 筋
//            だん = 段
//            while すじ > 0 || だん > 9{
//                if 先手駒リスト.contains([すじ - 1, だん - 1]){
//                    break
//                }
//                if 後手駒リスト.contains([すじ - 1, だん - 1]){
//                    馬の動ける範囲.append([すじ - 1, だん - 1])
//                    break
//                }
//                馬の動ける範囲.append([すじ - 1, だん - 1])
//            }
//            すじ = 筋
//            だん = 段
//            while すじ > 0 || だん < 9{if 先手駒リスト.contains([すじ - 1, だん + 1]){
//                break
//                }
//                if 後手駒リスト.contains([すじ - 1, だん + 1]){
//                    馬の動ける範囲.append([すじ - 1, だん + 1])
//                    break
//                }
//                馬の動ける範囲.append([すじ - 1, だん + 1])
//            }
//            すじ = 筋
//            だん = 段
//            while すじ < 9 || だん > 0{if 先手駒リスト.contains([すじ + 1, だん - 1]){
//                break
//                }
//                if 後手駒リスト.contains([すじ + 1, だん - 1]){
//                    馬の動ける範囲.append([すじ + 1, だん - 1])
//                    break
//                }
//                馬の動ける範囲.append([すじ + 1, だん - 1])
//            }
//            すじ = 筋
//            だん = 段
//            馬の動ける範囲.append([筋+1,段])
//            馬の動ける範囲.append([筋-1,段])
//            馬の動ける範囲.append([筋,段+1])
//            馬の動ける範囲.append([筋,段-1])
//            動ける範囲 = 馬の動ける範囲
//
//        default:
//            break
//        }
//        return 動ける範囲
//    }
//    func 移動できない場所(){
//
//    }
//    func ウッテハイケナイサシタラナル(駒:String, 先後:Bool) -> ([[Int]]){
//        var イケナイリスト: [[Int]] = []
//        switch 駒{
//        case "歩":
//            if 先後{
//                イケナイリスト = [[9,1],[8,1],[7,1],[6,1],[5,1],[4,1],[3,1],[2,1],[1,1]]
//            }else{
//                イケナイリスト = [[9,9],[8,9],[7,9],[6,9],[5,9],[4,9],[3,9],[2,9],[1,9]]
//            }
//
//        case "香":
//            if 先後{
//                イケナイリスト = [[9,1],[8,1],[7,1],[6,1],[5,1],[4,1],[3,1],[2,1],[1,1]]
//            }else{
//                イケナイリスト = [[9,9],[8,9],[7,9],[6,9],[5,9],[4,9],[3,9],[2,9],[1,9]]
//            }
//
//        case "桂":
//            if 先後{
//                イケナイリスト = [[9,1],[8,1],[7,1],[6,1],[5,1],[4,1],[3,1],[2,1],[1,1],[9,2],[8,2],[7,2],[6,2],[5,2],[4,2],[3,2],[2,2],[1,2]]
//
//            }else{
//                イケナイリスト = [[9,9],[8,9],[7,9],[6,9],[5,9],[4,9],[3,9],[2,9],[1,9],[9,8],[8,8],[7,8],[6,8],[5,8],[4,8],[3,8],[2,8],[1,8]]
//            }
//
//        default:
//            break
//
//
//        }
//        return イケナイリスト
//    }
//
//    func 成り駒(駒:String) -> String{
//        var result = ""
//        switch 駒{
//        case "歩":
//            result = "と"
//        case "香":
//            result = "杏"
//        case "桂":
//            result = "圭"
//        case "銀":
//            result = "全"
//        case "飛":
//            result = "龍"
//        case "角":
//            result = "馬"
//        case "と":
//            result = "歩"
//        case "杏":
//            result = "香"
//        case "圭":
//            result = "桂"
//        case "全":
//            result = "銀"
//        case "龍":
//            result = "飛"
//        case "馬":
//            result = "角"
//        default:
//            break
//        }
//        return result
//    }
//
//    func gikou() -> String{
//        var BESTMOVE = ""
//        Alamofire.request("https://17xn1ovxga.execute-api.ap-northeast-1.amazonaws.com/production/gikou?byoyomi=10000&position=sfen%20lr5nl/2g1kg1s1/p1npppbpp/2ps5/8P/2P3R2/PP1PPPP1N/1SGB1S3/LN1KG3L%20w%202Pp%201").responseJSON { (response: DataResponse<Any>) in
//            if response.result.isFailure == true{
//                print(response.result.error?.localizedDescription)
//                return
//            }
//            guard let val = response.result.value as? [String: Any] else{
//                self.simpleAlert(title: "通信エラー", message: "通信結果がJSONではありませんでした")
//                return
//            }
//            let json = JSON(val)
//            let BESTmove = json["bestmove"].stringValue
//            BESTMOVE = BESTmove
//
//        }
//        return BESTMOVE
//    }
}
