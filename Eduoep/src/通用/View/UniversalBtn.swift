//
//  UniversalBtn.swift
//  
//
//  Created by xxsskk on 2019/11/25.
//

import UIKit


//@IBDesignable
@objc class UniversalBtn: UIButton {
    
    var useForMain:Bool{
        willSet{
            if newValue {
                configForMain()
            }else{
                configForOther()
            }
        }
    }
    
    override init(frame: CGRect) {
        useForMain = true
        super.init(frame: frame)
        configForMain()
    }
    required init?(coder: NSCoder) {
        useForMain = true
        super.init(coder: coder)
        configForMain()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        corner = self.h / 2.0
    }
    //页面主按钮配置
    @objc func configForMain(){
        setBackgroundImage(gradientBgColor(color1: Color("#EF91E9"),color2: Color("#FF5BA3")),for: .normal)
//        setBackgroundImage(gradientBgColor(color1: Color("#B960D1"),color2: Color("#8D1AE5")),for: .highlighted)
        setBackgroundImage(gradientBgColor(color1: Color("#D9D9D9"),color2: Color("#D9D9D9")),for: .disabled)
        font("16")
        color("white")
        highColor("white")
        setTitleColor(Color("white"),for: .disabled)
    }
    //页面次要按钮配置
    @objc func configForOther(){
        setBackgroundImage(gradientBgColor(color1: Color("#F1F1F1"),color2: Color("#F1F1F1")),for: .normal)
        let highlight = UIColor.black.withAlphaComponent(0.1)
//        setBackgroundImage(gradientBgColor(color1: highlight,color2: highlight),for: .highlighted)
        self.setBackgroundImage(gradientBgColor(color1: Color("#D9D9D9"),color2: Color("#D9D9D9")),for: .disabled)
        font("16")
        color("#333333")
        highColor("#333333")
//        self.setTitleColor(Color("#999999"),for: .disabled)
        borderWidth = 0;
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        if useForMain {
            configForMain()
        }else{
            configForOther()
        }
    }
    
    
    /*
     Only override draw() if you perform custom drawing.
     An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
         Drawing code
    }
    */
    private func gradientBgColor(color1:UIColor!,color2:UIColor!) -> UIImage{
        let v = UIView.init(frame: CGRect.init(x: 0,y: 0,width: ScreenWidth - 64,height: self.h))
        
        // 背景渐变
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0,y: 0,width: ScreenWidth - 64,height: self.h)
        //设置渐变颜色方向
        gradient.startPoint = CGPoint.init(x: 0,y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1,y: 0.5)

        //设定颜色组
        gradient.colors = [color1.cgColor,color2.cgColor]
        
        gradient.locations = [NSNumber.init(value: 0.0),NSNumber.init(value: 1.0)];
        
        v.layer.insertSublayer(gradient,at: 0)
        

        
        UIGraphicsBeginImageContext(v.bounds.size)
        v.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imgae = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imgae!
    }
    
    @objc class func gradientBgColor(color1:UIColor!,color2:UIColor! ,width:CGFloat,height:CGFloat ,alph:CGFloat) -> UIImage{
        let v = UIView.init(frame: CGRect.init(x: 0,y: 0,width: width,height: height))
        
        // 背景渐变
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0,y: 0,width: width,height: height)
        //设置渐变颜色方向
        gradient.startPoint = CGPoint.init(x: 0,y: 0)
        gradient.endPoint = CGPoint.init(x: 1,y: 1)

        //设定颜色组
        gradient.colors = [color1.withAlphaComponent(alph).cgColor,color2.withAlphaComponent(alph).cgColor]
        
        gradient.locations = [NSNumber.init(value: 0.0),NSNumber.init(value: 1.0)];
        
        v.layer.insertSublayer(gradient,at: 0)
        
        
        UIGraphicsBeginImageContext(v.bounds.size)
        v.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imgae = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imgae!
    }

    @objc func ConfigForEndLiveBack(){
        self.setBackgroundImage(gradientBgColor(color1: Color("157,29,254,0.2"),color2: Color("157,29,254,0.2")),for: .normal)
        self.setBackgroundImage(gradientBgColor(color1: Color("157,29,254,0.2"),color2: Color("157,29,254,0.2")),for: .highlighted)
        self.setBackgroundImage(gradientBgColor(color1: Color("157,29,254,0.2"),color2: Color("157,29,254,0.2")),for: .disabled)
        self.font("16")
        self.color("#9D1DFE")
        self.highColor("#9D1DFE")
        self.setTitleColor(Color("#9D1DFE"),for: .disabled)
        self.borderColor = Color("#9D1DFE");
        self.borderWidth = 1;
    }
    
    @objc func ConfigForEndLiveFollow(){
        self.setBackgroundImage(gradientBgColor(color1: Color("157,29,254,0.2"),color2: Color("157,29,254,0.2")),for: .normal)
        self.setBackgroundImage(gradientBgColor(color1: Color("157,29,254,0.2"),color2: Color("157,29,254,0.2")),for: .highlighted)
        self.setBackgroundImage(gradientBgColor(color1: Color("157,29,254,0.2"),color2: Color("157,29,254,0.2")),for: .disabled)
        self.font("16")
        self.color("#9D1DFE")
        self.highColor("#9D1DFE")
        self.setTitleColor(Color("#9D1DFE"),for: .disabled)
        self.borderColor = Color("#9D1DFE");
        self.borderWidth = 1;
    }
        
}
