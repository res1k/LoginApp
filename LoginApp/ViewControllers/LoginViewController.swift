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
    
    let user = User.getUserInfo()
    
    deinit {
        removeKeyboardNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotification()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        guard let viewControllers = tabBarController.viewControllers else { return }
        
        for viewController in viewControllers {
            if let welcomeVC = viewController as? WelcomeViewController {
                welcomeVC.userName = user.person.name + " " + user.person.surname
            } else if let navigationVC = viewController as? UINavigationController {
                let aboutUserVC = navigationVC.topViewController as! AboutMeViewController
                aboutUserVC.titleOfUser = user.person.name + " " + user.person.surname
                aboutUserVC.userInfo = user.person.info
            }
        }
    }
    
    @IBAction func logInButtonPress() {
        if userNameTF.text != user.login || passwordTF.text != user.password {
            displayAlert(
                withTitle: "Invalid login or password",
                message: "Please, enter correct login and password"
            )
            passwordTF.text = ""
        } else {
            performSegue(withIdentifier: "showWelcomeVC", sender: nil)
        }
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        passwordTF.text = ""
        userNameTF.text = ""
        
    }
    
    @IBAction func forgotNameButtonPress() {
        displayAlert(withTitle: "Oops!", message: "Your name is User 😉")
    }

    @IBAction func forgotPassButtonPressed() {
        displayAlert(withTitle: "Oops!", message: "Your password is Password 😉")
    }
    
    private func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}
// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            passwordTF.becomeFirstResponder()
        } else {
            logInButtonPress()
            performSegue(withIdentifier: "showWelcomeVC", sender: nil)
        }
        return true
    }
}

// MARK: - ScrollContent
extension ViewController {
    
    @objc func kbWillShow(_ notification: Notification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 30)
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
}
