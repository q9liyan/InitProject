//
//  HomeViewModel.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    var viewItems = [HomeViewModelItem]()
    override init() {
        super.init()
        var viewImagePaths = [[String]]()
        for _ in 0...5 {
            let imagePaths = ["http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg",
                              "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114171645011.jpg",
                              "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114172009707.png"]
            
        }
        let homeLiveViewItem = HomeLiveViewModelItem(imagePaths: viewImagePaths[0], titles: [""])
        viewItems.append(homeLiveViewItem)
        
        let homeDiscountCourseItem = HomeDiscountViewModelItem(imagePaths: viewImagePaths[1], titles: [""])
        viewItems.append(homeDiscountCourseItem)
        
        let homeGuessCourseItem = HomeGeussViewModelItem(imagePaths:  viewImagePaths[2], titles: [""])
        viewItems.append(homeGuessCourseItem)
        
        let homeTeacherItem = HomeTeacherViewModelItem(imagePaths: viewImagePaths[3], titles: [""])
        viewItems.append(homeTeacherItem)
        
        let homeCommonViewItem = HomeCommonViewModelItem(imagePaths: viewImagePaths[0], titles: [""])
        viewItems.append(homeCommonViewItem)
        
        let homeExerciseViewItem = HomeExerciseViewModelItem(imagePaths: viewImagePaths[0], titles: [""])
        viewItems.append(homeExerciseViewItem)
    }
}

extension HomeViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewItems.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewItems[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewItems[indexPath.section]
        switch item.type {
        case .live:
            if let homeLiveCell = tableView.dequeueReusableCell(withIdentifier: HomeLiveCourseCell.reuseIdentifier(), for: indexPath) as? HomeLiveCourseCell {
                return homeLiveCell
            }
            break
        case .discount:
            if let homeDiscountCell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCourseCell.reuseIdentifier(), for: indexPath) as? HomeDiscountCourseCell {
                return homeDiscountCell
            }
            break
        case .exercise:
            if let homeDiscountCell = tableView.dequeueReusableCell(withIdentifier: HomeExerciseCell.reuseIdentifier(), for: indexPath) as? HomeExerciseCell {
                return homeDiscountCell
            }
            break
        case .guessCourse:
            if let homeGuessCell = tableView.dequeueReusableCell(withIdentifier: HomeGuessCourseCell.reuseIdentifier(), for: indexPath) as? HomeGuessCourseCell {
                return homeGuessCell
            }
            break
        case .teacher:
            if let homeTeacherCell = tableView.dequeueReusableCell(withIdentifier: HomeTeacherCell.reuseIdentifier(), for: indexPath) as? HomeTeacherCell {
                return homeTeacherCell
            }
            break
        case .common:
            if let homeCommonCell = tableView.dequeueReusableCell(withIdentifier: HomeCommonBannerCell.reuseIdentifier(), for: indexPath) as? HomeCommonBannerCell  {
                homeCommonCell.configureModel(modelItem: item)
                return homeCommonCell
            }
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
}


