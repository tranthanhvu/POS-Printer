//
//  ProgressBarViewController.swift
//  pos_printer
//
//  Created by Yoyo on 9/25/21.
//

import UIKit

class ProgressBarViewController: UIViewController {
    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 20
    var value: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCircularProgressBarView()
    }
    
    func setUpCircularProgressBarView() {
        // set view
        circularProgressBarView = CircularProgressBarView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        // align to the center of the screen
        circularProgressBarView.center = view.center
        // add this view to the view controller
        view.addSubview(circularProgressBarView)
        
        run()
    }
    
    func run() {
        if self.value >= 1 {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.value += 0.1
            self.circularProgressBarView.setProgress(self.value, animated: true)
            
            self.run()
        }
    }
}

class CircularProgressBarView: UIView {
    
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
        circleLayer.lineWidth = 20.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.white.cgColor
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.green.cgColor
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
    }

    func setProgress(_ progress: CGFloat, animated: Bool) {
        if !animated {
            progressLayer.strokeEnd = progress / 2
        }
        else {
            let stroke = CABasicAnimation(keyPath: "strokeEnd")
            stroke.fromValue = self.progress
            stroke.toValue = progress
            stroke.fillMode = .forwards
            stroke.isRemovedOnCompletion = false
            stroke.timingFunction = CAMediaTimingFunction(name: .linear)
            self.progressLayer.add(stroke, forKey: nil)
        }
        self.progress = progress
//
//        UIView.animate(withDuration: duration) {
//            self.progressLayer.strokeEnd = toValue
//        }
//        progressLayer.removeAllAnimations()
//
//        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
//
//        // set the end time
//        circularProgressAnimation.duration = duration * (toValue - (circularProgressAnimation.toValue as? Double ?? 0))
//        circularProgressAnimation.fromValue = progressLayer.strokeEnd
//        circularProgressAnimation.toValue =  toValue
//        circularProgressAnimation.fillMode = .forwards
//        circularProgressAnimation.isRemovedOnCompletion = false
//        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
