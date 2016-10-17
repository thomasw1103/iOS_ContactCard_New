//
//  databaseHelper.swift
//  SQLiteCRUD
//
//  Created by Diederich Kroeske on 06/10/2016.
//  Copyright © 2016 Diederich Kroeske. All rights reserved.
//

import Foundation

class DataBaseHelper: NSObject {
    
    static let sharedInstance = DataBaseHelper()
    
    var db : OpaquePointer? = nil
    
    override init() {
        let path = Bundle.main.path(forResource: "contact", ofType: "sqlite")
        if sqlite3_open(path!, &db) != SQLITE_OK {
            print("Error opening database!!")
        }
    }
    
    // CREATE from CRUD
    func create(firstname: String, lastname: String) {
        
        let query = "INSERT INTO person (firstname, lastname) VALUES (?, ?)"
        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, firstname, -1, nil);
            sqlite3_bind_text(statement, 2, lastname, -1, nil);
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error inserting row")
            }
        } else {
            print("Error")
        }
        
        // Reset als je insert in een loop
        sqlite3_reset(statement);
        //
        sqlite3_finalize(statement);
    }
    
    // READ from CRUD
    func read() -> [Person] {
        
        // Empty array
        var result = [Person]();
        
        // Query
        let query = "SELECT * FROM person;"
        
        // Prepare query and execute
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error query: \(errmsg)")
            return result
        }
        
        // Construct names
        while sqlite3_step(statement) == SQLITE_ROW {
            let person : Person = Person();
            person.firstName = String(cString: sqlite3_column_text(statement, 1));
            person.lastName = String(cString: sqlite3_column_text(statement, 2));
            result.append(person);
        }
        
        return result
    }
}
