//
//  SlideInPresentationManager.swift
//  AlertModule
//
//  Created by Andrés Guzmán on 22/05/20.
//  Copyright © 2020 Andrés Guzmán. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case top
    case bottom
}

enum PresentationType {
    case half
    case full
}

class SlideInPresentationManager: NSObject {
    var direction: PresentationDirection = .bottom
    var type: PresentationType = .half
    var disableCompactHeight = false
    var dismissOnDimmedView = true
}

// MARK: - UIViewControllerTransitioningDelegate
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = SlideInPresentationController(presentedViewController: presented,
                                                                   presenting: presenting,
                                                                   direction: direction,
                                                                   type: type,
                                                                   shouldHandleTapOnDimmedView: dismissOnDimmedView)
        presentationController.delegate = self
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: false)
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension SlideInPresentationManager: UIAdaptivePresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController,
        traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
            return .overFullScreen
        } else {
            return .none
        }
    }
}
