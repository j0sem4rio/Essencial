//
//  DetailViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/25/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var progressiveness: CGFloat = 0.0
    var lastTranslation: CGFloat = 0.0
    var lastHeaderHeight: CGFloat = 0.0
    let animationLength = 0.37
    var currentSeasonArray = [Seasons]()
    var minimumHeight: CGFloat {
        return navigationController!.navigationBar.bounds.size.height + statusBarHeight()
    }
    var maximumHeight: CGFloat {
        return view.bounds.height/1.6
    }
    
    @IBOutlet var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView?
    @IBOutlet var blurView: UIVisualEffectView!
//    @IBOutlet var gradientViews: [GradientView]!
    @IBOutlet var backgroundImageView: UIImageView!
//    @IBOutlet var castButton: CastIconBarButtonItem!
    @IBOutlet var showTitleLabel: UILabel!
//    @IBOutlet var showRatingView: FloatRatingView!
    @IBOutlet var showDescriptionView: UITextView!
    @IBOutlet var showInfoLabel: UILabel!
    @IBOutlet var tableHeaderView: UIView!
    var episodes: [Episodes]?
    
    var currentItem: Watched!

    enum ScrollDirection {
        case down
        case up
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerHeightConstraint.constant = maximumHeight
//        let adjustForTabbarInsets = UIEdgeInsetsMake(0, 0, tabBarController!.tabBar.frame.height, 0)
//        tableView!.contentInset = adjustForTabbarInsets
//        tableView!.scrollIndicatorInsets = adjustForTabbarInsets
        tableView!.rowHeight = UITableViewAutomaticDimension
        if let movie = currentItem.movie {
            navigationItem.title = movie.title
            showTitleLabel.text = movie.title
            showInfoLabel.text = "\(movie.year)"
            showDescriptionView.text = movie.synopsis
            backgroundImageView.image = movie.poster.image
        } else {
            navigationItem.title = currentItem.show.title
            showTitleLabel.text = currentItem.show.title
            showInfoLabel.text = "\(currentItem.show.year)"
            showDescriptionView.text = currentItem.show.synopsis
            backgroundImageView.image = currentItem.show.poster.image
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let show = currentItem.show {
            currentSeasonArray = show.seasons
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentSeasonArray.isEmpty {
            return currentSeasonArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowDetailTableViewCell.identifier, for: indexPath) as? ShowDetailTableViewCell
        cell?.titleLabel.text = "\(currentSeasonArray[indexPath.row].number)"
        return (cell)!
    }
    
}
