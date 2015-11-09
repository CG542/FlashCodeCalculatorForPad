//
//  HOption.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/9/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation
class HOption {
    
    var hOptionId: Int = 0
    var portableHOption: String = ""
    var mobileHOption: String = ""
    var description: String = ""
    var position: Int = 0
    var bitsPosition: Int = 0
    var bitsValue: Int = 0
    var frequencyBandID: Int = 0
    var isFreonPlatform: Bool = false
    
    
    func findAll() -> Array<HOption>{
        var result = Array<HOption>()
        for item in DatabaseHelper.sharedInstance().query("select * from [H-Option]"){
            var hOption = HOption()
            hOption.hOptionId = NSNumberFormatter().numberFromString(item["H-OptionID"]!)!.integerValue
            hOption.portableHOption = item["PortableH-Option"]!
            hOption.mobileHOption = item["MobileH-Option"]!
            hOption.description = item["Description"]!
            hOption.position = NSNumberFormatter().numberFromString(item["Position"]!)!.integerValue
            hOption.bitsPosition = NSNumberFormatter().numberFromString(item["BitsPosition"]!)!.integerValue
            hOption.bitsValue = NSNumberFormatter().numberFromString(item["BitsValue"]!)?.integerValue ?? 0
            hOption.frequencyBandID = NSNumberFormatter().numberFromString(item["FrequencyBandID"]!)?.integerValue ?? 0
            hOption.isFreonPlatform = NSNumberFormatter().numberFromString(item["IsAPX8000_Only"]!)?.boolValue ?? false
            
            result.append(hOption)
        }
        return result
    }
    
}
