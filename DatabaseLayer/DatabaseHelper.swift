//
//  DatabaseHelper.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/5/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation
import CoreData

class DatabaseHelper{
    
    // MARK: - Core Data stack
    struct Static {
        static var instance:DatabaseHelper? = nil
        static var token:dispatch_once_t = 0
    }
    
    class func sharedInstance() -> DatabaseHelper! {
        dispatch_once(&Static.token) {
            Static.instance = DatabaseHelper()
        }
        return Static.instance!
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
       
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var dbPath:NSURL = {
        let url=self.applicationDocumentsDirectory.URLByAppendingPathComponent("Admin.db")
        
        if(!NSFileManager.defaultManager().fileExistsAtPath(url.path!)){
            let defaultStorePath = NSBundle.mainBundle().pathForResource("Admin", ofType: ".db")
            NSFileManager.defaultManager().copyItemAtPath(defaultStorePath!, toPath:url.path!, error: nil)
        }
        
        return url

    }()

    func query(sql: String) -> Array<Dictionary<String,String>>{
        var db:COpaquePointer = nil
        var result = Array<Dictionary<String,String>>()
        var columnNames = Array<String>()
        var fetchColumnInfo = true
        
        let cpath = "\(dbPath)".cStringUsingEncoding(NSUTF8StringEncoding)
        if sqlite3_open(cpath!, &db) != SQLITE_OK{
            sqlite3_close(db)
            assert(false, "Open DB fail")
        }
        else{
            let cSql=sql.cStringUsingEncoding(NSUTF8StringEncoding)
            
            var statement:COpaquePointer = nil
            
            if(sqlite3_prepare(db, cSql!, -1, &statement, nil)) == SQLITE_OK{
                var queryResult = sqlite3_step(statement)
                
                while queryResult == SQLITE_ROW{
                    var columnCount = sqlite3_column_count(statement)

                    if fetchColumnInfo{
                        
                        for index in 0..<columnCount {
                            // Get column name
                            let name = sqlite3_column_name(statement, index)
                            columnNames.append(String.fromCString(name)!)
                        }
                        fetchColumnInfo = false
                    }
                    var row = Dictionary<String,String>()
                    for index in 0..<columnCount {
                        let key = columnNames[Int(index)]
                        let cValue = UnsafePointer<Int8> (sqlite3_column_text(statement, index))
                        let value = String.fromCString(cValue) ?? ""
                        row[key] = value
                    }
                    result.append(row)
                    queryResult = sqlite3_step(statement)
                    }
                }
            }
        
        return result
    }
}