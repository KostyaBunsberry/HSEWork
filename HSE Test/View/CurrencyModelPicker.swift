//
//  CurrencyModelPicker.swift
//  HSE Test
//
//  Created by Kostya Bunsberry on 07.06.2020.
//  Copyright © 2020 Kostya Bunsberry. All rights reserved.
//

import UIKit

class CurrencyModelPicker: UIPickerView {
    var modelData: [CurrencyModel]!
    let customWidth: CGFloat = 100
    let customHeight: CGFloat = 100
}

extension CurrencyModelPicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return customHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        
        let topLabel = UILabel(frame: CGRect(x: 0, y: 10, width: customWidth, height: 15))
        topLabel.text = modelData[row].country
        topLabel.textAlignment = .center
        topLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        view.addSubview(topLabel)
        
        let middleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        middleLabel.text = modelData[row].code
        middleLabel.textAlignment = .center
        middleLabel.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight.regular)
        view.addSubview(middleLabel)
        
        let bottomLabel = UILabel(frame: CGRect(x: 0, y: 78, width: customWidth, height: 15))
        bottomLabel.text = modelData[row].name
        bottomLabel.textAlignment = .center
        bottomLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        view.addSubview(bottomLabel)
        
        view.transform = CGAffineTransform(rotationAngle: (90 * (.pi/180)))
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        MainController.exchange.newFirst(modelData[row].code)
        MainController.exchange.newFirst(modelData[row].code)
    }
}

extension CurrencyModelPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modelData.count
    }
}
