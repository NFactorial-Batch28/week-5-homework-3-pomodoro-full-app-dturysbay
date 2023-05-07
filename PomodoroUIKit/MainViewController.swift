//
//  MainViewController.swift
//  PomodoroUIKit
//
//  Created by Dinmukhambet Turysbay on 07.05.2023.
//

import UIKit

enum PlayPauseButton {
    case play
    case pause
}

class MainViewController: UIViewController{
    let duration: TimeInterval = 1500
    var remainingTime: TimeInterval = 30
    var timer: Timer?
    var isRunning = false
    
    let circleView = CircleView()
    let remainingTimeLabel = {
        let remainingTimeLabel = UILabel()
        remainingTimeLabel.font = UIFont.systemFont(ofSize: 44,weight:.bold)
//        remainingTimeLabel.weig
        remainingTimeLabel.textColor = .white
    
        return remainingTimeLabel
    }()
    let playButton: UIButton = {
        let playButton = UIButton(type: .system)
        playButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        playButton.layer.cornerRadius = min(playButton.frame.width, playButton.frame.height) / 2
        playButton.backgroundColor = .gray
        playButton.tintColor = UIColor.white
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        return playButton
    }()
    
    let resetButton = {
        let resetButton = UIButton(type: .system)
        resetButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        resetButton.layer.cornerRadius = min(resetButton.frame.width, resetButton.frame.height) / 2
        resetButton.backgroundColor = .gray
        resetButton.tintColor = UIColor.white
        resetButton.setImage(UIImage(systemName: "rectangle.fill"), for: .normal)
        return resetButton
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [circleView,playButton,resetButton].forEach {
            view.addSubview($0)
        }
        
       
        assignbackground()
        circleView.centerInView(in: self.view)
        circleView.addSubview(remainingTimeLabel)
        remainingTimeLabel.centerInView(in: circleView)
        
        // Set up the play button
        playButton.anchor(left: self.view.leftAnchor,bottom: self.view.bottomAnchor,paddingLeft: 100,paddingBottom: 250)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        resetButton.anchor(bottom: self.view.bottomAnchor,right: self.view.rightAnchor,paddingBottom: 250,paddingRight: 100)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        // Set up the initial state
        remainingTime = duration
        updateView()
    }
    
    func assignbackground(){
        let background = UIImage(named: "wave-bcg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func updateView() {
        let progress = 1 - CGFloat(remainingTime) / CGFloat(duration)
        circleView.progress = progress
        
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        remainingTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func playButtonTapped() {
        let imageName = isRunning ? "play.fill" : "pause.fill"
        if !isRunning{
            isRunning = true
            playButton.setImage(UIImage(systemName: imageName), for: .normal)
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                    guard let self = self else { return }
                    self.remainingTime -= 1
                    if self.remainingTime <= 0 {
                        self.remainingTime = self.duration
                        self.isRunning = false
                                    self.timer?.invalidate()
                                    self.timer = nil
                        
                    }
                    self.updateView()
                }
        }else{
            playButton.setImage(UIImage(systemName: imageName), for: .normal)
                    isRunning = false
                    timer?.invalidate()
                    timer = nil
        }
    }
        
    @objc func resetButtonTapped() {
        isRunning = false
        remainingTime = duration
        timer?.invalidate()
        timer = nil
        updateView()
    }
}
