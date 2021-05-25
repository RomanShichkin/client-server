//
//  TabBarController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.04.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    func fillArrays() {
        let user1 = setNewUser(name: "Wall-e", age: 30)
        let user2 = setNewUser(name: "Terminator", age: 50)
        let user3 = setNewUser(name: "Robocop", age: 45)
        let user4 = setNewUser(name: "Mr Robot", age: 25)
        let user5 = setNewUser(name: "R2D2", age: 64)
        
        let userArray = [user1, user2, user3, user4, user5]
        let sortedUserArray = userArray.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
        let groupedUsers = Dictionary(grouping: sortedUserArray) { String($0.name.first!) }
        let userSectionTitles = Array(groupedUsers.keys)
        
        let group1 = Group(name: "Lego", description: "Конструктор Лего", groupImage: UIImage(named: "Lego"))
        let group2 = Group(name: "DC", description: "Комиксы и фильмы DC", groupImage: UIImage(named: "DC"))
        let group3 = Group(name: "Marvel", description: "Комиксы и фильмы Марвел", groupImage: UIImage(named: "Marvel"))
        let group4 = Group(name: "Nintendo", description: "Игры компании Nintendo", groupImage: UIImage(named: "Nintendo"))
        
        let groupArray = [group1, group2, group3, group4]

        let news1 = News(description: "Однако, здравствуйте...", groupImage: UIImage(named: "Lego"), groupName: "Lego", newsImage: UIImage(named: "1"))
        let news2 = News(description: "Когда увидел цены на игры в eShop...", groupImage: UIImage(named: "Nintendo"), groupName: "Nintendo", newsImage: UIImage(named: "2"))
        let news3 = News(description: "Мемчики про xCode подъехали", groupImage: UIImage(named: "Marvel"), groupName: "Marvel", newsImage: UIImage(named: "3"))
        
        let newsArray = [news1, news2, news3]
        
        DataStorage.shared.usersArray = sortedUserArray
        DataStorage.shared.allGroups = groupArray
        DataStorage.shared.allNews = newsArray
        DataStorage.shared.groupedUsers = groupedUsers
        DataStorage.shared.userSections = userSectionTitles
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillArrays()
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
