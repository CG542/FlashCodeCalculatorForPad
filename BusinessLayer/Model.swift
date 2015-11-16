//
//  RadioModel.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/14/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class Model{
    private var model: ModelNumber
    private var supportedHoptionList: Array<Option>
    
    init(modelFromDB: ModelNumber){
        NSLog("Start \(modelFromDB.modelNumber)")
        model = modelFromDB
        supportedHoptionList = Array<Option>()
        createAllHOptionsThruDB()
        NSLog("End \(modelFromDB.modelNumber)")
    }
    
    private func createAllHOptionsThruDB(){
        
        for item in DBCollection.DBData.hOptionListFromDB{
            var compatibility = DBCollection.DBData.modelNumberToHOptionsListFromDB.filter({$0.hOptionID == item.hOptionId
                && $0.modelNumberID == self.id
                && $0.rule == "X"}
                ).first
            if(compatibility == nil){
                supportedHoptionList.append(Option(optionFromDB: item))
            }
            
        }
    }
    
    var id: Int{
        get{
            return model.modelNumberID
        }
    }
    
    var modelNumber: String{
        get{
            return self.model.modelNumber+" - "+self.model.description
        }
    }
    
    var hoptionList: Array<Option>{
        get{
            return supportedHoptionList
        }
    }
}