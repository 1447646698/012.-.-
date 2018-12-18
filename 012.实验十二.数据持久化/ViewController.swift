//
//  ViewController.swift
//  012.实验十二.数据持久化
//
//  Created by student on 2018/12/17.
//  Copyright © 2018年 李潘. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //name
    @IBOutlet weak var name: UITextField!
    //phone
    @IBOutlet weak var phone: UITextField!
    let personDb = SQLiteDB.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*let personTable = personDb.execute(sql: "create table if not exists person(name varchar(20),phone varchar(20))")
        print("personTable:\(personTable)")*/
        let resultTable = personDb.execute(sql: "create table if not exists person(name varchar(20),phone varchar(20))")
        if(resultTable != 0){
            print("Person表存在!")
        }
        else{
            print("Person表不存在!")
        }
    }
    //添加功能
    @IBAction func addPerson(_ sender: Any) {
        if( !name.text!.isEmpty && !phone.text!.isEmpty){
            let resultAdd = personDb.execute(sql: "insert into person(name,phone) values('\(name.text!)','\(phone.text!)')")
            if(resultAdd != 0){
                print("添加 name：\(name.text!)，phone：\(phone.text!)成功")
            }
        }
        else{
            print("添加失败!请输入name和phone")
        }
    }
    
    //更新功能
    @IBAction func updatePerson(_ sender: Any) {
        if( !name.text!.isEmpty ){
            //更改电话
            let resultUp = personDb.execute(sql: "update person set phone ='\(phone.text!)' where name = '\(name.text!)'")
            if(resultUp != 0){
                print("更新 name：\(name.text!)，phone：\(phone.text!)成功")
            }
            
        }
        else{
            print("更新失败!请输入要更改phone的name和要更改的phone。")
        }
    }
    
    //删除功能
    @IBAction func deletePerson(_ sender: Any) {
        if( !name.text!.isEmpty ){
            let resultDel = personDb.execute(sql: "delete from person where name = '\(name.text!)'")
            if(resultDel != 0){
                print("删除成功")
            }
           
        }
        else{
            print("请输入要删除的name")
        }
        
    }
    //查询功能
    @IBAction func queryPerson(_ sender: Any) {
        if( !name.text!.isEmpty ){
            let persons = personDb.query(sql: "select * from person where name = '\(name.text!)'")
            if let person = persons.first {
                phone.text = person["phone"] as? String
            }
        }
        else {
            print("请输入要查询的name")
        }
    }
}
