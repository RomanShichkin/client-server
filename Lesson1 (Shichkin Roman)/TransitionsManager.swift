//
//  TransitionsManager.swift
//  Lesson1 (Shichkin Roman)
//
//  Created by Роман Шичкин on 07.05.2021.
//

import UIKit

class TransitionsManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresented = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
//        containerView.backgroundColor = .systemTeal
        
        let beginState = CGAffineTransform(rotationAngle: -.pi/2)
        let endState = CGAffineTransform(rotationAngle: .pi/2)
        
        toView.layer.position = CGPoint(x: toView.frame.maxX, y: 0)
        fromView.layer.position = CGPoint(x: fromView.frame.maxX, y: 0)
        
        toView.layer.anchorPoint = CGPoint(x: 1, y: 0)
        fromView.layer.anchorPoint = CGPoint(x: 1, y: 0)
        
        toView.transform = isPresented ? beginState : endState
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(
            withDuration: duration,
            animations: { [unowned self] in
                toView.transform = .identity
                fromView.transform = self.isPresented ? endState : beginState
                
            }) { (isFinished) in
            transitionContext.completeTransition(true)
        }
        
    }
    

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
    
}
