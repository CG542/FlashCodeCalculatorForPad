//
//  ModelNumberToHOptionCompatibility.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/9/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class ModelNumberToHOptionCompatibility {
    
    var modelNumberToHOptionCompatibilityID: Int = 0
    var modelNumberID: Int = 0
    var hOptionID: Int = 0
    var rule: String = ""
    
    
    
    func findAll() -> Array<ModelNumberToHOptionCompatibility>{
        var result = Array<ModelNumberToHOptionCompatibility>()
        for item in DatabaseHelper.sharedInstance().query("select * from [ModelNumberToH-OptionCompatibility]"){
            var modelNumberToHOptionCompatibility = ModelNumberToHOptionCompatibility()
            modelNumberToHOptionCompatibility.modelNumberToHOptionCompatibilityID = NSNumberFormatter().numberFromString(item["ModelNumberToH-OptionCompatibilityID"]!)!.integerValue
            modelNumberToHOptionCompatibility.modelNumberID = NSNumberFormatter().numberFromString(item["ModelNumberID"]!)!.integerValue
            modelNumberToHOptionCompatibility.hOptionID = NSNumberFormatter().numberFromString(item["H-OptionID"]!)!.integerValue
            modelNumberToHOptionCompatibility.rule = item["Rule"]!
            
            result.append(modelNumberToHOptionCompatibility)
        }
        return result
    }
    
}