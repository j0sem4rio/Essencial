//
//  MediaViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 8/3/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class MediaViewController: MainViewController {
    
    var currentGenre = MovieManager.Genres.all {
        didSet {
            collectionViewController.currentPage = 1
            didRefresh(collectionView: collectionView!)
        }
    }
    
    @IBAction func showGenres(_ sender: Any) {
        let controller = UIAlertController(title:  "Select a genre to filter by", message: nil, preferredStyle: .actionSheet)
        
        let handler: ((UIAlertAction) -> Void) = { (handler) in
            self.currentGenre = MovieManager.Genres.array.first(where: {$0.string == handler.title!})!
            if self.currentGenre == .all {
                self.navigationItem.title = (self is MoviesViewController ? "Movies" : "Shows")
            } else {
                self.navigationItem.title = self.currentGenre.string
            }
            
        }
        
        MovieManager.Genres.array.forEach {
            controller.addAction(UIAlertAction(title: $0.string, style: .default, handler: handler))
        }
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.preferredAction = controller.actions.first(where: {$0.title == self.currentGenre.string})
        
        if let barButtonItem = sender as? UIBarButtonItem {
            controller.popoverPresentationController?.barButtonItem = barButtonItem
        }
        
        present(controller, animated: true)
    }
}
