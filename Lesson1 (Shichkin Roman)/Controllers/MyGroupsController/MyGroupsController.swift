//
//  MyGroupsController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.04.2021.
//

import UIKit
import RealmSwift
import Firebase

class MyGroupsController: UITableViewController {

    let friendsTableViewCellReuse = "FriendsTableViewCell"
    var groupsList = [GroupItem]()
    var groupsListRealm = [GroupsRealm]()
    
    private let ref = Database.database().reference(withPath: "userID") //создали контейнер для массива id
    private var groupsIDes = [GroupsID]()
    
    var notificationToken: NotificationToken?
    var groupsListRealmNotif: Results<GroupsRealm>?{
        didSet {
            notificationToken = groupsListRealmNotif?.observe{ changes in
                switch changes {
                case .initial(let results):
                    print("Start to modified", results)
                case .update(let results, let deletions, let insertions, let modifications):
                    print("Friends modified", results)
                case .error(let error):
                    print("error", error.localizedDescription)
                }
                print("Friends were modified = ", self.groupsList)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: friendsTableViewCellReuse)

        getDataPromise()
        groupsListRealmNotif = readGroupsRealmNotif()
        groupsListRealm = Array(groupsListRealmNotif!)
        print(groupsListRealm)
        
        let groupID = GroupsID(groupsID: configureGroup(groups: groupsListRealm))
        //Создаем ссылку на id внутри Firebase (контейнер для конкретного id)
        let userIDRef = self.ref.child(TokenAndIdService.shared.userId.lowercased())
        //Сохраняем dict в контейнер id
        userIDRef.setValue(groupID.toAnyObject())
    }
    
    private func getDataAF() {
        apiUserGroupsAF() {[weak self] groupsList in
            self?.groupsList = groupsList
            self?.tableView?.reloadData()
        }
    }
    
    private func getDataPromise() {
        promiseUserGroups()
            .get{ [weak self] groupsList in
                self?.groupsList = groupsList
                self?.tableView?.reloadData()
            }
            .catch { error in
                self.showError(error)
            }
            .finally {
                print("promiseUserGroups DONE!")
            }
    }
    
    private func showError(_ error: Error) {
        let vc = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        vc.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(vc, animated: true)
    }
    
    func configureGroup(groups: [GroupsRealm]) -> [String] {
        var arrayGroupId: [String] = []
        for i in groups {
            arrayGroupId.append(String(i.id))
        }
        return arrayGroupId
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        saveGroupsRealm(groupsItemArray: groupsList)
        loadGroupsRealm()
        return groupsListRealm.count
//        return DataStorage.shared.myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: friendsTableViewCellReuse, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }
        
        cell.configureWithGroup(groups: groupsListRealm[indexPath.row])
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataStorage.shared.myGroups.remove(at: indexPath.row)
        self.tableView.reloadData()
    }
    
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
