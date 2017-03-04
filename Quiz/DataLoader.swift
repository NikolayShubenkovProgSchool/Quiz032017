//
//  DataLoader.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 04/03/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//

import Foundation

class DataLoader{
    
    //1. открыть файл
    //2. преобразовать его в Dictionary[String:any]
    //3. достать оттуда вопросы и название викторины
    //4. покушать
    
    //создадим метод загрузки данных
    //в идеале тут можно было пробрасывать ошибки с описанием проблемы
    func loadData(fileName:String)->(quizeName:String,questions:[Question])
    {
        //1. открыть файл
        //найдем путь к искомому файлу
        let pathToFile = Bundle.main.path(forResource: fileName,
                                          ofType: "json")!
        
        //это путь к файлу внутри приложения
        print(pathToFile)
        
        
        //прочитаем сырой поток байт из найденного пути
        let data = try! Data(contentsOf: URL(fileURLWithPath: pathToFile))
        
        //теперь у нас получится, я надеюсь
        //объект типа Any, который почти готов к использованию
        let json = try! JSONSerialization.jsonObject(with: data,
                                                     options: [])
        
        
        //преборазовали тип Any в [String:Any]
        //будет создан объект, описывающий содержимое файла
        //у него будут ключи - строки и значения - все, что угодно.
        guard let questionsJSON = json as? [String:Any] else {
            fatalError("не корректный объект с вопросами:\(json)")
        }
        
        //попытаемся достать имя викторины по ключу name -> String
        guard let quizeName = questionsJSON["name"] as? String,
            //а также получить список вопросов, по ключу "question"
            //там должен лежать МАССИВ из словарей. 
            //у словарей тип [String:Any]
            let jsonsToConvert = questionsJSON["questions"] as? [ [String:Any] ] else {
                fatalError("не корректный формат викторины")
        }
        
        //осталось преобразовать описание вопросов в модель
        
        //сюда мы будем вставлять вопросы
        var questions = [Question]()
        
        //переберем все словари и преобразуем их в данные
        for json in jsonsToConvert {
            if let aQuestion = Question(json: json){
                questions.append(aQuestion)
            }
        }
        
        if questions.count == 0 {
            fatalError("не создано ни одного вопроса")
        }
        
        return (quizeName,questions)
    }
}
