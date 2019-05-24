//
//  ViewController.swift
//  Lab - Animation
//
//  Created by Arkadiy Grigoryanc on 22/05/2019.
//  Copyright © 2019 Arkadiy Grigoryanc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var playButton: PauseButton!
    @IBOutlet weak var pauseButton: PauseButton!
    @IBOutlet weak var previousButton: RewindButton!
    @IBOutlet weak var followingButton: RewindButton!
    
    private var isPause = true
    private var isPlayingAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func actionPlay(_ sender: UITapGestureRecognizer) {
        
        guard !isPlayingAnimation else { return }
        
        isPlayingAnimation = true
        
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
            self.playButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.playButton.alpha = 0
            
            self.squareView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7).concatenating(CGAffineTransform(rotationAngle: .pi / 20))
            self.squareView.layer.cornerRadius = 30
        }
        animator.addCompletion { position in
            switch position {
            case .end:
                
                self.pauseButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                let animator2 = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
                    self.pauseButton.transform = CGAffineTransform.identity
                    self.pauseButton.alpha = 1.0
                    
                    self.squareView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(rotationAngle: .pi / 30))
                    self.squareView.layer.cornerRadius = 20
                }
                animator2.addCompletion{ position in
                    if case .end = position {
                        generator.notificationOccurred(.success)
                        self.isPlayingAnimation = false
                    }
                }
                animator2.startAnimation()
                
            default: break
            }
        }
        
        animator.startAnimation()
        
        isPause = false
        
    }
    
    @IBAction func actionPause(_ sender: UITapGestureRecognizer) {
        
        guard !isPlayingAnimation else { return }
        
        isPlayingAnimation = true
        
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
            self.pauseButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.pauseButton.alpha = 0
            
            self.squareView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7).concatenating(CGAffineTransform(rotationAngle: .pi / 20))
            self.squareView.layer.cornerRadius = 30
        }
        animator.addCompletion { position in
            switch position {
            case .end:
                
                self.playButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                let animator2 = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
                    self.playButton.transform = CGAffineTransform.identity
                    self.playButton.alpha = 1.0
                    
                    self.squareView.transform = CGAffineTransform.identity
                    self.squareView.layer.cornerRadius = 0
                }
                animator2.addCompletion{ position in
                    if case .end = position {
                        generator.notificationOccurred(.success)
                        self.isPlayingAnimation = false
                    }
                }
                animator2.startAnimation()
                
            default: break
            }
        }
        
        animator.startAnimation()
        
        isPause = true
    }
    
    @IBAction func actionPrevious(_ sender: UITapGestureRecognizer) {
        
        guard !isPlayingAnimation else { return }
        
        isPlayingAnimation = true
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        
        if isPause {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .autoreverse, animations: {
                
                self.previousButton.layer.transform = CATransform3DMakeRotation(0.5, 0, 1, 0)
                self.squareView.layer.transform = CATransform3DMakeRotation(-0.5, 0, 1, 0)
                
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                    self.squareView.backgroundColor = .random()
                }, completion: nil)
                
            }) { _ in
                self.previousButton.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
                self.squareView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
                
                generator.impactOccurred()
                self.isPlayingAnimation = false
            }
            
        } else {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .autoreverse, animations: {
                
                self.previousButton.layer.transform = CATransform3DMakeRotation(0.5, 0, 1, 0)
                self.squareView.transform = self.squareView.transform.rotated(by: -3 * .pi / 20)
                
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                    self.squareView.backgroundColor = .random()
                }, completion: nil)
                
            }) { _ in
                self.previousButton.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
                self.squareView.transform = self.squareView.transform.rotated(by: 3 * .pi / 20)
                
                generator.impactOccurred()
                self.isPlayingAnimation = false
            }
            
        }
        
    }
    
    @IBAction func actionFollowing(_ sender: UITapGestureRecognizer) {
        
        guard !isPlayingAnimation else { return }
        
        self.isPlayingAnimation = true
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        
        if isPause {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .autoreverse, animations: {
                
                self.followingButton.layer.transform = CATransform3DMakeRotation(0.5, 0, 1, 0)
                self.squareView.layer.transform = CATransform3DMakeRotation(0.5, 0, 1, 0)
                
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                    self.squareView.backgroundColor = .random()
                }, completion: nil)
                
            }) { _ in
                self.followingButton.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
                self.squareView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
                
                generator.impactOccurred()
                self.isPlayingAnimation = false
            }
            
        } else {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .autoreverse, animations: {
                
                self.followingButton.layer.transform = CATransform3DMakeRotation(0.5, 0, 1, 0)
                self.squareView.transform = self.squareView.transform.rotated(by: .pi / 10)
                
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                    self.squareView.backgroundColor = .random()
                }, completion: nil)
                
            }) { _ in
                self.followingButton.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
                self.squareView.transform = self.squareView.transform.rotated(by: -.pi / 10)
                
                generator.impactOccurred()
                self.isPlayingAnimation = false
            }
            
        }
        
    }
    
}
