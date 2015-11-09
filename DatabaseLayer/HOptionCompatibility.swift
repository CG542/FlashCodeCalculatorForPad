//
//  HOptionCompatibility.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/9/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class HOptionCompatibility {
    
    var hOptionCompatibilityID: Int = 0
    var hOptionID: Int = 0
    var hOptionIDRule: Int = 0
    var rule: String = ""
    
    
    func findAll() -> Array<HOptionCompatibility>{
        var result = Array<HOptionCompatibility>()
        for item in DatabaseHelper.sharedInstance().query("select * from [MobileH-OptionCompatibility]"){
            var hOptionCompatibility = HOptionCompatibility()
            hOptionCompatibility.hOptionCompatibilityID = NSNumberFormatter().numberFromString(item["MobileH-OptionCompatibilityID"]!)!.integerValue
            hOptionCompatibility.hOptionID = NSNumberFormatter().numberFromString(item["H-OptionID"]!)!.integerValue
            hOptionCompatibility.hOptionID = NSNumberFormatter().numberFromString(item["H-OptionID-Rule"]!)!.integerValue
            hOptionCompatibility.rule = item["Rule"]!
            
            result.append(hOptionCompatibility)
        }
        return result
    }
    
}