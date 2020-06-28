//
//  MainController.swift
//  HSE Test
//
//  Created by Kostya "Bunsberry" Kalinin on 07.06.2020.
//  Copyright © 2020 Kostya Bunsberry. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var firstValuePickerView: UIPickerView!
    @IBOutlet weak var secondValuePickerView: UIPickerView!
    @IBOutlet weak var firstValueTextfield: UITextField!
    @IBOutlet weak var secondValueTextfield: UITextField!

    var rotationAngle: CGFloat!
    var customWidth: CGFloat!
    var customHeight: CGFloat!
    var modelData: [CurrencyModel]!
    
    var multiplier: Float!
    public static var exchange: ExchangeCore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        setupTextFields()
        
        customWidth = 100
        customHeight = 100
        
        modelData = Data.getData()
        
        let firstY = firstValuePickerView.frame.origin.y
        rotationAngle = -90 * (.pi/180)
        firstValuePickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        secondValuePickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        firstValuePickerView.frame = CGRect(x: -100, y: firstY, width: view.frame.width + 200, height: 100)
        secondValuePickerView.frame = CGRect(x: -100, y: firstY + 228, width: view.frame.width + 200, height: 100)
        
        let textfieldsX = firstValueTextfield.frame.origin.x
        firstValueTextfield.frame = CGRect(x: textfieldsX, y: firstY + 120, width: 300, height: 34)
        secondValueTextfield.frame = CGRect(x: textfieldsX, y: firstY + 164, width: 300, height: 34)

        firstValuePickerView.selectRow(3, inComponent: 0, animated: true)
        secondValuePickerView.selectRow(3, inComponent: 0, animated: true)
        
        multiplier = 1
        MainController.exchange = ExchangeCore(firstPick: "EUR", secondPick: "EUR")
    }
    
    // Закрываем Textfield'ы для удобства
    
    func setupTextFields() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero,
                                              size: .init(width: view.frame.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        firstValueTextfield.inputAccessoryView = toolbar
        secondValueTextfield.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    // Функционал
    
    @IBAction func firstValueChanged(_ sender: Any) {
        let first: Double = Double(firstValueTextfield.text!) ?? 0
        secondValueTextfield.text! =  String(first * MainController.exchange.multiplier)
    }
    
    @IBAction func secondValueChanged(_ sender: Any) {
        let second: Double = Double(secondValueTextfield.text!) ?? 0
        firstValueTextfield.text! =  String(second / MainController.exchange.multiplier)
    }
    
}

extension MainController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Picker View Delegate
    
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
        switch pickerView {
        
        case firstValuePickerView:
            MainController.exchange.newFirst(modelData[row].code)
            
            // 2DO Make async fucntioning change of textfields when i know how to
            
        case secondValuePickerView:
            MainController.exchange.newSecond(modelData[row].code)
            
        default:
            print("A picker view switch error")
        }
        
        firstValueTextfield.text! = ""
        secondValueTextfield.text! = ""
    }
    
    // Picker View Data Source

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modelData.count
    }
    
}
