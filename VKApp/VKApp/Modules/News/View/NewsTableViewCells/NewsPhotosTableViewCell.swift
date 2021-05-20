//
//  NewsPhotosTableViewCell.swift
//  VKApp
//
//  Created by User on 16.05.2021.
//

import UIKit

class NewsPhotosTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var numberOfNews: Int?
    weak var vc: UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension NewsPhotosTableViewCell {
    func setup() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
}

//MARK: - Collection view delegates

extension NewsPhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let newsNumber = numberOfNews else { return 0 }
        return news[newsNumber].images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsImageCollectionViewCell", for: indexPath) as! NewsImageCollectionViewCell
        
        guard let newsNumber = numberOfNews else { return UICollectionViewCell() }
        
        cell.imageView.image = news[newsNumber].images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.vc,
              let newsNumber = numberOfNews else { return }
        ViewManager.shared.showPhotoPreview(vc: vc, imagesArray: news[newsNumber].images, selectedPhoto: indexPath.row)
    }
    
}
