//
//  Flashcode.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/23/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation
class Flashcode{
    func getFlashCodeByHoptonList(bands: [Option], ops: [Option]) -> String{
        var decodeFlashCode = [Int]()
        for index in 0...11{
            decodeFlashCode.append(0)
        }
        
        for band in bands{
            var i = 0
            
            var position: Int  = band.cpHoption.position * 8 - 4
            i = position / 8
            if(position % 8 == 0 && i>0){
                i--
            }
            
            decodeFlashCode[i] = (decodeFlashCode[i] | band.cpHoption.bitsValue)
            
        }
        
        for op in ops{
            var position = op.cpHoption.position * 8 - op.cpHoption.bitsPosition
            var offset = op.cpHoption.bitsPosition
            var i = position / 8
            
            if position % 8 == 0 && i > 0{
                i--
            }
            
            decodeFlashCode[i] = decodeFlashCode[i] | (1 << offset)
         }
        
        var firstCode = ""
        var secondCode = ""
        
        for i in 0...5{
            firstCode += DBCollection.DBData.flashcodeLetterFromDB.filter({$0.value == decodeFlashCode[i]}).first!.letter
            secondCode += DBCollection.DBData.flashcodeLetterFromDB.filter({$0.value == decodeFlashCode[i+6]}).first!.letter
        }
        
        return "\(firstCode)-\(secondCode)-\(calculateCheckSum(decodeFlashCode))"
        
    }
    
    private func calculateCheckSum(decodeFlashCode: [Int]) -> Int{
        var check_digit = 0
        var currentByte = 0
        var even = 0
        var odd = 0
        
        for i in 0...11{
            currentByte = decodeFlashCode[i]
            if i % 2 == 0{
                if currentByte * 2 >= 100{
                    even = ((currentByte * 2) / 100 ) + ( ((currentByte * 2) % 100) / 10 ) + (((currentByte * 2) % 100) % 10)
                }
                else{
                    even = ( ((currentByte * 2) % 100) / 10 ) + (((currentByte * 2) % 100) % 10)
                }
                check_digit = check_digit + even
            }
            else{
                odd = (currentByte / 10) + (currentByte % 10)
                check_digit = check_digit + odd
            }
        }
        
        var models_check_digit = check_digit % 10
        if models_check_digit > 0{
            check_digit = 10 - models_check_digit
        }
        else{
            check_digit = models_check_digit
        }
        
        return check_digit
    }
}