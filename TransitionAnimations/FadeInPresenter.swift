//
//  FadeInPresenter.swift
//  TransitionAnimations
//
//  Created by Albert Grislis on 11.01.2021.
//

import UIKit

open class FadeInPresenter: NSObject {
    
    open var animationDuration: TimeInterval {
        get {
            return TimeInterval(0.5)
        }
    }
    open var cornerRadius: CGFloat {
        get {
            return 10.0
        }
    }
    open var maskedCorners: CACornerMask {
        get {
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    open func setupConstraints(to view: UIView, in containerView: UIView) {
        fatalError("This method should be implemented in the child class")
    }
}

// MARK: UIViewControllerAnimatedTransitioning
extension FadeInPresenter: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        let animationDuration = transitionDuration(using: transitionContext)
        let initialScale: CGFloat = 1.35
        containerView.addSubview(toView)
        setupConstraints(to: toView, in: containerView)
        containerView.layoutIfNeeded()
        toView.layer.cornerRadius = cornerRadius
        toView.layer.maskedCorners = maskedCorners
        toView.alpha = 0.0
        toView.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
        UIView.animate(withDuration: animationDuration, animations: {
            toView.alpha = 1.0
            toView.transform = .identity
        }, completion: { completed in
            transitionContext.completeTransition(completed)
        })
    }
}
