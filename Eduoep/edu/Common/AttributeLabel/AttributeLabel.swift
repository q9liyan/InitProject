//
//  AttributeLabel.swift
//  MacroCaster
//
//  Created by sunshine.lee on 2018/3/27.
//  Copyright © 2018年 Bok Man. All rights reserved.
//

import UIKit


class AttributeLabel: UIView {
    
    // MARK: 属性
    weak var delegate:AttributeLabelProtocol?
    
    var actionBlock:((String)->())?
    
    // MARK: 懒加载
    fileprivate lazy var textView:UITextView = {
        let view = UITextView()
        view.delegate = self
        view.isEditable = false
        view.isScrollEnabled = false
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    // MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAttributeLabel()
        layoutConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 私有方法
    fileprivate func setupAttributeLabel() {
        addSubview(textView)
    }
    
    fileprivate func layoutConstraint() {
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges).inset(UIEdgeInsets.zero)
        }
    }
    
    @objc public func setActionBlock(_ block:((String)->())?) {
        actionBlock = block
    }
    
    @objc public func contentSizeToFit(size:CGSize) -> CGSize {
        return textView.sizeThatFits(size)
    }
    // MARK: 公用方法
    @objc public func setContent(_ content:String,withAttributes attrs:[NSAttributedString.Key:Any],withActionAttributes attrs_s:[NSAttributedString.Key:Any] ,withActionTextRange range:NSRange) {
        let attStr = NSMutableAttributedString(string: content)
        
        attStr.addAttributes(attrs, range: NSMakeRange(0, range.location))
        attStr.addAttributes(attrs_s, range: range)
        let len = content.count - (range.location + range.length)
        if len > 0 {
            attStr.addAttributes(attrs, range: NSMakeRange(range.location + range.length, len))
        }
        attStr.addAttribute(NSAttributedString.Key.link, value: "click://", range: range)
        
        var attrs_link:[String:Any] = [String:Any]()
        
        for (key,value) in attrs_s {
            attrs_link.updateValue(value, forKey: key.rawValue)
        }
        
        self.textView.attributedText = attStr
        //self.textView.linkTextAttributes = attrs_link
    }
    
    @objc public func setActionText(_ text:String,attributes:[NSAttributedString.Key:Any]) {
        let attStr = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: text.count)
        attStr.addAttributes(attributes, range: range)
        attStr.addAttribute(NSAttributedString.Key.link, value: "click://", range: range)
        var attrs_link:[String:Any] = [String:Any]()
        for (key,value) in attributes {
            attrs_link.updateValue(value, forKey: key.rawValue)
        }
        
        self.textView.attributedText = attStr
        //self.textView.linkTextAttributes = attrs_link
    }
    
    @objc public func clearContent() {
        self.textView.attributedText = nil
        self.textView.text = nil
    }
}

extension AttributeLabel:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if let scheme = URL.scheme, scheme == "click" {
            let attStr = textView.attributedText.attributedSubstring(from: characterRange)
            delegate?.attributeLabel(self, clickActionString: attStr)
            actionBlock?(attStr.string)
        }
        
        return false
    }
}

protocol AttributeLabelProtocol:NSObjectProtocol {
    func attributeLabel(_ label:AttributeLabel,clickActionString string:NSAttributedString)
}
