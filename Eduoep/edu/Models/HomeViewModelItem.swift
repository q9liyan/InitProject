//
//  HomeViewModelItem.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

enum HomeViewModelItemType {
    case banner
    case common
    case live
    case discount
    case guessCourse
    case teacher
    case exercise
}

protocol HomeViewModelItem {
    var type: HomeViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    var rowHeight: CGFloat { get }
}


/// 广告bannerItem
class BannerViewModelItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .banner
    }
    
    var sectionTitle: String {
        return "banner"
    }
    
    var rowHeight: CGFloat {
        return 180
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    
    var imageNames: [String]
    var urls: [String]
    
    init(imageNames: [String],urls: [String]) {
        self.imageNames = imageNames
        self.urls = urls
    }
}

class HomeCommonViewModelItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .common
    }
    
    var sectionTitle: String {
        return "banner"
    }
    
    var rowHeight: CGFloat {
        return 180
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    
    var imagePaths: [String]
    var titles: [String]
    
    init(imagePaths: [String],titles: [String]) {
        self.imagePaths = imagePaths
        self.titles = titles
    }
}

class HomeGeussViewModelItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .guessCourse
    }
    
    var sectionTitle: String {
        return "banner"
    }
    
    var rowHeight: CGFloat {
        return 180
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    
    var imagePaths: [String]
    var titles: [String]
    
    init(imagePaths: [String],titles: [String]) {
        self.imagePaths = imagePaths
        self.titles = titles
    }
}

class HomeExerciseViewModelItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .exercise
    }
    
    var sectionTitle: String {
        return "banner"
    }
    
    var rowHeight: CGFloat {
        return 180
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    
    var imagePaths: [String]
    var titles: [String]
    
    init(imagePaths: [String],titles: [String]) {
        self.imagePaths = imagePaths
        self.titles = titles
    }
}

class HomeDiscountViewModelItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .discount
    }
    
    var sectionTitle: String {
        return "banner"
    }
    
    var rowHeight: CGFloat {
        return 180
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    
    var imagePaths: [String]
    var titles: [String]
    
    init(imagePaths: [String],titles: [String]) {
        self.imagePaths = imagePaths
        self.titles = titles
    }
}

class HomeTeacherViewModelItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .teacher
    }
    
    var sectionTitle: String {
        return "banner"
    }
    
    var rowHeight: CGFloat {
        return 180
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    
    var imagePaths: [String]
    var titles: [String]
    
    init(imagePaths: [String],titles: [String]) {
        self.imagePaths = imagePaths
        self.titles = titles
    }
}

class HomeLiveViewModelItem: HomeViewModelItem {
    var type: HomeViewModelItemType {
        return .live
    }
    
    var sectionTitle: String {
        return "banner"
    }
    
    var rowHeight: CGFloat {
        return 180
    }
    
    var rowCount: Int {
        return 1
    }
    
    
    
    var imagePaths: [String]
    var titles: [String]
    
    init(imagePaths: [String],titles: [String]) {
        self.imagePaths = imagePaths
        self.titles = titles
    }
}


