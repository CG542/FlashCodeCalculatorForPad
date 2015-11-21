//
//  ViewController.swift
//  FlashCodeCalculatorForPad
//
//  Created by Andy on 11/4/15.
//  Copyright (c) 2015 Mot. All rights reserved.
//

import UIKit

class ModelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad(){
        DBCollection.sharedInstance().selectedRadio = DBCollection.sharedInstance().radioList[0]
        DBCollection.sharedInstance().selectedModel = DBCollection.sharedInstance().radioList[0].modelList[0]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return DBCollection.sharedInstance().radioList.count
        }
        else{
            return DBCollection.sharedInstance().selectedRadio?.modelList.count ?? DBCollection.sharedInstance().radioList[0].modelList.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0{
            return DBCollection.sharedInstance().radioList[row].radioName
        }
        else{
            return DBCollection.sharedInstance().selectedRadio?.modelList[row].modelNumber ?? DBCollection.sharedInstance().radioList[0].modelList[row].modelNumber
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            DBCollection.sharedInstance().selectedRadio = DBCollection.sharedInstance().radioList[row]
            DBCollection.sharedInstance().selectedModel = DBCollection.sharedInstance().selectedRadio?.modelList[0]
            self.picker.reloadComponent(1)
        }
        else{
            DBCollection.sharedInstance().selectedModel = DBCollection.sharedInstance().selectedRadio!.modelList[row]
        }
    }
}

