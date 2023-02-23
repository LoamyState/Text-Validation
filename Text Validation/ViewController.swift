//
//  ViewController.swift
//  Text Validation
//
//  Created by Jane Madsen on 2/23/23.
//

import UIKit

enum Error {
    case tooShort, needSpecial, empty, none
}

class ViewController: UIViewController {
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func validatePassword() -> Error {
        guard let input = passwordTextField.text else {return .empty}
        
        let range = NSRange(location: 0, length: input.utf16.count)
        
        let pwRegex = try! NSRegularExpression(pattern: "[@,.!@#$%^&*<>?+=-]")
        
        if input.count < 8 {
            return .tooShort
        } else if pwRegex.firstMatch(in: input, options: [], range: range) != nil {
            return .none
        } else {
            return .needSpecial
        }
    }
    
    fileprivate func showError(_ label: String) {
        errorView.isHidden = false
        errorLabel.text = label
    }
    
    @IBAction func submitLogin(_ sender: Any) {
        let passwordValidatedError = validatePassword()
        switch passwordValidatedError {
        case .none:
            performSegue(withIdentifier: "PasswordSuccess", sender: sender)
        case .needSpecial:
            showError("Please include at least one special character: \"@,.!@#$%^&*<>?+=-\"")
        case .tooShort:
            showError("Please use at least 8 characters in your password.")
        case .empty:
            showError("Please enter a password.")
        }
    }
    
    
    @IBAction func dismissErrorView(_ sender: Any) {
        errorView.isHidden = true
    }
    
    
}



