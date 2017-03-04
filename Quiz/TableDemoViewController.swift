//
//  TableDemoViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 04/03/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class TableDemoViewController:            UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    //это массив строк. наша модель
    //мы разбили строку на массив, разделителем которого является пробел
    var strings = "Including this constant string in the array of strings returned by sectionIndexTitlesForTableView: will cause a magnifying glass icon to be displayed at that location in the index.Including this constant string in the array of strings returned by sectionIndexTitlesForTableView: will cause a magnifying glass icon to be displayed at that location in the index.Including this constant string in the array of strings returned by sectionIndexTitlesForTableView: will cause a magnifying glass icon to be displayed at that location in the index.Including this constant string in the array of strings returned by sectionIndexTitlesForTableView: will cause a magnifying glass icon to be displayed at that location in the index.Including this constant string in the array of strings returned by sectionIndexTitlesForTableView: will cause a magnifying glass icon to be displayed at that location in the index.".components(separatedBy: " ")
    
    override func       viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        tableView.dataSource = self
    }
    
    func loadData(){
        let loader = DataLoader()
        let result = loader.loadData(fileName: "cinema")
        print(result)
    }
}

extension TableDemoViewController: UITableViewDataSource
{
    //этот метод запрашивает число элементов в секции таблицы. о секциях позже
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    //здесь соредоточена основная логика работы с таблицей
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //запросим у таблицы ячейку с идентификатором,
        //который мы указали в сторибоард
        //нам вернут прототип ячейки, который можно поднастроить под
        //конкретный элемент массива строк
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic Cell",
                                                 for: indexPath)
        
        //настроим нашу ячейку
        //row - это индекс ячейки внутри секции
        let strToShow = strings[indexPath.row]
        
//        indexPath.section - номер секции ячейки
        //зададим текст в ячейке, используя конкретную строку
        cell.textLabel?.text = "\(indexPath.row) = \(strToShow)"
        
        //вернем ячейку, которую настроили
        return cell
    }
}

