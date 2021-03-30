//
//  ViewControlleSimpleTransition.swift
//  VKApp
//
//  Created by User on 24.02.2021.
//

import Foundation
import UIKit


class ViewControlleSimpleDismiss: NSObject, UIViewControllerAnimatedTransitioning {
    
    var photoXPosition = 0
    var photoYPosition = 0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceVC = transitionContext.viewController(forKey: .from) else { return }
        guard let targetVC = transitionContext.viewController(forKey: .to) else { return }

        targetVC.view.frame = sourceVC.view.frame
        targetVC.view.layer.opacity = 0
        transitionContext.containerView.addSubview(targetVC.view)
        
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0,
                                options:[],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: { [self] in
                                        sourceVC.view.center.x = CGFloat(self.photoXPosition)
                                        sourceVC.view.center.y = CGFloat(self.photoYPosition)
                                        sourceVC.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                        sourceVC.view.backgroundColor = .clear
                                        sourceVC.view.layer.opacity = 0
                                        targetVC.view.layer.opacity = 1
                                    })
                                },
                                completion: { finished in
                                    targetVC.removeFromParent()
                                    transitionContext.completeTransition(finished)
                                })
    
    }

}
