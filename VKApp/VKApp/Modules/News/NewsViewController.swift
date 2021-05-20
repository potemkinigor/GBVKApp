//
//  NewsViewController.swift
//  VKApp
//
//  Created by User on 11.02.2021.
//

import UIKit
import SDWebImage

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var networkManager = Session.shared
    
    private var newsPosts: NewsPostModel?
    private var newsPhoto: NewsPhotoModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
}

extension NewsViewController {
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NewsViewController {
    private func loadData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkManager.getNewsPosts {[weak self] newsPostData in
            DispatchQueue.global(qos: .background).async {
                let newsPostModel = try? JSONDecoder().decode(NewsPostModel.self, from: newsPostData)
                self?.newsPosts = newsPostModel
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        
        networkManager.getNewsPhoto {[weak self] newsPhotoData in
            DispatchQueue.global(qos: .background).async {
                let newsPhotoModel = try? JSONDecoder().decode(NewsPhotoModel.self, from: newsPhotoData)
                self?.newsPhoto = newsPhotoModel
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}

extension NewsViewController: NewsPhotosTableViewProtocol {
    func setupNumberOfCells(_ collectionView: UICollectionView, numberOfItemsInSection section: Int, numberOfNews: Int?) -> Int {
        guard let newsNumber = numberOfNews else { return 0 }
        let photosElements = newsPosts?.response?.items?[newsNumber].attachments?.filter({ $0.type == "photo" })
        return photosElements?.count ?? 0
    }
    
    func setupCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, numberOfNews: Int?) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsImageCollectionViewCell", for: indexPath) as! NewsImageCollectionViewCell
        
        guard let newsNumber = numberOfNews else { return UICollectionViewCell() }
        
        let photosElements = newsPosts?.response?.items?[newsNumber].attachments?.filter({ $0.type == "photo" })
        
        cell.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let photoURL = photosElements?[indexPath.row].photo?.sizes?[0].url ?? ""
        cell.imageView.sd_setImage(with: URL(string: photoURL), completed: nil)
        
        return cell
    }
    
    func openPhoto(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, numberOfNews: Int?) {
        
    }
    
}

//MARK: - Table view configuration

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.newsPosts?.response?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotosTableViewCell", for: indexPath) as! NewsPhotosTableViewCell
            
            cell.numberOfNews = indexPath.section
            cell.delegate = self
            
            let attachments = newsPosts?.response?.items?[indexPath.section].attachments?.filter({ $0.type == "photo" })
            
            if attachments?.count == 0 {
                cell.photoView.isHidden = true
            } else {
                cell.photosCollectionView.reloadData()
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextTableViewCell", for: indexPath) as! NewsTextTableViewCell
            
            let newsText = newsPosts?.response?.items?[indexPath.section].text

            if newsText == "" {
                cell.textNewsView.isHidden = true
            } else {
                cell.textNewsLabel.text = newsText
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikesCommentsTableViewCell", for: indexPath) as! NewsLikesCommentsTableViewCell
            
            guard let numberOfLikes = newsPosts?.response?.items?[indexPath.section].likes?.count,
                  let numberOfComments = newsPosts?.response?.items?[indexPath.section].comments?.count,
                  let numberOfViews = newsPosts?.response?.items?[indexPath.section].views?.count else { return cell}
            
            cell.numberOfLikesLabel.text = "\(numberOfLikes)"
            cell.numberOfCommentsLabel.text = "\(numberOfComments)"
            cell.numberOfViewsLabel.text = "\(numberOfViews)"
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
