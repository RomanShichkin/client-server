//
//  NewsTableViewController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 12.07.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {

    let TextViewCellReuse = "TextTableViewCell"
    let n = DataStorage.shared.allNews.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: TextViewCellReuse)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return DataStorage.shared.allNews.count
    }
    
    func tableView(_ tableView: UITableView, numberRowsForSection section: Int) -> Int {
        return 3
        // count your cell counts with text or image(s)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) 
//            cell.
            return cell
        // Text
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath)
            return cell
        // Image
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikesTableViewCell", for: indexPath)
            return cell
        // Likes
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath)
            return cell
        }
    }


}
