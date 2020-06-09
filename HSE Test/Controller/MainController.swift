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
    
    var currencyModelPicker: CurrencyModelPicker!
    var secondModelPicker: SecondPicker!
    var rotationAngle: CGFloat!
    
    var multiplier: Float!
    public static var exchange: ExchangeCore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        setupTextFields()
        
        currencyModelPicker = CurrencyModelPicker()
        currencyModelPicker.modelData = Data.getData()
        
        secondModelPicker = SecondPicker()
        secondModelPicker.modelData = Data.getData()

        firstValuePickerView.delegate = currencyModelPicker
        secondValuePickerView.delegate = secondModelPicker
        firstValuePickerView.dataSource = currencyModelPicker
        secondValuePickerView.dataSource = currencyModelPicker
        
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
