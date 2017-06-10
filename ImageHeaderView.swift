//
//  ImageHeaderView.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/6/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class ImageHeaderView: UIView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textEmail: UILabel!
    @IBOutlet weak var textName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        //        self.profileImage.setRandomDownloadImage(80, height: 80)
    }
}
