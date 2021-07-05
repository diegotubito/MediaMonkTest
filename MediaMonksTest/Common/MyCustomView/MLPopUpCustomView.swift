//
//  MLPopUpCustomView.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit

protocol MLPopUpCustomViewDelegate {
    func finishedView()
}

class MLPopUpCustomView: UIView, CAAnimationDelegate {
    var delegate : MLPopUpCustomViewDelegate?
    var blurEffectView : UIVisualEffectView!
    
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var urlLabel: UILabel!
    @IBOutlet var thumbnailUrlLabel: UILabel!
    @IBOutlet var imageLoaded: UIImageView!
    @IBOutlet var myView: UIView!
    @IBOutlet var area: UIView!
    @IBOutlet var borderArea: UIImageView!
    @IBOutlet var viewBody: UIImageView!
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        
    }
    
    
    func drawArea() {
        for i in viewBody.subviews {
            i.removeFromSuperview()
        }
        
        area.layer.borderColor = UIColor.white.cgColor
        area.layer.borderWidth = 3
        area.layer.cornerRadius = 10
        area.layer.masksToBounds = true
        
        myActivityIndicator.startAnimating()
        
    }
    
    func showData(data: MMPhotoListModel.PhotoList) {
        title.text = data.title
        urlLabel.text = data.url
        thumbnailUrlLabel.text = data.thumbnailUrl
        
        //load full size image
        MMPlaceHolderManager.getImageFromUrl(url: data.url, result: { (image) in
            if image != nil {
                DispatchQueue.main.async {
                    self.myActivityIndicator.stopAnimating()
                    self.viewBody.image = image!
                }
            }
        }) { (error) in
            print(error?.localizedDescription ?? "unknown error")
        }
        
    }
    
    
    
    func initialize() {
        
        Bundle.main.loadNibNamed("MLPopUpCustomView", owner: self, options: nil)
        
        let contentFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        myView.frame = contentFrame
        addSubview(myView)
        
        drawArea()
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(swipeUpAction(_:)))
        borderArea.addGestureRecognizer(tap)
        borderArea.isUserInteractionEnabled = true
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpAction(_:)))
        swipeUp.direction = .up
        area.addGestureRecognizer(swipeUp)
        
        showCustomView()
        
        
        
    }
    
    @objc func swipeUpAction(_ sender: UISwipeGestureRecognizer) {
        hideCustomView()
    }
    
    func startBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.effect = nil
        blurEffectView.frame = borderArea.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        borderArea.addSubview(blurEffectView)
        
        //start blurring
        UIView.animate(withDuration: 3) {
            self.blurEffectView.effect = UIBlurEffect(style: .light)
            
        }
        //stop animation at 0.5sec
        blurEffectView.pauseAnimation(delay: 0.5)
    }
    
    func showCustomView() {
        startBlurEffect()
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        let animation = CASpringAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: w/2, y: -h)
        animation.toValue = CGPoint(x: w/2, y: h/2)
        animation.initialVelocity = 0
        animation.damping = 100
        
        animation.duration = animation.settlingDuration
        animation.delegate = self
        
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        animation.setValue("endAnimationShow", forKey: "name")
        
        area.layer.add(animation, forKey: nil)
    }
    
    func hideCustomView() {
        blurEffectView.effect = nil
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.5
        animation.fromValue = CGPoint(x: w/2, y: h/2)
        animation.toValue = CGPoint(x: w/2, y: -h/2)
        animation.delegate = self
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.setValue("endAnimationHide", forKey: "name")
        
        area.layer.add(animation, forKey: nil)
        
        delegate?.finishedView()
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        
        guard let name = anim.value(forKey: "name") as? String else {
            return
        }
        
        if name == "endAnimationHide" {
            superview?.alpha = 1
            removeFromSuperview()
        } else if name == "endAnimationShow" {
            
        }
        
        
    }
    
    
}

