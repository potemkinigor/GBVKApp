//
//  NewsViewController.swift
//  VKApp
//
//  Created by User on 11.02.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
}

extension NewsViewController {
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - Table view configuration

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotosTableViewCell", for: indexPath) as! NewsPhotosTableViewCell
            
            cell.numberOfNews = indexPath.section
            cell.vc = self
            
            if news[indexPath.section].images.count == 0 {
                cell.photoView.isHidden = true
            } else {
                cell.photosCollectionView.reloadData()
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextTableViewCell", for: indexPath) as! NewsTextTableViewCell
            
            if news[indexPath.section].text == "" {
                cell.textNewsView.isHidden = true
            } else {
                cell.textNewsLabel.text = news[indexPath.section].text
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikesCommentsTableViewCell", for: indexPath) as! NewsLikesCommentsTableViewCell
            
            cell.numberOfLikesLabel.text = "\(news[indexPath.section].likesCount)"
            cell.numberOfCommentsLabel.text = "\(news[indexPath.section].commentsCount)"
            cell.numberOfViewsLabel.text = "\(news[indexPath.section].viewsCount)"
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
