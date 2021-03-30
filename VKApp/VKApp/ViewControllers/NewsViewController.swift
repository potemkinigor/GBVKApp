//
//  NewsViewController.swift
//  VKApp
//
//  Created by User on 11.02.2021.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "postCollectionCiewCellReusableIdentifyer")
    }
}

extension NewsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCollectionCiewCellReusableIdentifyer", for: indexPath) as! PostCollectionViewCell
        
        cell.newsText.text = news[indexPath.row].text
        cell.mediaDataArray.removeAll()
        cell.mediaDataArray = news[indexPath.row].images
        cell.likesCount.text = String(news[indexPath.row].likesCount)
        cell.viewsCount.text = String(news[indexPath.row].viewsCount)
        cell.repostsCount.text = String(news[indexPath.row].repostsCount)
        cell.commentsCount.text = String(news[indexPath.row].commentsCount)
        cell.newsLikes.newsIndex = indexPath.row
    
        return cell
    }
    
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 249)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        news[indexPath.row].viewsCount += 1
    }
 
}
