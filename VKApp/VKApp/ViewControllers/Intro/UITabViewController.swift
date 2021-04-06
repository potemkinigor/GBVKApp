//
//  UITabViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit

var news: [NewsPost] = []

class UITabViewController: UITabBarController {
    
    var hint = "Hello!"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateNews()
        
    }
    
    func updateNews () {
        
        var images: [UIImage] = []
        images.removeAll()
        
        images.append(UIImage(named: "news_4")!)
        images.append(UIImage(named: "news_1")!)
        images.append(UIImage(named: "news_2")!)
        images.append(UIImage(named: "news_3")!)
        images.append(UIImage(named: "news_2")!)
        
        
        news.append(NewsPost(text: "First News", images: images, likesCount: 10, isLiked: false, viewsCount: 15, repostsCount: 10, commentsCount: 3 ))
        
        images.remove(at: 2)
        
        news.append(NewsPost(text: "Second News", images: images, likesCount: 20, isLiked: true, viewsCount: 35, repostsCount: 10, commentsCount: 3))
        news.append(NewsPost(text: "Third News", images: images, likesCount: 12, isLiked: false, viewsCount: 15, repostsCount: 10, commentsCount: 3))
        
        images.remove(at: 0)
        images.remove(at: 0)
        
        news.append(NewsPost(text: "One more news to make it right", images: images, likesCount: 5, isLiked: true, viewsCount: 35, repostsCount: 10, commentsCount: 3))
        news.append(NewsPost(text: "One more news to make it right", images: images, likesCount: 5, isLiked: true, viewsCount: 35, repostsCount: 10, commentsCount: 3))
        news.append(NewsPost(text: "One more news to make it right", images: images, likesCount: 5, isLiked: true, viewsCount: 35, repostsCount: 10, commentsCount: 3))
        news.append(NewsPost(text: "One more news to make it right", images: images, likesCount: 5, isLiked: true, viewsCount: 35, repostsCount: 10, commentsCount: 3))
        
        news.append(NewsPost(text: "One more news to make it right", images: images, likesCount: 5, isLiked: true, viewsCount: 35, repostsCount: 10, commentsCount: 3))
        news.append(NewsPost(text: "One more news to make it right", images: images, likesCount: 5, isLiked: true, viewsCount: 35, repostsCount: 10, commentsCount: 3))
        news.append(NewsPost(text: "One more news to make it right", images: images, likesCount: 5, isLiked: true, viewsCount: 35, repostsCount: 10, commentsCount: 3))
        
    }

}
