//
//  FotoViewController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 15.04.2021.
//

import UIKit

class FotoViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var galleryView: GalleryHorisontalView!
//    @IBOutlet weak var imageViewPreview: UIImageView!
    var currentIndex: Int?
    var scrollV : UIScrollView!
    var fotoGallery: Array<UIImage>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fotos = fotoGallery!
        galleryView.setImages(images: fotos, index: currentIndex!)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
            
//        self.imageViewPreview.image = currentPhoto;
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
