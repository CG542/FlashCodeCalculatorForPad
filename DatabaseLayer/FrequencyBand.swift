//
//  FrequencyBand.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/9/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class FrequencyBand {
    var frequencyBandId: Int = 0
    var frequencyBand: String = ""
    var description: String = ""
    
    
    func findAll() -> Array<FrequencyBand>{
        var result = Array<FrequencyBand>()
        for item in DatabaseHelper.sharedInstance().query("select * from FrequencyBand"){
            var frequencyBand = FrequencyBand()
            frequencyBand.frequencyBandId = NSNumberFormatter().numberFromString(item["FrequencyBandID"]!)!.integerValue
            frequencyBand.frequencyBand = item["FrequencyBand"]!
            frequencyBand.description = item["Description"] ?? ""
            
            result.append(frequencyBand)
        }
        return result
    }

}