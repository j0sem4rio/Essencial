//
//  BaseTableViewCell.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/6/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    class var identifier: String { return String.className(self) }
    var img = UIImageView()
    var label = UILabel()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    open override func awakeFromNib() {
    }
    
    open func setup() {
        
        var newFrameForLabel: CGRect = (self.frame)
        newFrameForLabel.size.height = self.frame.height*0.5
        newFrameForLabel.size.width = self.frame.width*0.8
        
        label.frame = newFrameForLabel
        label.textColor = UIColor.black
        label.font = UIFont(name: "Avenir", size: 15)
        
        var newFrameForImage: CGRect = (self.frame)
        newFrameForImage.size.height = self.frame.height*0.8
        newFrameForImage.size.width = self.frame.height*0.8
        img = UIImageView(frame: newFrameForImage)
        
        self.contentView.addSubview(img)
        self.contentView.addSubview(label)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        img.translatesAutoresizingMaskIntoConstraints = false
        
        //Vertical Constraints
        let verticalConstraintImg = NSLayoutConstraint(item: img,
                                                       attribute: NSLayoutAttribute.centerY,
                                                       relatedBy: NSLayoutRelation.equal,
                                                       toItem: self.contentView,
                                                       attribute: NSLayoutAttribute.centerY,
                                                       multiplier: 1,
                                                       constant: 0)
        let verticalConstraintLabel = NSLayoutConstraint(item: label,
                                                         attribute: NSLayoutAttribute.centerY,
                                                         relatedBy: NSLayoutRelation.equal,
                                                         toItem: self.contentView,
                                                         attribute: NSLayoutAttribute.centerY,
                                                         multiplier: 1,
                                                         constant: 0)
        
        //Height and Width Constraints
        let widthConstraint = NSLayoutConstraint(item: img,
                                                 attribute: NSLayoutAttribute.width,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: self.contentView,
                                                 attribute: NSLayoutAttribute.height,
                                                 multiplier: 0.4,
                                                 constant: 0)
        let heightConstraint = NSLayoutConstraint(item: img,
                                                  attribute: NSLayoutAttribute.height,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: self.contentView,
                                                  attribute: NSLayoutAttribute.height,
                                                  multiplier: 0.4,
                                                  constant: 0)
        
        //Visual Constraints
        let views = ["image": img, "label": label] as [String : Any]
        
        let imageLabelConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[image]-15-[label]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        self.contentView.addConstraints(imageLabelConstraints)
        self.contentView.addConstraint(widthConstraint)
        self.contentView.addConstraint(heightConstraint)
        self.contentView.addConstraint(verticalConstraintImg)
        self.contentView.addConstraint(verticalConstraintLabel)
    }
    
    open class func height() -> CGFloat {
        return 40
    }
    
    open func setData(_ data: Any?) {
        
        self.backgroundColor = UIColor.white
        //        label.font = UIFont.italicSystemFontOfSize(18)
        //        label.textColor = UIColor(hex: "9E9E9E")
        if let menuText = data as? String {
            label.text = menuText
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override open func setSelected(_ selected: Bool, animated: Bool) {
    }
    
}
