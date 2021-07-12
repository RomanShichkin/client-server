//
//  TextTableViewCell.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 11.07.2021.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var textNews: UILabel!
        
    func clearText() {
        textNews.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearText()
    }
    
    override func prepareForReuse() {
        clearText()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTextNews(news: News) {
        textNews.lineBreakMode = .byWordWrapping
        textNews.numberOfLines = 0
        if let description = news.description {
            textNews.text = description
        }
    }
}
