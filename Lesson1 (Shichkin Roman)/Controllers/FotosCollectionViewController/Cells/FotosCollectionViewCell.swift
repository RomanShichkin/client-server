//
//  FotosCollectionViewCell.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.04.2021.
//

import UIKit

class FotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var fotoImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    var isLiked = true
    var savedImage: UIImage?
    
    func clearCell() {
        fotoImage.image = nil
        savedImage = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(image: UIImage) {
        fotoImage.image = image
        savedImage = image
    }
    
//    func configure(photos: PhotoItem) {
//        
//        guard let url = URL(string: photos.sizes) else { return }
//    let session = URLSession.shared
//    
//    session.dataTask(with: url) { (data, response, error) in
//        if let data = data, let image = UIImage(data: data) {
//            DispatchQueue.main.async {
//                self.fotoImage.image = image
//            }
//        }
//    }.resume()
//    }
    

    
    @IBAction func pressLikeButton(_ sender: Any) {
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


