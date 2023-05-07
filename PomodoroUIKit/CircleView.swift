//
//  CircleView.swift
//  PomodoroUIKit
//
//  Created by Dinmukhambet Turysbay on 08.05.2023.
//
import UIKit

class CircleView: UIView {
    let progressLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()

    var progress: CGFloat = 0 {
        didSet {
            progressLayer.strokeEnd = progress
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayers()
    }
    
    func setUpLayers() {
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let radius = bounds.width / 2
            let lineWidth: CGFloat = 248
            
            // Track Layer
            let trackPath = UIBezierPath(arcCenter: center, radius: radius - lineWidth / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
            trackLayer.path = trackPath.cgPath
            trackLayer.strokeColor = UIColor.lightGray.cgColor
            trackLayer.lineWidth = 5
            trackLayer.fillColor = UIColor.clear.cgColor
            layer.addSublayer(trackLayer)
            
            // Progress Layer
            let progressPath = UIBezierPath(arcCenter: center, radius: radius - lineWidth / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
            progressLayer.path = progressPath.cgPath
            progressLayer.strokeColor = UIColor.white.cgColor
            progressLayer.lineWidth = 5
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.lineCap = CAShapeLayerLineCap.round
            progressLayer.strokeEnd = 0
            layer.addSublayer(progressLayer)
        }
}
