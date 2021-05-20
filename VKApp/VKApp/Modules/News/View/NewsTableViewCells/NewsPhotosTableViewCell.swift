//
//  NewsPhotosTableViewCell.swift
//  VKApp
//
//  Created by User on 16.05.2021.
//

import UIKit

protocol NewsPhotosTableViewProtocol {
    func setupNumberOfCells(_ collectionView: UICollectionView, numberOfItemsInSection section: Int, numberOfNews: Int?) -> Int
    func setupCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, numberOfNews: Int?) -> UICollectionViewCell
    func openPhoto(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, numberOfNews: Int?)
}


class NewsPhotosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var numberOfNews: Int?
    var delegate: NewsPhotosTableViewProtocol?

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
        return delegate?.setupNumberOfCells(collectionView, numberOfItemsInSection: section, numberOfNews: numberOfNews) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        delegate?.setupCell(collectionView, cellForItemAt: indexPath, numberOfNews: numberOfNews) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.openPhoto(collectionView, didSelectItemAt: indexPath, numberOfNews: numberOfNews)
    }
    
}
