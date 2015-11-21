//
//  Option.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/14/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class Option{
    private var hOption: HOption
    
    init(optionFromDB: HOption){
        hOption = optionFromDB
        isChecked=false
    }

    var id: Int{
        get{
            return hOption.hOptionId
        }
    }
    
    var optionName: String{
        get{
            if(hOption.mobileHOption != "" && hOption.portableHOption != ""){
                return hOption.portableHOption+" - "+hOption.mobileHOption+" "+hOption.description
            }
            else if(hOption.mobileHOption != ""){
                return hOption.mobileHOption+" "+hOption.description
            }
            else{
                return hOption.portableHOption+" "+hOption.description
            }
        }
    }
    
    var isChecked: Bool;
}