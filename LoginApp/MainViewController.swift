//
//  ViewController.swift
//  LoginApp
//
//  Created by Andrey Zhivotov on 27.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var scrollView: UIScrollView!
    
    deinit {
        removeKeyboardNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else { return }
        welcomeVC.userName = userNameTF.text
    }
    
    @IBAction func logInButtonPress() {
        if userNameTF.text == "User" && passwordTF.text == "Password" {
            performSegue(withIdentifier: "Modally", sender: self)
            passwordTF.resignFirstResponder()
        } else {
            displayAlert(withTitle: "Invalid login or password", message: "Please, enter correct login and password")
            passwordTF.text = ""
        }
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let _ = segue.source as? WelcomeViewController else { return }
        passwordTF.text = ""
        userNameTF.text = ""
        
    }
    
    @IBAction func forgotNameButtonPress() {
        displayAlert(withTitle: "Oops!", message: "Your name is User 😉")
    }

    @IBAction func forgotPassButtonPressed() {
        displayAlert(withTitle: "Oops!", message: "Your password is Password 😉")
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 30) // 30 захардкоженное значение) не разобрался как сделать проверку перекрывает ли клавиатура объекты, и от этого смещать ее на нужное расстояние, если за y брать ширину клавиатуры, то все уезжает очень высоко
    }
    
    @objc func kbWillHide () {
        scrollView.contentOffset = CGPoint.zero
    }
    
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}

