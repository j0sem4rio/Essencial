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
    @IBOutlet var tableView: PCTTableView?
    @IBOutlet var blurView: UIVisualEffectView!
//    @IBOutlet var gradientViews: [GradientView]!
    @IBOutlet var backgroundImageView: UIImageView!
//    @IBOutlet var castButton: CastIconBarButtonItem!
    @IBOutlet var showTitleLabel: UILabel!
//    @IBOutlet var showRatingView: FloatRatingView!
    @IBOutlet var showDescriptionView: UITextView!
    @IBOutlet var showInfoLabel: UILabel!
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet var scrollView: PCTScrollView?
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
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view!.superview!)
        let offset = translation.y - lastTranslation
        let scrollDirection: ScrollDirection = offset > 0 ? .up : .down
        var scrollingView: AnyObject
        if let tableView = tableView {
            scrollingView = tableView
        } else {
            scrollingView = scrollView!
        }
        
        if sender.state == .changed || sender.state == .began {
            if (headerHeightConstraint.constant + offset) >= minimumHeight && (scrollingView.value(forKey: "programaticScrollEnabled")! as AnyObject).boolValue == false {
                if ((headerHeightConstraint.constant + offset) - minimumHeight) <= 8.0 // Stops scrolling from sticking just before we transition to scroll view input.
                {
                    headerHeightConstraint.constant = self.minimumHeight
                    updateScrolling(true)
                } else {
                    headerHeightConstraint.constant += offset
                    updateScrolling(false)
                }
            }
            if headerHeightConstraint.constant == minimumHeight && scrollingView.value(forKey: "isAtTop")!.boolValue {
//                 if headerHeightConstraint.constant == minimumHeight && scrollingView.value(forKey: "isAtTop")!.boolValue {
                if scrollDirection == .up {
                    scrollingView.perform(#selector(setter: PCTScrollView.programaticScrollEnabled), with: NSNumber(value: false as Bool))
                } else // If header is fully collapsed and we are not at the end of scroll view, hand scrolling to scroll view
                {
                    scrollingView.perform(#selector(setter: PCTScrollView.programaticScrollEnabled), with: NSNumber(value: true as Bool))
                }
            }
            lastTranslation = translation.y
        } else if sender.state == .ended {
            if headerHeightConstraint.constant > maximumHeight {
                headerHeightConstraint.constant = maximumHeight
                updateScrolling(true)
            } else if (scrollingView.value(forKey: "frame")! as AnyObject).cgRectValue.size.height > (scrollingView.value(forKey: "contentSize")! as AnyObject).cgSizeValue.height + (scrollingView.value(forKey: "contentInset")! as AnyObject).uiEdgeInsetsValue.bottom {
                resetToEnd(scrollingView)
            }
            lastTranslation = 0.0
        }
    }
    func updateScrolling(_ animated: Bool) {
        self.progressiveness = 1.0 - (self.headerHeightConstraint.constant - self.minimumHeight)/(self.maximumHeight - self.minimumHeight)
        if animated {
            UIView.animate(withDuration: animationLength, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
                self.view.layoutIfNeeded()
                self.blurView.alpha = self.progressiveness
                self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(self.progressiveness)]
            }, completion: nil)
        } else {
            self.blurView.alpha = self.progressiveness
            self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(self.progressiveness)]
        }
    }
    
    func resetToEnd(_ scrollingView: AnyObject, animated: Bool = true) {
        headerHeightConstraint.constant += (scrollingView.value(forKey: "frame")! as AnyObject).cgRectValue.size.height - ((scrollingView.value(forKey: "contentSize")! as AnyObject).cgSizeValue.height + (scrollingView.value(forKey: "contentInset")! as AnyObject).uiEdgeInsetsValue.bottom)
        if headerHeightConstraint.constant > maximumHeight {
            headerHeightConstraint.constant = maximumHeight
        }
        if headerHeightConstraint.constant >= minimumHeight // User does not go over the "bridge area" so programmatic scrolling has to be explicitly disabled
        {
            scrollingView.perform(#selector(setter: PCTScrollView.programaticScrollEnabled), with: NSNumber(value: false as Bool))
        }
        updateScrolling(animated)
    }
    
}

class PCTScrollView: UIScrollView {
    var programaticScrollEnabled = NSNumber(value: false as Bool)
    
    override var contentOffset: CGPoint {
        didSet {
            if !programaticScrollEnabled.boolValue {
                super.contentOffset = CGPoint.zero
            }
        }
    }
}

class PCTTableView: UITableView {
    var programaticScrollEnabled = NSNumber(value: false as Bool)
    
    override var contentOffset: CGPoint {
        didSet {
            if !programaticScrollEnabled.boolValue {
                super.contentOffset = CGPoint.zero
            }
        }
    }
}
