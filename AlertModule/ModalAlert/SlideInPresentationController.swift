//
//  SlideInPresentationController.swift
//  AlertModule
//
//  Created by Andrés Guzmán on 22/05/20.
//  Copyright © 2020 Andrés Guzmán. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    // MARK: - Properties
    private var direction: PresentationDirection
    private var type: PresentationType
    private var dimmingView: UIView!
    private var shouldHandleTapOnDimmedView: Bool
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)

        switch direction {
        case .bottom:
            frame.origin.y = containerView!.frame.height*(type == .half ? 0.5 : 0.0)
        default:
            frame.origin = .zero
        }
        return frame
    }
    
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: PresentationDirection,
         type: PresentationType,
         shouldHandleTapOnDimmedView: Bool) {
        self.direction = direction
        self.type = type
        self.shouldHandleTapOnDimmedView = shouldHandleTapOnDimmedView
        
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
        setupRadius(with: 20.0, using: presentedView)
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        guard let dimmingView = dimmingView else {
            return
        }
        containerView?.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
            if self.direction == .bottom {
                self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
                self.presentingViewController.view.layer.cornerRadius = 10.0
            }
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
            self.presentingViewController.view.transform = .identity
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: parentSize.height*(type == .half ? 0.5 : 1.0))
        }
    }
}

// MARK: - Private
private extension SlideInPresentationController {
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        if shouldHandleTapOnDimmedView {
            presentingViewController.dismiss(animated: true)
        }
    }
    
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    func setupRadius(with radius: CGFloat, using view: UIView?) {
        view?.layer.cornerRadius = radius
        view?.clipsToBounds = true
    }
}
