//
//  TLComposeViewController.swift
//  LTWB
//
//  Created by corepress on 2018/6/6.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

class TLComposeViewController: UIViewController {

    @IBOutlet weak var picPickCollection: TLPicPickerCollection!
    @IBOutlet weak var boomScro: UIScrollView!
    @IBOutlet weak var textView: TLComposeTextView!
    @IBOutlet weak var PicPickerViewHCons: NSLayoutConstraint!
    private lazy var boomView : TLComposeTabbar = TLComposeTabbar(image_names: ["图片","@","话题","表情"])
    private lazy var titleView : TLComPoseTitleView = TLComPoseTitleView()
    
    private lazy var images : [UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        boomScro.delegate = self
        //监听通知
        addNoti()
    }
}

//MARK:设置UI
extension TLComposeViewController {
    
    private func setUpNavigationBar() {
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(goback))
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(compose))
         self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        navigationItem.titleView = titleView
    
        boomView.delegate_cmp = self
        self.view.addSubview(boomView)
        
    }
    
}

//MARK:事件监听
extension TLComposeViewController: ComposeTabbarDelegate {
    
   @objc private func goback() {
       dismiss(animated: true, completion: nil)
    }
    
    @objc private func compose() {
        print(#function)
    }
    
    @objc private func keyboardWillChangeFrame(noti : NSNotification) {
        let animationDuration = noti.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! TimeInterval
        let keyboardFrame = (((noti.userInfo!["UIKeyboardFrameEndUserInfoKey"]) as! NSValue).cgRectValue).origin.y
        UIView.animate(withDuration: animationDuration) {
            self.boomView.frame.origin.y = keyboardFrame-49
        }
        
    }
    //添加通知
    @objc private func addNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame(noti:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(picPickerBtnClickNoti), name: NSNotification.Name(rawValue: PICPICKERBTNCLICKNOTI), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(picPickerDeleteNoti(noti:)), name: NSNotification.Name(rawValue: PICPICKERDELETEBTNCLICKNOTI), object: nil)
    }
    
    //弹出系统照片
    @objc private func picPickerBtnClickNoti() {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
      
        let ipc = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
    }
    //删除照片
    @objc private func picPickerDeleteNoti(noti : Notification) {
        guard let image = noti.object else {
            return
        }
        guard let index = images.index(of: image as! UIImage) else {
            return
        }
        images.remove(at: index)
        picPickCollection.imageArr = images
    }
    
    //ComposeTabbarDelegate
    func composeTabbarBtnClick(tag: Int) {
    
        switch tag {
        case 0:  //照片
            textView.resignFirstResponder()
            PicPickerViewHCons.constant = UIScreen.main.bounds.size.height * 0.65
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            })
        default:
            break
            
        }
    
    }
    
}

extension TLComposeViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        images.append(image)
        picPickCollection.imageArr = images
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension TLComposeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.endEditing(true)
    }
}


