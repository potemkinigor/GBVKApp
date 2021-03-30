//
//  ViewControllerTransitionDelegate.swift
//  VKApp
//
//  Created by User on 24.02.2021.
//

import Foundation
import UIKit

final class ViewControllerTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var photoXPosition = 0
    var photoYPosition = 0
    var photoHeight = 0
    var photoWidth = 0
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let simplePresent = ViewControlleSimplePresentation()
        simplePresent.photoXPosition = self.photoXPosition
        simplePresent.photoYPosition = self.photoYPosition
        simplePresent.photoWidth = self.photoWidth
        simplePresent.photoHeight = self.photoHeight
        return simplePresent
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let simplePresent = ViewControlleSimpleDismiss()
        simplePresent.photoXPosition = self.photoXPosition
        simplePresent.photoYPosition = self.photoYPosition
        return simplePresent
    }
    
    func updatePhotoParameters (photoXPosition: Int, photoYPosition: Int, photoHeight: Int, photoWidth: Int) {
        self.photoXPosition = photoXPosition
        self.photoYPosition = photoYPosition
        self.photoWidth = photoWidth
        self.photoHeight = photoHeight
        
    }
    
    
}
