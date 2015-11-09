//
//  ModelNumber.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/9/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class ModelNumber {
    
    var modelNumberID: Int = 0
    var radioFamilyID: Int = 0
    var modelNumber: String = ""
    var description: String = ""
    
    
    func findAll() -> Array<ModelNumber>{
        var result = Array<ModelNumber>()
        for item in DatabaseHelper.sharedInstance().query("select * from ModelNumber"){
            var modelNumber = ModelNumber()
            modelNumber.modelNumberID = NSNumberFormatter().numberFromString(item["ModelNumberID"]!)!.integerValue
            modelNumber.radioFamilyID = NSNumberFormatter().numberFromString(item["RadioFamilyID"]!)!.integerValue
            modelNumber.modelNumber = item["ModelNumber"]!
            modelNumber.description = item["Description"]!
            
            result.append(modelNumber)
        }
        return result
    }
    
}
