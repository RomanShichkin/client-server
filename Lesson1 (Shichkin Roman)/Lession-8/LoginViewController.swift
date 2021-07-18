//
//  LoginViewController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 06.04.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let fromLoginToTabBarSegue = "fromLoginToTabBarSegue"
    var blueView = UIView()
    let loadingGif = UIImage.gifImageWithName("loading")
    let transitionManager = TransitionsManager()
    private var token: AuthStateDidChangeListenerHandle!

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    } // не работает с Scroll View...
    
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        self.hideKeyboard()
        super.viewDidLoad()
        blueView.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        blueView.frame = self.view.frame
        
        token = Auth.auth().addStateDidChangeListener{ [weak self] auth, user in
            guard user != nil else { return }
            self?.performSegue(withIdentifier: self!.fromLoginToTabBarSegue, sender: self)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func viewAnimation(segue: String) {
        
        let imageView = UIImageView(image: loadingGif)
        imageView.frame = CGRect(x: self.view.frame.size.width/4, y: self.view.frame.size.width/2, width: self.view.frame.size.width/2, height: self.view.frame.size.width/2)
        
        UIView.transition(
            from: self.view,
            to: blueView,
            duration: 0.5,
            options: .transitionCrossDissolve,
            completion: {[weak self]_ in
                guard let self = self else {return}
                self.blueView.addSubview(imageView)
//                пауза
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    UIView.transition(
                        from: self.blueView,
                        to: self.view,
                        duration: 0.5,
                        options: .transitionCrossDissolve,
                        completion:{[weak self]_ in
                            guard let self = self else {return}
                            imageView.removeFromSuperview()
                            self.performSegue(withIdentifier: segue, sender: self)
                        })
                }
            }
        )
    }
    
    private func showAlert(title: String?, text: String?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okControl = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okControl)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = transitionManager
    }
    
//    MARK: - Actions
    
    @IBAction func pressLoginButton(_ sender: Any?) {
        guard    let login = self.login.text, !login.isEmpty,
                 let password = self.password.text, !password.isEmpty
        else {
            showAlert(title: "Ошибка ввода логина/пароля", text: "Не введено")
            return
        }
        
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult , error in
            if let error = error {
                self?.showAlert(title: "Ошибка Firebase", text: error.localizedDescription)
            } else {
                self?.performSegue(withIdentifier: self!.fromLoginToTabBarSegue, sender: self)
            }
            
        }
        
//        TokenAndIdService.shared.token = (login + password).sha256() //хэшируем строку, чтобы больше было похоже с виду на токен
//        TokenAndIdService.shared.userId = (login + password).count  //просто считаем количество символов
//
//        print(TokenAndIdService.shared.token)
//        print(TokenAndIdService.shared.userId)
//        
//        viewAnimation(segue: fromLoginToTabBarSegue)
//        performSegue(withIdentifier: self.fromLoginToTabBarSegue, sender: self)
    }
    
    
    @IBAction func registrationAction(_ sender: Any) {
        
        guard    let login = self.login.text, !login.isEmpty,
                 let password = self.password.text, !password.isEmpty
        else {
            showAlert(title: "Ошибка ввода логина/пароля", text: "Не введено")
            return
        }
        
        Auth.auth().createUser(withEmail: login, password: password) { [weak self] authResult , error in
            if let error = error {
                self?.showAlert(title: "Ошибка Firebase", text: error.localizedDescription)
            } else {
                self?.pressLoginButton(nil)
            }
        }
        
    }
    
    @IBAction func exitToLogin(_ segue: UIStoryboardSegue) {
        login.text?.removeAll()
        password.text?.removeAll()
    }
    
}



