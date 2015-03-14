//
//  ALNDecibelChartView.swift
//  HeartRate
//
//  Created by AlienLi on 15/3/13.
//  Copyright (c) 2015年 ALN. All rights reserved.
//

import UIKit

class ALNDecibelChartView: UIView {
    
    var Horizontal_Sec_Label_0 : UILabel?
    var Horizontal_Sec_Label_15 : UILabel?
    var Horizontal_Sec_Label_30 : UILabel?
    
    var vertical_label_left: UILabel?
    var vertical_label_right: UILabel?
    
    let verticalLabelMargin:CGFloat = 5
    
    let DecivelMaxLimit: CGFloat = 100
    
    var decebel: CGFloat = 0.0 {
        willSet {
            if newValue > DecivelMaxLimit {
                self.decebel = DecivelMaxLimit
            } else {
                self.decebel = newValue
            }
            
            
            self.seconds = seconds + 1
            
            if self.seconds > 30 {
                self.seconds = 0
                self.inputDecibelDatas = [(self.decebel,0)]
            } else {
                let temp = (self.decebel, self.seconds)
                self.inputDecibelDatas.append(temp)
                //                println(self.inputDecibelDatas)
            }
        }
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var seconds: Int = 0
    
    var inputDecibelDatas:[(CGFloat,Int)] = [(0,0)]
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureVerzontalLabels() {
        
        if let lb = self.vertical_label_left {
            
        } else {
            
            for index in 0..<6 {
                
                self.vertical_label_left = UILabel(frame: CGRectMake(0,CGFloat(index) * (self.bounds.height / 8) + self.bounds.height / 8 - self.bounds.height / 16 , self.bounds.width / 12 - verticalLabelMargin, self.bounds.height / 16))
                
                vertical_label_left!.textAlignment = NSTextAlignment.Right
                vertical_label_left!.textColor = UIColor.whiteColor()
                
                vertical_label_left!.text = "\(100 - 20 * (index ))"
                vertical_label_left!.font = UIFont.systemFontOfSize(12.0)
                
                self.addSubview(vertical_label_left!)
            }
            
        }
        
        if let lb = self.vertical_label_right {
            
        } else {
            
            for index in 0..<6 {
                
                self.vertical_label_right = UILabel(frame: CGRectMake(self.bounds.width * 11 / 12 + verticalLabelMargin,CGFloat(index) * (self.bounds.height / 8) + self.bounds.height / 8  - self.bounds.height / 16, self.bounds.width / 12 - verticalLabelMargin, self.bounds.height / 16))
                
                vertical_label_right!.textAlignment = NSTextAlignment.Left
                vertical_label_right!.textColor = UIColor.whiteColor()
                
                vertical_label_right!.text = "\(100 - 20 * (index ))"
                vertical_label_right!.font = UIFont.systemFontOfSize(12.0)
                
                self.addSubview(vertical_label_right!)
            }
            
        }
        
    }
    
    
    
    func configureHorizontalLabels() {
        
        if let label0 = Horizontal_Sec_Label_0 {
            
        } else {
            
            Horizontal_Sec_Label_0 = UILabel(frame: CGRectMake(self.bounds.width / 12, self.bounds.height / 8 * 6, self.bounds.width / 10, 20))
            Horizontal_Sec_Label_0!.textAlignment = NSTextAlignment.Left
            Horizontal_Sec_Label_0!.textColor = UIColor.whiteColor()
            
            Horizontal_Sec_Label_0!.text = "0sec"
            Horizontal_Sec_Label_0!.font = UIFont.systemFontOfSize(12.0)
            
            self.addSubview(Horizontal_Sec_Label_0!)
        }
        
        if let label1 = Horizontal_Sec_Label_15 {
            
        } else {
            Horizontal_Sec_Label_15 = UILabel(frame: CGRectMake((self.bounds.width / 2 - self.bounds.width / 18), self.bounds.height / 8 * 6, self.bounds.width / 9, 20))
            Horizontal_Sec_Label_15!.textColor = UIColor.whiteColor()
            Horizontal_Sec_Label_15!.textAlignment = NSTextAlignment.Center
            
            Horizontal_Sec_Label_15!.text = "15sec"
            Horizontal_Sec_Label_15!.font = UIFont.systemFontOfSize(12.0)
            
            self.addSubview(Horizontal_Sec_Label_15!)
        }
        
        if let label2 = Horizontal_Sec_Label_30 {
            
        } else {
            Horizontal_Sec_Label_30 = UILabel(frame: CGRectMake((self.bounds.width - self.bounds.width / 12 - self.bounds.width / 9), self.bounds.height / 8 * 6, self.bounds.width / 9, 20))
            Horizontal_Sec_Label_30!.textColor = UIColor.whiteColor()
            Horizontal_Sec_Label_30!.textAlignment = NSTextAlignment.Left
            
            Horizontal_Sec_Label_30!.text = "30sec"
            Horizontal_Sec_Label_30!.font = UIFont.systemFontOfSize(12.0)
            
            self.addSubview(Horizontal_Sec_Label_30!)
        }
        
        
        
        
    }
    
    
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        
        drawChart(rect)
        
        drawDecibelLines(rect)
        
    }
    
    func drawDecibelLines(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath()
        path.lineWidth = 2.0
        UIColor.whiteColor().setStroke()
        
        let widthMargin = rect.width / 12
        
        let heightMargin = rect.height / 8
        
        
        if inputDecibelDatas.count > 1 {
            
            let db = inputDecibelDatas[0].0
            let sec = inputDecibelDatas[0].1
            path.moveToPoint(CGPointMake(convertSecondsToChart_x(sec, inThe: rect), convertDecebelToInChart_y(db, inThe: rect) ))
            
            for (index, temp) in enumerate(inputDecibelDatas) {
                
                let tempDB = inputDecibelDatas[index].0
                let tempSec = inputDecibelDatas[index].1
                if index != 0 {
                    path.addLineToPoint(CGPointMake(convertSecondsToChart_x(tempSec, inThe: rect), convertDecebelToInChart_y(tempDB, inThe: rect) ))
                }
            }
            
            
            path.stroke()
        }
        
        
        
    }
    
    
    func convertSecondsToChart_x(second: Int, inThe rect: CGRect) -> CGFloat {
        let w = rect.width / 12
        return w + CGFloat(second) * w * 10 / 30
    }
    
    func convertDecebelToInChart_y(db: CGFloat, inThe rect: CGRect) -> CGFloat {
        
        let h = rect.height / 8
        var hh =  6 * h - db * ((rect.height - 2 * h) / DecivelMaxLimit)
        
        return hh
    }
    
    
    
    func drawChart(rect: CGRect) {
        
        let widthMargin = rect.width / 12
        
        let heightMargin = rect.height / 8
        
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath()
        path.lineWidth = 1.0
        UIColor.whiteColor().setStroke()
        
        for index in 1..<7 {
            
            path.moveToPoint(CGPointMake(widthMargin , CGFloat(index) * heightMargin))
            
            path.addLineToPoint(CGPointMake(rect.width - widthMargin, CGFloat(index) * heightMargin))
        }
        
        for index in 1..<12 {
            path.moveToPoint(CGPointMake(CGFloat(index) * widthMargin , heightMargin))
            
            path.addLineToPoint(CGPointMake(CGFloat(index) * widthMargin,rect.height - heightMargin * 2))
        }
        
        path.stroke()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureVerzontalLabels()
        configureHorizontalLabels()
    }
}
