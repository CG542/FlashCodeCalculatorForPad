//
//  FLASHCodeLetter.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/9/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class FLASHCodeLetter {
    
    var flashcodeLetterID: Int = 0
    var value: Int = 0
    var letter: String = ""
    
    
    func findAll() -> Array<FLASHCodeLetter>{
        var result = Array<FLASHCodeLetter>()
        for item in DatabaseHelper.sharedInstance().query("select * from FLASHCodeLetter"){
            var flashcodeLetter = FLASHCodeLetter()
            flashcodeLetter.flashcodeLetterID = NSNumberFormatter().numberFromString(item["FLASHcodeLetterID"]!)!.integerValue
            flashcodeLetter.value = NSNumberFormatter().numberFromString(item["Value"]!)!.integerValue
            flashcodeLetter.letter = item["Letter"]!
            
            result.append(flashcodeLetter)
        }
        return result
    }
    
}
