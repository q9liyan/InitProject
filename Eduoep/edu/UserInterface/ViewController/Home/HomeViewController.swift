//
//  MainViewController.swift
//  Eduoep
//
//  Created by apple on 2020/6/1.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class HomeViewController: EOBaseViewController {
    let viewModel = HomeViewModel()
    let tableView = UITableView()
    var rxBag = DisposeBag()
    let headerView = HomeHeaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupView()
    }
    
    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = viewModel
        tableView.tableFooterView = UIView()
        tableView.register(HomeCommonBannerCell.classForCoder(), forCellReuseIdentifier: HomeCommonBannerCell.reuseIdentifier())
        view.addSubview(tableView)
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(300)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.viewItems[indexPath.section]
        return  item.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.viewItems[indexPath.section]
     
    }
    
    
}

