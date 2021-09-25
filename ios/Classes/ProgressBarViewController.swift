//
//  ProgressBarViewController.swift
//  pos_printer
//
//  Created by Yoyo on 9/25/21.
//

import UIKit

class ProgressBarViewController: UIViewController {
    static var `default`: ProgressBarViewController = { () -> ProgressBarViewController in
        let progressBarVC = ProgressBarViewController()
        progressBarVC.modalPresentationStyle = .overCurrentContext
        progressBarVC.modalTransitionStyle = .crossDissolve
        
        return progressBarVC
    }()
    
    
    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 20
    var value: CGFloat = 0.0
    var completeBlock: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.isUserInteractionEnabled = false
        setUpCircularProgressBarView()
    }
    
    func setUpCircularProgressBarView() {
        let blurEffect = UIBlurEffect(style: .light)
        let bg = UIVisualEffectView(effect: blurEffect)
        bg.layer.cornerRadius = 8
        bg.clipsToBounds = true
        view.addSubview(bg)
        
        bg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bg.widthAnchor.constraint(equalToConstant: 120),
            bg.heightAnchor.constraint(equalToConstant: 120),
            bg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bg.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // setup progress view
        circularProgressBarView = CircularProgressBarView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        bg.contentView.addSubview(circularProgressBarView)
        
        circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circularProgressBarView.widthAnchor.constraint(equalToConstant: 80),
            circularProgressBarView.heightAnchor.constraint(equalToConstant: 80),
            circularProgressBarView.centerXAnchor.constraint(equalTo: bg.centerXAnchor),
            circularProgressBarView.centerYAnchor.constraint(equalTo: bg.centerYAnchor),
        ])
    }
    
    func setProgress(_ progress: CGFloat) {
        if (progress == 0) {
            if let root = UIApplication.shared.keyWindow?.rootViewController {
                root.present(self, animated: true)
            }
            return
        }
        
        self.circularProgressBarView.setProgress(progress, animated: true)
    }
}

class CircularProgressBarView: UIView, CAAnimationDelegate {
    
    // MARK: - Properties -

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private(set) var progress: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)

        createCircularPath()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        createCircularPath()
    }

    func createCircularPath() {
        // created circularPath for circleLayer and progressLayer
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                           y: frame.size.height / 2.0),
                                        radius: frame.size.width / 2.0,
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 16.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.black.withAlphaComponent(0.1).cgColor
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIApplication.shared.keyWindow?.tintColor?.cgColor ?? UIColor.black.cgColor
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
    }

    func setProgress(_ progress: CGFloat, animated: Bool) {
        if !animated {
            progressLayer.strokeEnd = progress / 2
        }
        else {
            let stroke = CABasicAnimation(keyPath: "strokeEnd")
            stroke.delegate = self
            stroke.fromValue = self.progress
            stroke.toValue = progress
            stroke.fillMode = .forwards
            stroke.isRemovedOnCompletion = false
            stroke.timingFunction = CAMediaTimingFunction(name: .linear)
            self.progressLayer.add(stroke, forKey: nil)
        }
        self.progress = progress
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if (progress == 1) {
            ProgressBarViewController.default.dismiss(animated: true) {
                ProgressBarViewController.default.completeBlock?()
                ProgressBarViewController.default.completeBlock = nil
            }
        }
    }
}
