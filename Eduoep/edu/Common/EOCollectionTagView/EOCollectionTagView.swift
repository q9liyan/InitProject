//
//  EOCollectionTagView.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//



import UIKit

class EOCollectionTagView: UIView {
    var sectionItems = [EOCollectionTagModel]()
    var collectionView: UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.delegate = self
        collectionView?.dataSource = self
  
        addSubview(collectionView!)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(EOCollectionTagCell.classForCoder(), forCellWithReuseIdentifier: EOCollectionTagCell.reuseIdentifier)
        collectionView?.register(EOTagHeaderCell.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EOTagHeaderCell.reuseIdentifier)
        
    }
    
    func configuerModels(models: [EOCollectionTagModel]) {
        sectionItems = models
        collectionView?.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension EOCollectionTagView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionItem = sectionItems[section]
        return sectionItem.itemTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EOCollectionTagCell.reuseIdentifier, for: indexPath) as? EOCollectionTagCell
        let itemsObject = sectionItems[indexPath.section]
        let title = itemsObject.itemTitles[indexPath.row]
        cell?.titleLabel.text = title
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView: EOTagHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EOTagHeaderCell.reuseIdentifier, for: indexPath as IndexPath) as! EOTagHeaderCell
            
            //headerView.backgroundColor = UIColor.lightGray
            
            let itemsObject = sectionItems[indexPath.section]
            let title: String = itemsObject.sectionTitle
            headerView.titleLabel.text = title
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let itemsObject: [String: Any] = listItems[indexPath.section] as! [String: Any]
    //        let items: Array<Any> = itemsObject["list"] as! Array<Any>
    //        let name: String = items[indexPath.row] as! String
    //
    //        let size: CGSize = name.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)])
    //
    //        let sizeNew: CGSize = CGSize.init(width:((size.width  > collectionView.frame.size.width) ? collectionView.frame.size.width - 20 : size.width), height: size.height)
    //
    //        return sizeNew
    //    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3.6, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.size.width, height: 50)
      }
    
}
