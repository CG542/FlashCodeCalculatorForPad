//
//  FrequencyBandModelNumber.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/9/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class FrequencyBandModelNumber {
    
    var frequencyBandModelNumberID: Int = 0
    var modelNumberID: Int = 0
    var frequencyBandID: Int = 0
    
    
    func findAll() -> Array<FrequencyBandModelNumber>{
        var result = Array<FrequencyBandModelNumber>()
        for item in DatabaseHelper.sharedInstance().query("select * from FrequencyBandModelNumber"){
            var frequencyBandModelNumber = FrequencyBandModelNumber()
            frequencyBandModelNumber.frequencyBandModelNumberID = NSNumberFormatter().numberFromString(item["FrequencyBandModelNumberID"]!)!.integerValue
            frequencyBandModelNumber.modelNumberID = NSNumberFormatter().numberFromString(item["ModelNumberID"]!)!.integerValue
            frequencyBandModelNumber.frequencyBandID = NSNumberFormatter().numberFromString(item["FrequencyBandID"]!)!.integerValue
            
            result.append(frequencyBandModelNumber)
        }
        return result
    }
    
}