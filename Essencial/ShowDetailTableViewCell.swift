//
//  ShowDetailTableViewCell.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/25/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class ShowDetailTableViewCell: UITableViewCell {
    class var identifier: String { return String.className(self) }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var watchedButton: UIButton!

}
