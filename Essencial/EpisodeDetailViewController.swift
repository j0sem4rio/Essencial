//
//  EpisodeDetailViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 8/4/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var playButton: UIButton!
    
    var episode: Seasons!
    
    @IBOutlet var dismissPanGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        preferredContentSize = scrollView.contentSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subtitleLabel.text = "Season"
//        titleLabel.text = episode.title
//        summaryTextView.text = episode.summary
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.hour, .minute]
        
//        let info = NSMutableAttributedString(string: "\(DateFormatter.localizedString(from: episode.firstAirDate, dateStyle: .medium, timeStyle: .none))\t\(formatter.string(from: TimeInterval(episode.show?.runtime ?? 0) * 60) ?? "0 min")")
//        attributedString(with: 10, between: "HD", "CC").forEach({info.append($0)})
//        infoLabel.attributedText = info
//        
//        
//        if let image = episode.largeBackgroundImage,
//            let url = URL(string: image) {
//            imageView.af_setImage(withURL: url, placeholderImage: UIImage(named: "Episode Placeholder"), imageTransition: .crossDissolve(.default))
//        }
        
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        preferredContentSize = scrollView.contentSize
    }
    
    
    @IBAction func handleDismissPan(_ sender: UIPanGestureRecognizer) {
        let percentThreshold: CGFloat = 0.12
        let superview = sender.view!.superview!
        let translation = sender.translation(in: superview)
        let progress = translation.y/superview.bounds.height/3.0
        
//        guard let interactor = interactor else { return }
//        
//        switch sender.state {
//        case .began:
//            interactor.hasStarted = true
//            dismiss(animated: true)
//            scrollView.bounces = false
//        case .changed:
//            interactor.shouldFinish = progress > percentThreshold
//            interactor.update(progress)
//        case .cancelled:
//            interactor.hasStarted = false
//            interactor.cancel()
//            scrollView.bounces = true
//        case .ended:
//            interactor.hasStarted = false
//            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
//            scrollView.bounces = true
//        default:
//            break
//        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == dismissPanGestureRecognizer else { return true }
        let isRegular = traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular
        return scrollView.contentOffset.y == 0 && !isRegular ? true : false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func play(_ sender: UIView) {
//        AppDelegate.shared.chooseQuality(sender, media: episode) { [unowned self] (torrent) in
//            self.dismiss(animated: false)
//            AppDelegate.shared.play(self.episode, torrent: torrent)
//        }
    }
}
