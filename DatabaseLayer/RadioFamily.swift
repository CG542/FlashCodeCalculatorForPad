//
//  RadioFamily.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/7/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation
import CoreData

class RadioFamily {

    var radioFamilyID: Int = 0
    var radioFamily: String = ""
    

    func findAll() -> Array<RadioFamily>{
        var result = Array<RadioFamily>()
        for item in DatabaseHelper.sharedInstance().query("select * from RadioFamily"){
            var radioFamily = RadioFamily()
            radioFamily.radioFamilyID = NSNumberFormatter().numberFromString(item["RadioFamilyID"]!)!.integerValue
            radioFamily.radioFamily = item["RadioFamily"]!
            
            result.append(radioFamily)
        }
        return result
    }
    
}
