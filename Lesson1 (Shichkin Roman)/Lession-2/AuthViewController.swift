//
//  AuthViewController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 30.05.2021.
//

import UIKit
import WebKit
import Firebase

class AuthViewController: UIViewController, WKNavigationDelegate {

    private var userIDes = [UserID]()

    private let ref = Database.database().reference(withPath: "userID") //создали контейнер для массива id
    
    let fromAuthToTabBarSegue = "fromAuthToTabBarSegue"
    let transitionManager = TransitionsManager()
    var groupsList = [GroupItem]()
    
    @IBOutlet weak var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7867804"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "scope", value: "friends, photos, groups, wall"),
            URLQueryItem(name: "revoke", value: "all"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
}

extension AuthViewController {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        TokenAndIdService.shared.token = params["access_token"]!
        TokenAndIdService.shared.userId = params["user_id"]!
        
        print("---------TOKEN-------------------------------------------------------")
        print(TokenAndIdService.shared.token)
        print("---------USER ID-------------------------------------------------------")
        print(TokenAndIdService.shared.userId)
        
        //Создаем модель
        let userID = UserID(userID: TokenAndIdService.shared.userId)
        
        //Создаем ссылку на id внутри Firebase (контейнер для конкретного id)
        let userIDRef = self.ref.child(TokenAndIdService.shared.userId.lowercased())
        
        //Сохраняем dict в контейнер id
        userIDRef.setValue(userID.toAnyObject())
        
        apiNewsFeedPostAF()
        
//        apiGetUserAF(userId: TokenAndIdService.shared.userId)
//        apiFriendsListAF()
//        apiUserPhotoAF(token: TokenAndIdService.shared.token, userId: TokenAndIdService.shared.userId)
//        apiUserGroupsAF()
//        apiSearchGroupsAF(search: "Music")
//        
//        apiUserPhotoAF(userId: "143502972")
        
//        apiUserGroupsAF() {[weak self] groupsList in
//            self?.groupsList = groupsList
//        }
//        print("_____________________________________")
//        print(groupsList)
//        apiGetUser(token: TokenAndIdService.shared.token, userId: TokenAndIdService.shared.userId)
//        apiFriendsList(token: TokenAndIdService.shared.token, userId: TokenAndIdService.shared.userId)
//        apiUserPhoto(token: TokenAndIdService.shared.token, userId: TokenAndIdService.shared.userId)
//        apiUserGroups(token: TokenAndIdService.shared.token, userId: TokenAndIdService.shared.userId)
//        apiSearchGroups(token: TokenAndIdService.shared.token)
        
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: self.fromAuthToTabBarSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = transitionManager
    }
    
    @IBAction func exitToLogin(_ segue: UIStoryboardSegue) {
    }
}
