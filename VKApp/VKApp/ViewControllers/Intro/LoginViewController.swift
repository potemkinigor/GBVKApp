//
//  LoginViewController.swift
//  VKApp
//
//  Created by Igor Potemkin on 23.01.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var enterButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var login = "Geekbrains"
    var password = "Geekbrains"
    
    @objc func hideKeyboard () {
        self.scrollView?.endEditing(true)
    }
 
    @IBAction func enterButtonTap(_ sender: Any) {
        let loginText = self.loginTextField.text
        let passwordText = self.passwordTextField.text
        
        if loginText == "" || passwordText == "" {
            let alert = UIAlertController(title: "Данные не заполнены", message: "Просьба ввести логин и пароль", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if loginText == login && passwordText == password {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loadingVC = storyBoard.instantiateViewController(identifier: "loadingVC")

            self.present(loadingVC, animated: true, completion: nil)
            
            
        } else {
            let alert = UIAlertController(title: "Неверные данные", message: "Введите правильный логин и пароль", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        hideKeyboard()
        
    }
    
    @IBAction func registerButtonTap(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func forgetPasswordButtonTap(_ sender: Any) {
        let alert = UIAlertController(title: "Восстановление пароля", message: "Ваш логин: \(login), пароль \(password)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    @IBAction func registerViaVKButtonPush(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loadingVC = storyBoard.instantiateViewController(identifier: "autorizeVCviaVK")
        loadingVC.modalPresentationStyle = .fullScreen
        self.present(loadingVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UIGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        enterButton.layer.cornerRadius = 10
        enterButton.layer.shadowRadius = 3
        registerButton.layer.cornerRadius = 10
        enterButton.layer.shadowRadius = 3
    }

}

