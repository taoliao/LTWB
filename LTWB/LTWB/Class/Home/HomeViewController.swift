//
//  HomeViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
import SVProgressHUD

class HomeViewController: BaseTableViewController {
    
    static let homeCellD = "homeCell"
    lazy var statusesViewModels : [StatusesViewModel] = [StatusesViewModel]()
    lazy var newWeiboView : UIView = UIView(frame: CGRect(x: 0.0, y: IPHONE_NAVIGATIONBAR_HEIGHT-30.0, width: Double(UIScreen.main.bounds.width), height: 30.0))
    lazy var newWeiboLable = UILabel(frame: newWeiboView.bounds)
    
    private lazy var titleBtn = TitleButton()
    private lazy var popoverAnimtor = PopoverAnimatior { (presented) in
        self.titleBtn.isSelected = presented
    }
    //MARK:系统调用
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView.addRotationAnim()
        //登录之后的设置
        if !isLogIn {
            return
        }
        setNavigationItem()
        setTitleView()
        setUpTableViewHead()
        setUpNewWeiboView()
        
        //监听图片点击的通知
        NotificationCenter.default.addObserver(self, selector: #selector(pictureClickNoti(noti:)), name: NSNotification.Name(rawValue: PictureClickNoti), object: nil)
        
    }
    
}

//MARK:设置UI
extension HomeViewController {
    
    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        self.tableView.separatorStyle = .none
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        //估算行高
        self.tableView.estimatedRowHeight = 300
        self.tableView.register(UINib(nibName: "TLHomeViewCell", bundle: nil), forCellReuseIdentifier: HomeViewController.homeCellD)

    }
    
    private func setTitleView() {
        titleBtn.setTitle(TLUserAcountViewModel.shareInstance.userAcount?.screen_name, for: .normal)
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(titleBtnClick(titleBtn:)), for: .touchUpInside)
    }
    
    private func setUpTableViewHead() {
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headRefresh))
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("释放更新", for: .pulling)
        header?.setTitle("加载中..", for: .refreshing)
        tableView.mj_header = header
        header?.beginRefreshing()
        
        let footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        tableView.mj_footer = footer
    }
    
    private func setUpNewWeiboView() {
        let color = UIColor.orange.withAlphaComponent(0.8)
        newWeiboView.backgroundColor = color
        self.newWeiboView.isHidden = true
        self.navigationController?.view.insertSubview(newWeiboView, belowSubview: (self.navigationController?.navigationBar)!)
        
        newWeiboLable.textColor = UIColor.white
        newWeiboLable.textAlignment = .center
        newWeiboLable.font = UIFont.systemFont(ofSize: 15.0)
        newWeiboView.addSubview(newWeiboLable)
    }
    
    
}
//MARK: 事件监听
extension HomeViewController {
    
    @objc private func titleBtnClick(titleBtn : TitleButton) {
        titleBtn.isSelected = !titleBtn.isSelected
        
        let popVC = PopoverViewController()
        //modalPresentationStyle=.custom modal出来之后 之前的视图不会消失
        popVC.modalPresentationStyle = .custom
        popVC.transitioningDelegate = popoverAnimtor
        popoverAnimtor.presentedViewFrame = CGRect(x: 100, y: 55, width: 180, height: 250)
        present(popVC, animated: true, completion: nil)
        
    }
    //上拉刷新
    @objc private func headRefresh() {
        let lastModel = statusesViewModels.first
        let since_id = lastModel?.statuses?.mid ?? 0
        loadStatuses(since_id : since_id,max_id: 0,isheadRefresh: true)
    }
     //下拉加载
    @objc private func footerRefresh() {
        guard let firstModel = statusesViewModels.last else {
            return
        }
        let max_id = (firstModel.statuses?.mid)! > 0 ? (firstModel.statuses?.mid)! - 1 : 0
        loadStatuses(since_id: 0, max_id: max_id,isheadRefresh: false)
    }
    
     @objc private func showNewWeiBoView() {
        self.newWeiboView.isHidden = false
        UIView.animate(withDuration: 1.5, animations: {
             self.newWeiboView.frame.origin.y = CGFloat(IPHONE_NAVIGATIONBAR_HEIGHT)
        }) { (_) in
        }
    }
    @objc private func hideNewWeiBoView() {
        UIView.animate(withDuration: 1.5, animations: {
             self.newWeiboView.frame.origin.y = CGFloat(IPHONE_NAVIGATIONBAR_HEIGHT-30.0)
        }) { (_) in
            self.newWeiboView.isHidden = true
        }
    }
    
    @objc private func pictureClickNoti(noti : Notification) {
        
        let indexPatch = noti.userInfo![PictureIndexPatch] as! IndexPath
        
        let imageURLS = noti.userInfo![ImageUrlKey] as! [URL]
        
        let photoBorwser = TLPhotoBrowserController(indexPatch: indexPatch, image_urls: imageURLS)
        
        self.present(photoBorwser, animated: true, completion: nil)
        
        
    }
}

//MARK:请求首页数据
extension HomeViewController {
    
    func loadStatuses(since_id : Int,max_id: Int,isheadRefresh: Bool) {
        
        TLNetWorkTools.shared.loadStatuses(since_id: since_id, max_id: max_id) { (statuses, error) in
            guard let statuses = statuses else {
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                return
            }
            var tempModes : [StatusesViewModel] = [StatusesViewModel]()
            for item in statuses {
                let status = Statuses(dict: item)
                let viewModel = StatusesViewModel(status: status)
                tempModes.append(viewModel)
            }
            if isheadRefresh {
                 self.statusesViewModels = tempModes + self.statusesViewModels
                if tempModes.count > 0 {
                    self.newWeiboLable.text = "更新了\(tempModes.count)条微博"
                    self.showNewWeiBoView()
                }
            }else {
                 self.statusesViewModels = self.statusesViewModels + tempModes
            }

            //缓存图片
            self.cashImageData(viewModels: self.statusesViewModels)
        }
        
    }
    
    //缓存图片
    func cashImageData(viewModels : [StatusesViewModel]) {
        let group = DispatchGroup()
        for viewModel in viewModels {
            for picture_url in viewModel.imageURLS {
                //将当前的下载操作添加到组中
                group.enter()
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: picture_url, options: [], progress: nil, completed: { (image, _, _, _) in
                    //缓存到磁盘
                     SDWebImageManager.shared().imageCache?.store(image, forKey: picture_url.absoluteString, toDisk: true, completion: nil)
                    //离开当前组
                     group.leave()
                })
            }
        }
        //在这里告诉调用者,下完完毕,执行下一步操作
        group.notify(queue: DispatchQueue.main) {
             self.tableView.reloadData()
             self.tableView.mj_header.endRefreshing()
             self.tableView.mj_footer.endRefreshing()
             self.perform(#selector(self.hideNewWeiBoView), with: nil, afterDelay: 1.5)
        }
    }
    
}

//MARK: tableViewDelegate
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusesViewModels.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.homeCellD) as! TLHomeViewCell
         cell.viewModel = statusesViewModels[indexPath.row]
         return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = statusesViewModels[indexPath.row]
        return viewModel.cellHeight
    }
}






