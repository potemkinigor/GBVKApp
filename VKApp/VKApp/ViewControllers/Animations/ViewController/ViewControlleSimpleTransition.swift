//
//  ViewControlleSimpleTransition.swift
//  VKApp
//
//  Created by User on 24.02.2021.
//

import Foundation
import UIKit


class ViewControlleSimplePresentation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var photoXPosition = 0
    var photoYPosition = 0
    var photoHeight = 0
    var photoWidth = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceVC = transitionContext.viewController(forKey: .from) else { return }
        guard let targetVC = transitionContext.viewController(forKey: .to) else { return }
        
        let destinationViewFrame = sourceVC.view.frame
        
        transitionContext.containerView.addSubview(targetVC.view)
        
        targetVC.view.frame = CGRect(x: CGFloat(photoXPosition), y: CGFloat(photoYPosition), width: sourceVC.view.frame.width, height: sourceVC.view.frame.width)
        
        targetVC.view.center.x = CGFloat(self.photoXPosition) + CGFloat(self.photoWidth/2)
        targetVC.view.center.y = CGFloat(self.photoYPosition) + CGFloat(self.photoHeight/2)
        
        targetVC.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        targetVC.view.layer.opacity = 0
        targetVC.view.backgroundColor = .clear
        
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0,
                                options:[],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                                        targetVC.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                                        targetVC.view.frame = destinationViewFrame
                                        targetVC.view.backgroundColor = .black
                                        targetVC.view.layer.opacity = 1
                                    })
                                },
                                completion: { finished in
                                    targetVC.removeFromParent()
                                    transitionContext.completeTransition(finished)
                                })
    }
}
