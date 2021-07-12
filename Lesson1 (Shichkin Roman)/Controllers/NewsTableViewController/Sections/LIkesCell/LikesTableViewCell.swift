//
//  LikesTableViewCell.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 11.07.2021.
//

import UIKit

class LikesTableViewCell: UITableViewCell {

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var isLiked = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func newsLikeButton(_ sender: Any) {
        if isLiked {
            likeLabel.pushTransition(0.4)
            likeLabel.text = "1"
            likeLabel.textColor = UIColor.red
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = UIColor.red
        } else {
            likeLabel.pushTransition(0.4)
            likeLabel.text = "0"
            likeLabel.textColor = UIColor.black
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = UIColor.black
        }
        isLiked = !isLiked
    }
    
}
