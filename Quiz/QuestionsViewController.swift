//
//  QuestionsViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 04/03/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var questionText: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var questionList:[Question]? //тут будут храниться все вопросы
    {   //когда сюда будут записаны новые вопросы 
        //возьмем первый из них и запишем в currentQeustion
        didSet {
            currentQuestion = questionList?.first
        }
    }
    
    var currentQuestion:Question?//текущий вопрос
    {
        //как только значение currentQuestion изменилось
        //перезагрузим содержимое таблицы с правильными ответами
        didSet {
            updateViews()
        }
    }
    
    //Этот метод вызывается в момент, когда все view
    //созданы и загружены в память
    //обычно тут происходит основная подготовка к работе
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Setup
    
    private func updateViews(){
        self.tableView.reloadData()
        questionText.text = currentQuestion?.title
        imageView.image = currentQuestion?.image
    }
    
    private func setup(){
        
        tableView.dataSource = self
        loadData()
    }
    
    private func loadData(){
        //создали объект, который загрузит данные
        let loader = DataLoader()
        //запросили загрузить модель
        let result = loader.loadData(fileName: "cinema")
        //вывели результат в консоль
        print(result)
        
        
        self.title = result.quizeName
        self.questionList = result.questions
    }
}

extension QuestionsViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // если вдруг у нас нет текущего вопроса
        //то мы передадим значение по-умолчанию
        return self.currentQuestion?.answers.count ?? 0
    }
    
    //настроим ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //запросим у tableView ячейку с определенным идентификатором.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        
        //в ячейках табилцы будут отображаться ответы на вопрос
        //одна ячейка - один ответ
        //0-я ячейка - 0-й ответ
        //1-я ячейка - 1-й ответ и т.д.
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row]
        
        return cell
    }
}