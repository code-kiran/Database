//
//  SqliteManger.swift
//  Database
//
//  Created by kiran on 9/28/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import Foundation
import SQLite3

class SqlManager {
    var  db: OpaquePointer?
    
    //Local database connection
    func createDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("event.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return
        }
        
        
        if sqlite3_exec(db, "CREATE TABLE  IF NOT EXISTS Event (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return
        }else{
            print("success")
        }
    }
    
    //Insert in Local DataBase
    func insertLocalDatainTable(name: String) {
        createDatabase()
        let updateStatementString = "INSERT INTO Event (name) VALUES (\"\(name)\");"
        print(updateStatementString)
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully insert row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            print("UPDATE statement could not be prepared")
        }
    }
    /**
 ***Fetch data from local database
 ***/
    func fetchEventData() -> [EventModel]{
        createDatabase()
        var eventDatas = [EventModel]()
        
        var stmt:OpaquePointer?
        var queryString = String()
        
        queryString = "SELECT * FROM Event;"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return eventDatas
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            let eventDisct:NSDictionary = [
                "id" : String(cString: sqlite3_column_text(stmt, 0)),
                "name" : String(cString: sqlite3_column_text(stmt, 1))
            ]
            print(eventDisct)
            eventDatas.append(EventModel(name: eventDisct))
            
        }
        return eventDatas
    }
    
}
