//
//  ItemViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 8/4/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

//typealias ExpandableTextView = UIExpandableTextView
//typealias Button = UIButton

class ItemViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
//    @IBOutlet var summaryTextView: ExpandableTextView!
//    @IBOutlet var ratingView: FloatRatingView!
    
    @IBOutlet var trailerButton: UIButton!
//    @IBOutlet var downloadButton: DownloadButton!
    @IBOutlet var playButton: UIButton!
    
    // iOS Exclusive
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var genreLabel: UILabel?
    
    @IBOutlet var compactConstraints: [NSLayoutConstraint] = []
    @IBOutlet var regularConstraints: [NSLayoutConstraint] = []
    
    // tvOS Exclusive
    
    @IBOutlet var seasonsButton: UIButton?
    @IBOutlet var watchlistButton: UIButton?
    @IBOutlet var watchedButton: UIButton?
    
    @IBOutlet var peopleTextView: UITextView?
    
    var environmentsToFocus: [UIFocusEnvironment] = []
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return environmentsToFocus.isEmpty ? super.preferredFocusEnvironments : environmentsToFocus
    }
    
    var media: Produce!
    
//    var watchedButtonImage: UIImage? {
//        return media.isWatched ? UIImage(named: "Watched On") : UIImage(named: "Watched Off")
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let download = media.associatedDownload {
//            downloadStatusDidChange(download.downloadStatus, for: download)
//        } else {
//            downloadButton.downloadState = .normal
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        parent?.prepare(for: segue, sender: sender)
    }
    
    @IBAction func play(_ sender: UIView) {
        let media: Produce
        if let movie = self.media as? Movie {
            media = movie
        } else {
//            let show = self.media as? Show
//            let episode = show.latestUnwatchedEpisode() ?? show.episodes.filter({$0.season == show.seasonNumbers.first}).sorted(by: {$0.0.episode < $0.1.episode}).first
//            media = episode ?? show
            
        }
//        AppDelegate.shared.chooseQuality(sender, media: media) { torrent in
//            AppDelegate.shared.play(media, torrent: torrent)
        }
    
    @IBAction func playTrailer() {
//        guard let id = (media as? Movie)?.trailerCode else { return }
//        
//        let playerController = AVPlayerViewController()
//        
//        playerController.transitioningDelegate = self as? UIViewControllerTransitioningDelegate // tvOS only
//        
//        present(playerController, animated: true)
//        
//        XCDYouTubeClient.default().getVideoWithIdentifier(id) { (video, error) in
//            guard
//                let streamUrls = video?.streamURLs,
//                let qualities = Array(streamUrls.keys) as? [UInt]
//                else {
//                    return
//            }
//            
//            let preferredVideoQualities = [XCDYouTubeVideoQuality.HD720.rawValue, XCDYouTubeVideoQuality.medium360.rawValue, XCDYouTubeVideoQuality.small240.rawValue]
//            var videoUrl: URL?
//            
//            for quality in preferredVideoQualities {
//                if let index = qualities.index(of: quality) {
//                    videoUrl = Array(streamUrls.values)[index]
//                    break
//                }
//            }
//            
//            guard let url = videoUrl else {
//                self.dismiss(animated: true)
//                
//                let vc = UIAlertController(title: "Error".localized, message: "Error fetching valid trailer URL from YouTube.".localized, preferredStyle: .alert)
//                
//                vc.addAction(UIAlertAction(title: "OK".localized, style: .cancel, handler: nil))
//                
//                self.present(vc, animated: true)
//                
//                return
//            }
//            
//            let player = AVPlayer(url: url)
//            
//            #if os(tvOS)
//                
//                let title = AVMetadataItem(key: AVMetadataCommonKeyTitle as NSString, value: self.media.title as NSString)
//                let summary = AVMetadataItem(key: AVMetadataCommonKeyDescription as NSString, value: self.media.summary as NSString)
//                
//                player.currentItem?.externalMetadata = [title, summary]
//                
//                if let string = self.media.mediumCoverImage,
//                    let url = URL(string: string),
//                    let data = try? Data(contentsOf: url) {
//                    let image = AVMetadataItem(key: AVMetadataCommonKeyArtwork as NSString, value: data as NSData)
//                    player.currentItem?.externalMetadata.append(image)
//                }
//                
//            #endif
//            
//            playerController.player = player
//            player.play()
//            
//            
//            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
//        }
    }

}
