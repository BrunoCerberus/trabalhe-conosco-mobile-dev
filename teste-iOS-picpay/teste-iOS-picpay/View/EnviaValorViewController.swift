//
//  EnviaValorViewController.swift
//  teste-iOS-picpay
//
//  Created by Bruno Lopes de Mello on 18/11/18.
//  Copyright © 2018 Bruno Lopes de Mello. All rights reserved.
//

import UIKit

protocol EnviarDinheiroDelegate {
    func finalizar(_ valor: Double)
}

class EnviaValorViewController: UIViewController {

    @IBOutlet weak var valorTextField: UITextField!
    @IBOutlet weak var enviarButton: UIButton!
    
    var delegate: EnviarDinheiroDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func enviar(_ sender: Any) {
        dismiss(animated: true) {
            if let valor = self.valorTextField.text?.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "R$", with: "")
                .replacingOccurrences(of: ",", with: ".").trimmingCharacters(in: .whitespaces) {
                self.delegate.finalizar(Double(valor) ?? 0.0)
            }
        }
    }
    
    @IBAction func cancelar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension EnviaValorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty {
            let texto = textField.text! + string
            textField.text = texto.currencyInputFormatting()
            return false
        } else if string.isEmpty {
            let texto = textField.text!
            textField.text = texto.currencyInputFormatting()
        }
        
        return true
    }
}
