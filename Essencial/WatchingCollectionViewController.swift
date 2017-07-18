//
//  WatchingCollectionViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import PKHUD

class WatchingCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var movies = [Watched]()
    var presenter: WatchingPresenterProtocol?
    var user: UserEntity!
    
    // outlet - collection view
    @IBOutlet var moviesCollectionView: UICollectionView!
    
    
    // action - radious change stepper
    @IBAction func radiousStepperAction(_ sender: UIStepper) {
        
        // reload collection view
        self.moviesCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItem()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(WatchingCollectionViewCell.self, forCellWithReuseIdentifier: WatchingCollectionViewCell.identifier)

        presenter?.viewDidLoad(userEntity: user, type: .Shows)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchingCollectionViewCell.identifier, for: indexPath) as? WatchingCollectionViewCell
//        cell.coverImage.af_setImageWithURL(URL(string: movies[indexPath.row].coverImageAsString)!, placeholderImage: UIImage(named: "Placeholder"), mageTransition: .CrossDissolve(animationLength))
        cell?.titleLabel.text = movies[indexPath.row].show.title
        cell?.yearLabel.text = String(movies[indexPath.row].show.year)
//        cell.watched = WatchlistManager.movieManager.isWatched(movies[indexPath.row].imdbId)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.bounds.width/(195 * 4) >= 1 // Check if the view can fit more than 4 cells across
        {
            return CGSize(width: 195, height: 280)
        } else {
            let wid = (collectionView.bounds.width/CGFloat(2))-8
            let ratio = 230/wid
            let hei = 345/ratio
            
            return CGSize(width: wid, height: hei)
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
extension WatchingCollectionViewController: WatchingViewProtocol {
    
    func showPosts(with posts: [Watched]) {
        presenter?.image(posts)
        movies = posts
        self.moviesCollectionView!.reloadData()
    }
    func showUpdatePosts() {
    }
    
    func showError() {
        HUD.flash(.label("Internet not connected"), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
}
