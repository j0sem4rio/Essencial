//
//  DetailViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/25/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var infoStackView: UIStackView!
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var peopleHeader: UILabel!
    @IBOutlet var relatedHeader: UILabel!
    @IBOutlet var peopleBottomConstraint: NSLayoutConstraint!
    @IBOutlet var relatedBottomConstraint: NSLayoutConstraint!
    @IBOutlet var peopleTopConstraint: NSLayoutConstraint!
    @IBOutlet var relatedTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var compactConstraints: [NSLayoutConstraint] = []
    @IBOutlet var regularConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Container view controllers
    
//    var itemViewController: ItemViewController!
//    var relatedCollectionViewController: CollectionViewController!
//    var peopleCollectionViewController: CollectionViewController!
//    var informationDescriptionCollectionViewController: DescriptionCollectionViewController!
//    var accessibilityDescriptionCollectionViewController: DescriptionCollectionViewController!
//    var episodesCollectionViewController: EpisodesCollectionViewController!
    
    // MARK: - Container view height constraints
    
    @IBOutlet var relatedContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var peopleContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var episodesContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var informationContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var accessibilityContainerViewHeightConstraint: NSLayoutConstraint!
    
    var episodes: [Episodes]?
    
    var currentItem: Watched!
    var currentSeasonArray = [Seasons]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = currentItem.movie {
            navigationItem.title = movie.title
//            backgroundImageView.image = movie.poster.image
        } else {
            navigationItem.title = currentItem.show.title
//            backgroundImageView.image = currentItem.show.poster.image
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
        
}
