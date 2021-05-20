//
//  ViewManager.swift
//  VKApp
//
//  Created by User on 16.05.2021.
//

import Foundation
import UIKit

class ViewManager {
    static let shared = ViewManager()
    
    private init() {}
    
    
    func showPhotoPreview(vc: UIViewController, imagesArray: [UIImage], selectedPhoto: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "imageViewer") as! PhotoViewerViewController
        
        viewController.imagesArray = imagesArray
        viewController.numberOfCurrentPresentedPhoto = selectedPhoto
        
        viewController.modalPresentationStyle = .fullScreen
        
        vc.present(viewController, animated: true, completion: nil)
        
    }
}
