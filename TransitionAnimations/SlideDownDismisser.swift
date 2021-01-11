//
//  SlideDownDismisser.swift
//  TransitionAnimations
//
//  Created by Albert Grislis on 11.01.2021.
//

import UIKit

open class SlideDownDismisser: NSObject {
    
    open var animationDuration: TimeInterval {
        get {
            return TimeInterval(0.5)
        }
    }
}

// MARK: UIViewControllerAnimatedTransitioning
extension SlideDownDismisser: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animationDuration,
                       animations: {
                        fromView.frame.origin.y += containerView.frame.height - fromView.frame.minY
                        fromView.alpha = 0.0
                       }) { completed in
            transitionContext.completeTransition(completed)
        }
    }
}
