//
//  YONoDataView.swift
//  JRLive
//
//  Created by xxsskk on 2019/12/7.
//  Copyright © 2019 xxsskk. All rights reserved.
//

import UIKit
@objc enum JRNoDataType:Int {
    case WrongWithNetWork = 0//网络有问题
    case AttentionOrDistanceLiveListNoData//直播关注或附近无数据
    case HotLiveListNoData//直播热门无数据
    case MyAttentionListNoData//我的关注列表
    case MyFansListNoData//我的粉丝列表
    case TaAttentionListNoData//TA的关注列表
    case TaFansListNoData//TA的粉丝列表
    case BlacksListNoData//黑名单列表
    case MyBillListNoData//我的亲密榜列表无数据
    case OtherBillListNoData//TA的亲密榜列表无数据
    case SearchUserNoData//搜索用户无数据
    case ChatNoData//私信无数据
    case FocusListNoData//推荐关注列表无数据
    case TodayOfInviteDetailNoData//邀请详情今日无数据
    case TotalOfInviteDetailNoData//邀请详情累计无数据
    case IncomeOfGlamourDetailNoData//魅点详情页魅点收入明细无数据
    case ListOfExchangeGlamourNoData//魅点兑换金币记录列表无数据
}
@objc
class YONoDataView: UIView,NibLoadable {
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var tipsLab: UILabel!
    @IBOutlet weak var actionBtn: UniversalBtn!
    typealias ActionColosure = ()->()
    var actionColosure:ActionColosure?
    var noDataType:JRNoDataType = .WrongWithNetWork
    @objc func configUI(_ type:JRNoDataType){
       /*
        switch type {
           
        case .WrongWithNetWork:
            tipsLab.str("网络似乎有问题，请检查一下网络连接")
            actionBtn.str("重新连接")
            logoImgView.img(DefaultNetworkImg)
        case .HotLiveListNoData:
            tipsLab.str("寻寻觅觅，佳人正在梳妆，请稍后~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultLiveImg)
        case .AttentionOrDistanceLiveListNoData:
            tipsLab.str("空空如也，快去热门看看吧~")
            logoImgView.img(DefaultLiveImg)
            actionBtn.str("去看看")
        case .MyAttentionListNoData:
            tipsLab.str("偶遇佳人时，记得关注哦~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultFollowImg)
        case .MyFansListNoData:
            tipsLab.str("还没有粉丝，快去开启直播吧~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultFollowImg)
        case .TaAttentionListNoData:
            tipsLab.str("TA还没有心动的佳人")
            actionBtn.isHidden = true
            logoImgView.img(DefaultFollowImg)
        case .TaFansListNoData:
            tipsLab.str("TA还没有粉丝")
            actionBtn.isHidden = true
            logoImgView.img(DefaultFollowImg)
        case .BlacksListNoData:
            tipsLab.str("您暂时没有把任何人拉入黑名单")
            actionBtn.isHidden = true
            logoImgView.img(DefaultNothingImg)
        case .MyBillListNoData:
//            tipsLab.str("还没有收到礼，快去开播吧~")
            tipsLab.str("还没有收到礼~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultFollowImg)
        case .OtherBillListNoData:
            tipsLab.str("Ta还没有收过礼，当Ta的第一人吧~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultFollowImg)
        case .SearchUserNoData:
            tipsLab.str("没有找到符合搜索条件的用户")
            actionBtn.isHidden = true
            logoImgView.img(DefaultNothingImg)
        case .ChatNoData:
            tipsLab.str("还没有消息哦~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultNothingImg)
        case .FocusListNoData:
            tipsLab.str("无主播可推荐~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultNothingImg)
        case .TodayOfInviteDetailNoData:
            tipsLab.str("今日还没有邀请哦~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultNothingImg)
        case .TotalOfInviteDetailNoData:
            tipsLab.str("还没有邀请哦~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultNothingImg)
        case .IncomeOfGlamourDetailNoData:
            tipsLab.str("还没有魅点收入哦~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultNothingImg)
        case .ListOfExchangeGlamourNoData:
            tipsLab.str("还没有兑换记录哦~")
            actionBtn.isHidden = true
            logoImgView.img(DefaultNothingImg)
        default:
            break
        }
         */
    }
    
    override func awakeFromNib() {
        tipsLab.color("#666666")
        
    }
    @IBAction func clickAcitonBtn(_ sender: Any) {
        if let closure = actionColosure {
            closure()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
