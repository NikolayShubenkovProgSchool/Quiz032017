//
//  Question.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 04/03/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//


//да, я нарушил с разу же свое правило.
//но его тут уместно нарушить т.к. мы просто создаем картинку из ее названия
import UIKit

struct Question {
    let title:String
    let answers:[String]
    
    private let imageName:String
    private let correctAnswer:String
    
    var image:UIImage? {
        //это инициализатор,
        //который создает картинку с названием
        //которое указано в Assets.xcassets
        return UIImage(named:imageName)
    }
    
    /*
     {
         "question":"Кто это?",
         "answers":["Скарлетт Йоханссон", "Анджелина Джоли","Дженнифер Энистон","Натали Портман"],
         "correctAnswer":"Скарлетт Йоханссон",
         "image":"firstsQuestion"
     }
     */
    
    init?(json:[String:Any]){
        //
        guard let title = json["question"] as? String,
              let imageName = json["image"] as? String,
              let correctAnswer = json["correctAnswer"] as? String,
              let answers = json["answers"] as? [String], //мы ожидаем увидеть массив строк по ключу answers
              answers.contains(correctAnswer)//убедимся, что среди предложенных вариантов ответов есть правильный
            else {
                return nil
        }
        self.title = title
        self.imageName = imageName
        self.correctAnswer = correctAnswer
        self.answers = answers
    }
    
    //метод для проверки является ли какой-то ответ верным
    func answerIsCorrect(answer:String?)->Bool {
        return correctAnswer == answer
    }
}

