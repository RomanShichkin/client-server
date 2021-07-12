//
//  ImageTableViewCell.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 11.07.2021.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    
    func clearCell() {
        imageNews.image = nil
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
    
    func configureImageNews(news: News) {
        if let image = news.newsImage {
            imageNews.image = image
        }
    }
    
}
