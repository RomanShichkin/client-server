//
//  FotosCollectionViewController.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 14.04.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class FotosCollectionViewController: UICollectionViewController {
    
    let inset: CGFloat = 20
    let minimumLineSpacing: CGFloat = 20
    let minimumInteritemSpacing: CGFloat = 20
    let cellsPerRow = 2
    
    var userPhotos = [PhotoItem]()
    var user: User?
    var userId: String?
    
    let fotosCollectionViewCellReuse = "FotosCollectionViewCell"
    let openFriendFotoSegue = "openFriendFoto"
    
    var fotoArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = user,
              let array = user?.fotoArray else {
            return
        }
        fotoArray = array
        
        self.collectionView.register(UINib(nibName: "FotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: fotosCollectionViewCellReuse)
        apiUserPhotoAF(userId: userId!) {[weak self] userPhotos in
            self?.userPhotos = userPhotos
            self?.collectionView?.reloadData()
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FotosCollectionViewCell
        //              let foto = cell.savedImage
        else { return }
        performSegue(withIdentifier: openFriendFotoSegue, sender: cell.savedImage)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == openFriendFotoSegue
        {
            guard let foto = sender as? UIImage,
                  let destination = segue.destination as? FotoViewController
            else {
                return
            }
            destination.fotoGallery = user?.fotoArray
            destination.currentIndex = findIndex(image: foto, in: user!.fotoArray)
        }
    }
    

    
    // MARK: UICollectionViewDataSource
    
    func findIndex(image searchImage: UIImage, in array: [UIImage]) -> Int? {
        for (index, image) in array.enumerated() {
            if image == searchImage {
                return index
            }
        }
     
        return nil
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fotosCollectionViewCellReuse, for: indexPath) as? FotosCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(image: fotoArray[indexPath.item])
        // Configure the cell
        
        return cell
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

extension FotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: 150, height: 150)
    //    }
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
}

//extension FotosCollectionViewController: UICollectionViewFlowLayout {
//
//}
