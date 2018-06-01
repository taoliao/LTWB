//
//  HomeViewController.swift
//  LTWB
//
//  Created by corepress on 2018/5/18.
//  Copyright © 2018年 corepress. All rights reserved.
//

import UIKit

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






