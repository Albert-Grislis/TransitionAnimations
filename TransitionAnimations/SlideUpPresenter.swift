//
//  SlideUpPresenter.swift
//  TransitionAnimations
//
//  Created by Albert Grislis on 11.01.2021.
//

import UIKit

open class SlideUpPresenter: NSObject {
    
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
extension SlideUpPresenter: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        containerView.addSubview(toView)
        setupConstraints(to: toView, in: containerView)
        containerView.layoutIfNeeded()
        toView.layer.cornerRadius = cornerRadius
        toView.layer.maskedCorners = maskedCorners
        let originalOriginY = toView.frame.origin.y
        let animationDuration = transitionDuration(using: transitionContext)
        toView.frame.origin.y += containerView.frame.height - toView.frame.minY
        toView.alpha = 0.0
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 1.0,
                       options: [.curveLinear],
                       animations: {
                        toView.alpha = 1.0
                        toView.frame.origin.y = originalOriginY
                       }) { completed in
            transitionContext.completeTransition(completed)
        }
    }
}
