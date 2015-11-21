//
//  DBCollection.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/14/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class DBCollection {
    
    struct Static {
        static var instance:DBCollection? = nil
        static var token:dispatch_once_t = 0
    }
    
    class func sharedInstance() -> DBCollection! {
        dispatch_once(&Static.token) {
            Static.instance = DBCollection()
        }
        return Static.instance!
    }
    
    struct DBData{
        private static var allRadios = RadioFamily().findAll()
        private static var allModelNumbers = ModelNumber().findAll()
        private static var allHoptions = HOption().findAll()
        private static var allModelNumberToHOptions = ModelNumberToHOptionCompatibility().findAll()
        
        static var radioListFromDB: Array<RadioFamily>{
            get{
                return allRadios
            }
        }
        
        static var modelNumberListFromDB: Array<ModelNumber>{
            get{
                return allModelNumbers
            }
        }
        
        static var hOptionListFromDB: Array<HOption>{
            get{
                return allHoptions
            }
        }
        
        static var modelNumberToHOptionsListFromDB: Array<ModelNumberToHOptionCompatibility>{
            get{
                return allModelNumberToHOptions
            }
        }
    }
    
    private var supportedRadios: Array<Radio>
    
    init(){
        supportedRadios = Array<Radio>()
        createAllRadioThruDB()
    }
    
    private func createAllRadioThruDB(){
        
        for item in DBData.radioListFromDB{
            var radio = Radio(radioFromDB: item)
            self.supportedRadios.append(radio)
        }
    }
    
    var radioList: Array<Radio>{
        get{
            return supportedRadios
        }
    }
    
    var selectedRadio: Radio?{
        didSet{
            NSLog("Selected Radio is \(selectedRadio?.radioName)")
        }
    }
    var selectedModel: Model?{
        didSet{
            NSLog("Selected Model is \(DBCollection.sharedInstance().selectedModel?.modelNumber)")
        }
    }
    
    func getFlashCode() -> String{
        var n: Int = 0
        for item in self.selectedModel!.hoptionList{
            if item.isChecked{
                n++
            }
        }
        return "You have selected \(n) options"
    }

}