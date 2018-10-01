//
//  ViewController.swift
//  Database
//
//  Created by kiran on 9/28/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtName: UITextField!
    var newSqlManger = SqlManager()
    var eventDatas = [EventModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func btnSave(_ sender: Any) {
        newSqlManger.insertLocalDatainTable(name: txtName.text!)
        eventDatas = newSqlManger.fetchEventData()
        tableView.reloadData()
    }

}

extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTVC", for: indexPath) as! EventTableViewCell
        cell.lblName.text =  eventDatas[indexPath.row].eventName
        return cell
        
    }
}

