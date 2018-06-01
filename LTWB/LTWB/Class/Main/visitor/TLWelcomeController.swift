//
//  TLWelcomeController.swift
//  LTWB
//
//  Created by corepress on 2018/5/28.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SDWebImage

class TLWelcomeController: UIViewController {
    @IBOutlet weak var welcomLable: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarBottomCon: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let avatar = TLUserAcountViewModel.shareInstance.userAcount?.avatar_large
        let avatarUrl = URL(string: avatar ?? "")
        avatarImageView.sd_setImage(with: avatarUrl, placeholderImage: UIImage(named:"avatar_default"), options: [], completed: nil)

         self.avatarImageView.transform = CGAffineTransform(translationX: 0, y: -(UIScreen.main.bounds.size.height - 150 - 90))
        //Damping 0-1 越接近0 振动越大
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.avatarImageView.transform = CGAffineTransform(translationX: 0, y: -(UIScreen.main.bounds.size.height-150-90)/2)
        }) { (_) in
            let window = UIApplication.shared.delegate?.window!
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
    }


}
