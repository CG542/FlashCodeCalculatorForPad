//
//  Radio.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/14/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import Foundation

class Radio{
    
    private var radioFamily: RadioFamily
    private var supportedModels: Array<Model>
    
    init(radioFromDB: RadioFamily){
        radioFamily = radioFromDB
        supportedModels = Array<Model>()
        createAllModelsThruDB()
    }
    
    private func createAllModelsThruDB(){
        
        for item in DBCollection.DBData.modelNumberListFromDB{
            if(item.radioFamilyID == self.id){
                var model = Model(modelFromDB: item)
                self.supportedModels.append(model)
            }
        }
    }

    
    var id: Int{
        get{
            return self.radioFamily.radioFamilyID
        }
    }
    
    var radioName: String{
        get{
            return self.radioFamily.radioFamily
        }
    }
    
    var modelList: Array<Model>{
        get{
            return self.supportedModels
        }
    }
    
    
}