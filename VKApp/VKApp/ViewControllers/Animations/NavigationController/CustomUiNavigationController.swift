//
//  CustomUiNavigationController.swift
//  VKApp
//
//  Created by User on 24.02.2021.
//

import UIKit

class CustomUiNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    var interactionTransition = UINavigationControllerInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            self.interactionTransition.viewController = toVC
            return NavigationControllerAnimationPush()
        case .pop:
            if navigationController.viewControllers.first != toVC {
                self.interactionTransition.viewController = toVC
            }
            return NavigationControllerAnimationPop()
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionTransition.interactionIsInProgress ? interactionTransition : nil
    }

}
