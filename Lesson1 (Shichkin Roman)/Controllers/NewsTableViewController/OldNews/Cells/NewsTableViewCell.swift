//
//  NewsTableViewCell.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 26.04.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsGroupImage: UIImageView!
    @IBOutlet weak var newsGroupTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLikeLabel: UILabel!
    @IBOutlet weak var newsLikeButton: UIButton!
    
    var isLiked = true
    var saveNews: News?
    
    func clearCell() {
        newsGroupImage.image = nil
        newsGroupTitle.text = nil
        newsDescription.text = nil
        newsImage.image = nil
        saveNews = nil
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

        // Configure the view for the selected state
    }
    
    func configureNews(news: News) {
        newsDescription.lineBreakMode = .byWordWrapping
        newsDescription.numberOfLines = 0
        newsGroupImage.image = news.groupImage
        newsGroupTitle.text = news.groupName
        if let description = news.description {
            newsDescription.text = description
        }
        if let image = news.newsImage {
            newsImage.image = image
        }
    }
    
    @IBAction func newsLikeButton(_ sender: Any) {
        if isLiked {
            newsLikeLabel.pushTransition(0.4)
            newsLikeLabel.text = "1"
            newsLikeLabel.textColor = UIColor.red
            newsLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            newsLikeButton.tintColor = UIColor.red
        } else {
            newsLikeLabel.pushTransition(0.4)
            newsLikeLabel.text = "0"
            newsLikeLabel.textColor = UIColor.black
            newsLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            newsLikeButton.tintColor = UIColor.black
        }
        isLiked = !isLiked
    }
    
}
