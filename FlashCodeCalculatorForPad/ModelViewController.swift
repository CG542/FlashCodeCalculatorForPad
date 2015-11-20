//
//  ViewController.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/4/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import UIKit

class ModelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    var selectedRadio: Radio? 
    var selectedModel: Model?
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad(){
        self.selectedRadio = DBCollection.sharedInstance().radioList[0]
        self.selectedModel = self.selectedRadio?.modelList[0]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return DBCollection.sharedInstance().radioList.count
        }
        else{
            if(self.selectedRadio != nil){
                return DBCollection.sharedInstance().radioList.filter({$0.id == self.selectedRadio!.id
                }).first!.modelList.count
            }
            else{
                return DBCollection.sharedInstance().radioList[0].modelList.count
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0{
            return DBCollection.sharedInstance().radioList[row].radioName
        }
        else{
            if(self.selectedRadio != nil){
                return DBCollection.sharedInstance().radioList.filter({$0.id == self.selectedRadio!.id
                }).first!.modelList[row].modelNumber
            }
            else{
                return DBCollection.sharedInstance().radioList[0].modelList[row].modelNumber
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            self.selectedRadio = DBCollection.sharedInstance().radioList[row]
            self.selectedModel = self.selectedRadio?.modelList[0]
            self.picker.reloadComponent(1)
            NSLog("Selected Radio is \(self.selectedRadio?.radioName)")
            NSLog("Selected Model is \(self.selectedModel?.modelNumber)")
        }
        else{
            self.selectedModel = DBCollection.sharedInstance().radioList.filter({$0.id == self.selectedRadio!.id
            }).first!.modelList[row]
            NSLog("Selected Model is \(self.selectedModel?.modelNumber)")
        }
    }
}

