//
//  FriendsTableViewCell.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.04.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    var saveUser: User?
    var saveGroup: Group?
    
    @IBInspectable var myShadowColor: UIColor = UIColor.black
    @IBInspectable var myShadowRadius: CGFloat = 10
    @IBInspectable var myShadowOpacity: Float = 0.9
    
    func clearCell() {
        mainImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        saveUser = nil
        saveGroup = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        imageAnimate(imageView: mainImageView)
        // Configure the view for the selected state
    }
    
    func configureWithUser(user: User) {
        if let image = user.avatar {
            mainImageView.image = image
        }

        nameLabel.text = user.name
        
        if let age = user.age {
        descriptionLabel.text = "Возраст: " + String(age)
        }
        
        shadowView.clipsToBounds = false
        shadowView.backgroundColor = UIColor.darkGray
        shadowView.layer.cornerRadius = mainImageView.frame.size.width / 0.8
        shadowView.layer.shadowColor = myShadowColor.cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = myShadowRadius
        shadowView.layer.shadowOpacity = myShadowOpacity

//        mainImageView.clipsToBounds = false
        mainImageView.image = user.avatar
        mainImageView.layer.cornerRadius = mainImageView.frame.size.width / 0.8
        
        mainImageView.layer.shadowOffset = CGSize.zero
        mainImageView.layer.shadowRadius = 60
        mainImageView.layer.shadowOpacity = 2

        saveUser = user
    }
    
    func configureWithGroup(group: Group) {
        if let image = group.groupImage {
            mainImageView.image = image
        }

        nameLabel.text = group.name
        
        if let description = group.description {
        descriptionLabel.text = String(description)
        }
        
        saveGroup = group
    }
    
}
