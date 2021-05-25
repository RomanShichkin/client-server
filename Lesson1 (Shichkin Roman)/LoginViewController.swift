//
//  LoginViewController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 06.04.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let fromLoginToTabBarSegue = "fromLoginToTabBarSegue"
    var blueView = UIView()
    let loadingGif = UIImage.gifImageWithName("loading")
    let transitionManager = TransitionsManager()

    
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
    
    func showAlert(alertText: String) {
        let alertController = UIAlertController(title: "Error", message: alertText, preferredStyle: UIAlertController.Style.alert)
        let actionButton = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: {_ in
            self.login.text = ""
            self.password.text = ""
        })
        alertController.addAction(actionButton)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = transitionManager
    }
    
    @IBAction func pressLoginButton(_ sender: Any) {
//        guard    let login = self.login.text,
//                 let password = self.password.text,
//                 login.trimmingCharacters(in: .whitespacesAndNewlines) == "admin",
//                 password.trimmingCharacters(in: .whitespacesAndNewlines) == "admin"
//        else {
//            showAlert(alertText: "Неверный логин/пароль")
//            return
//        }

        viewAnimation(segue: fromLoginToTabBarSegue)
//        performSegue(withIdentifier: self.fromLoginToTabBarSegue, sender: self)
    }
    
    @IBAction func exitToLogin(_ segue: UIStoryboardSegue) {
        login.text?.removeAll()
        password.text?.removeAll()
    }
    
}



