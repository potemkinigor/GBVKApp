//
//  UINavigationControllerInteractiveTransition.swift
//  VKApp
//
//  Created by User on 24.02.2021.
//

import UIKit

final class UINavigationControllerInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var interactionIsInProgress = false
    
    private var shouldCompleteTransition = false
    
    var viewController: UIViewController? {
        didSet {
            let edgePanGestureRecogniser = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
            edgePanGestureRecogniser.edges = [.left]
            viewController?.navigationController?.view.addGestureRecognizer(edgePanGestureRecogniser)
        }
    }
    
    
    @objc func handleGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: sender.view?.superview)
        var progress = (translation.x / 100)
        
        progress = CGFloat(min(max(progress, 0.0), 1.0))

        switch sender.state {
        case .began:
            self.interactionIsInProgress = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionIsInProgress = false
            cancel()
        case .ended:
            interactionIsInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
    
}
