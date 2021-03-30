//
//  NavigationControllerAnimationPush.swift
//  VKApp
//
//  Created by User on 24.02.2021.
//

import Foundation
import UIKit


final class NavigationControllerAnimationPop: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceVC = transitionContext.viewController(forKey: .from) else { return }
        guard let targetVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerViewFrame = transitionContext.containerView.frame
        
        let sourceViewTargetFrame = CGRect(x: containerViewFrame.width, y: containerViewFrame.height, width: sourceVC.view.frame.width, height: sourceVC.view.frame.width)
        
        let destinationViewTargetFrame = sourceVC.view.frame
        
        transitionContext.containerView.addSubview(targetVC.view)
        
        targetVC.view.frame = CGRect(x: -containerViewFrame.height, y: -containerViewFrame.width, width: sourceVC.view.frame.width, height: containerViewFrame.height)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                     animations: {
                        sourceVC.view.transform = CGAffineTransform(rotationAngle: 1.570796)
                        sourceVC.view.frame = sourceViewTargetFrame
                        targetVC.view.frame = destinationViewTargetFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
}
