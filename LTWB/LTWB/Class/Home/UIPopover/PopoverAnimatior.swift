//
//  PopoverAnimatior.swift
//  LTWB
//
//  Created by corepress on 2018/5/22.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class PopoverAnimatior: NSObject {
      var presentedViewFrame = CGRect.zero
      private lazy var isPresented = false
    
      var callBack : ((_ presented : Bool) -> ())?
     //自定义构造函数
       init(callBack : @escaping (_ presented : Bool) -> ()) {
            self.callBack = callBack
        }
}

//MARK: 改变弹出视图frame的delegate 方法
extension PopoverAnimatior : UIViewControllerTransitioningDelegate {
    //改变弹出视图frame
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
         let presentationController = TLPresentationController(presentedViewController: presented, presenting: presenting)
         presentationController.presentedViewFrame = presentedViewFrame
         return presentationController
    }
    //改变弹出视图弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack!(isPresented)
        return (self as UIViewControllerAnimatedTransitioning)
    }
    //改变弹出视图消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack!(isPresented)
        return (self as UIViewControllerAnimatedTransitioning)
    }
    
}
//MARK: 自定义弹出视图的动画
//transitionContext 动画上下文 可以通过transitionContext拿到弹出的view 和消失的view 1.UITransitionContextViewKey.from消失的view 2.UITransitionContextViewKey.to 弹出的view
extension PopoverAnimatior : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? setPresentedAnimed(transitionContext: transitionContext) : setDissmissAnimed(transitionContext: transitionContext)
    }
    //自定义弹出动画
    private func setPresentedAnimed(transitionContext: UIViewControllerContextTransitioning) {
        //弹出的view 必须添加到containerView中
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        transitionContext.containerView.addSubview(presentedView)
        
        presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
    }
    //自定义消失动画
    private func setDissmissAnimed(transitionContext: UIViewControllerContextTransitioning) {
        
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
        }) { (_) in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
    
}

