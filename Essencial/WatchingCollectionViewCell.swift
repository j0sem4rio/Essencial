//
//  WatchingCollectionViewCell.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchingCollectionViewCell: UICollectionViewCell, WatchedCellProtocol {
    class var identifier: String { return String.className(self) }
    var presenter: (WatchedCellPresenterProtocol & WatchedCellInteractorOutputProtocol)?
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var watchedIndicator: UIView?
    override func awakeFromNib() {
        super.awakeFromNib()
//        let presenter = WatchedCellPresenterProtocol & WatchedCellInteractorOutputProtocol = WatchedCellOutputPresenter()
        presenter = WatchedCellOutputPresenter()
        let interactor: WatchedCellInteractorInputProtocol & WatchedCellRemoteDataManagerOutputProtocol = WatchedCellInteractor()
        let remoteDataManager: WatchedCellRemoteDataManagerInputProtocol = WatchedCellRemoteDataManager()
        presenter?.cell = self
        presenter?.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
    }
    var watched: Bool = false {
        didSet {
            if let watchedIndicator = watchedIndicator {
                UIView.animate(withDuration: 0.25, animations: {
                    if self.watched {
                        watchedIndicator.alpha = 0.5
                        watchedIndicator.isHidden = false
                    } else {
                        watchedIndicator.alpha = 0.0
                        watchedIndicator.isHidden = true
                    }
                })
            }
        }
    }
    func set(forPost post: Watched) {
        if let show = post.show {
            titleLabel?.text = show.title
            yearLabel?.text = String(show.year)
            presenter?.image(post, type: ThemoviedbAPI.typedb.Tv)
        } else {
            titleLabel?.text = post.movie.title
            yearLabel?.text = String(post.movie.year)
            presenter?.image(post, type: ThemoviedbAPI.typedb.Movies)
            if post.movie.imageUrl != nil {
                let url = URL(string: post.movie.imageUrl!)!
                let placeholderImage = UIImage(named: "placeholder")!
                coverImage?.af_setImage(withURL: url, placeholderImage: placeholderImage)
            }
        }
    }
    func showUpdatePosts(_ posts: Watched) {
        if let show = posts.show {
            if show.imageUrl != nil && show.poster == nil {
                let url = URL(string: show.imageUrl!)!
                let placeholderImage = UIImage(named: "placeholder")!
                coverImage?.af_setImage(withURL: url, placeholderImage: placeholderImage)
                show.poster = coverImage
            }

        } else {
            if posts.movie.imageUrl != nil {
                let url = URL(string: posts.movie.imageUrl!)!
                let placeholderImage = UIImage(named: "placeholder")!
                coverImage?.af_setImage(withURL: url, placeholderImage: placeholderImage)
                posts.movie.poster = coverImage
            }
        }
    }
}
