//
//  FriendsTableViewController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.04.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {

    let friendsTableViewCellReuse = "FriendsTableViewCell"
    let fromFriendsToFotosSegue = "fromFriendsToFotos"
    let userSectionsTitles = DataStorage.shared.userSections
    
    var friendsList = [FriendsItem]()
    var friendsListRealm = [FriendsRealm]()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration)
        self.tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: friendsTableViewCellReuse)
        apiFriendsListAF() {[weak self] friendsList in
            self?.friendsList = friendsList
            self?.tableView?.reloadData()
        }
        friendsListRealm = readFriendsRealm()
        print(friendsListRealm)
    }

    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return DataStorage.shared.usersArray.count
        saveFriendsRealm(friendsItemArray: friendsList)
//        loadFriendsRealm()
        
        return friendsListRealm.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: friendsTableViewCellReuse, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }

//        let userKey = friendsList[indexPath.section]
        
        cell.configureWithUser(friends: friendsListRealm[indexPath.row])
        
//        (user:  DataStorage.shared.usersArray[indexPath.row]) //userValues[indexPath.row])
        
//        if let userValues = DataStorage.shared.groupedUsers[userKey] {
//
//            cell.configureWithUser(user:  DataStorage.shared.usersArray[indexPath.row]) //userValues[indexPath.row])
//            //Index out of range почему???
////                                    DataStorage.shared.usersArray[indexPath.row])
//        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return DataStorage.shared.userSections[section]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToFotosSegue {
            guard let userId = sender as? String,
                  let destination = segue.destination as? FotosCollectionViewController

            else {
                return
            }
            destination.userId = userId
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendsTableViewCell,
              let userId = cell.saveUserId
        else { return }
        
        performSegue(withIdentifier: fromFriendsToFotosSegue, sender: userId)
    }
    

//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
