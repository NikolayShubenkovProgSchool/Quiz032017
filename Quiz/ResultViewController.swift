//
//  ResultViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 04/03/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!

    var score = 0 {//0 do 100
        didSet {
            if score < 0 {
                score = 0
            }
            if score > 100 {
                score = 100
            }
        }
    }
    
    deinit {
        print("buy buy. с наступающим")
    }
    
    //этот момент отлично подходит для подготовки к работе
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.progress = Float(score) / 100
        
        var text = ""
        
        switch score
        {
        case 0: text = "Вы бот, возможно"
        
        case 1...30:  text = "Повезет в другой раз"
            
        case 31...50: text = "Неплохо, но и не хорошо"
            
        case 51...99: text = "Отлично"
            
        default:      text = "Теперь точно бот"
        }
        
        resultLabel.text = "\(score)\n\(text)."
    }
}
