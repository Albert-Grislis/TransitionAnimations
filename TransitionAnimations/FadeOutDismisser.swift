//
//  FadeOutDismisser.swift
//  TransitionAnimations
//
//  Created by Albert Grislis on 11.01.2021.
//

import UIKit

open class FadeOutDismisser: NSObject {
    
    open var animationDuration: TimeInterval {
        get {
            return TimeInterval(0.5)
        }
    }
}

// MARK: UIViewControllerAnimatedTransitioning
extension FadeOutDismisser: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        let finalScale: CGFloat = 1.35
        let animationDuration: TimeInterval = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animationDuration, animations: {
            fromView.alpha = 0.0
            fromView.transform = CGAffineTransform(scaleX: finalScale, y: finalScale)
        }, completion: { completed in
            transitionContext.completeTransition(completed)
        })
    }
}
