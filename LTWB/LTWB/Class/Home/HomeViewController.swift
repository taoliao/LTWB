//
//  HomeViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: BaseTableViewController {
    
    static let homeCellD = "homeCell"
    
    lazy var statusesViewModels : [StatusesViewModel] = [StatusesViewModel]()
    
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
        loadStatuses()
    }
    
}

//MARK:设置UI
extension HomeViewController {
    
    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300;
        self.tableView.register(UINib(nibName: "TLHomeViewCell", bundle: nil), forCellReuseIdentifier: HomeViewController.homeCellD)

    }
    
    private func setTitleView() {
        titleBtn.setTitle(TLUserAcountViewModel.shareInstance.userAcount?.screen_name, for: .normal)
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(titleBtnClick(titleBtn:)), for: .touchUpInside)
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

}

//MARK:请求首页数据
extension HomeViewController {
    
    func loadStatuses() {
        
        TLNetWorkTools.shared.loadStatuses { (statuses, error) in
            
            guard let statuses = statuses else {
                return
            }
            for item in statuses {
                let status = Statuses(dict: item)
                let viewModel = StatusesViewModel(status: status)
                self.statusesViewModels.append(viewModel)
            }

            self.cashImageData(viewModels: self.statusesViewModels)
//            self.tableView.reloadData()

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
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//         return 300
//    }
}






