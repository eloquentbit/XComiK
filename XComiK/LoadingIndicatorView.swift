//
//  LoadingIndicatorView.swift
//  SwiftLoadingIndicator
//
//  Created by Vince Chan on 12/2/15.
//  Copyright © 2015 Vince Chan. All rights reserved.
//
import UIKit
import ChameleonFramework

class LoadingIndicatorView {
    
    static var currentOverlay : UIView?
    
    static func show() {
        guard let currentMainWindow = UIApplication.sharedApplication().keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow)
    }
    
    static func show(loadingText: String) {
        guard let currentMainWindow = UIApplication.sharedApplication().keyWindow else {
            print("No main window.")
            return
        }
        show(currentMainWindow, loadingText: loadingText)
    }
    
    static func show(overlayTarget : UIView) {
        show(overlayTarget, loadingText: nil)
    }
    
    static func show(overlayTarget : UIView, loadingText: String?) {
        // Clear it first in case it was already shown
        hide()
        
        // Create the overlay
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        overlay.alpha = 0
        overlay.translatesAutoresizingMaskIntoConstraints = true
        overlay.autoresizingMask = [.FlexibleLeftMargin, .FlexibleHeight, .FlexibleWidth, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin]
        overlay.backgroundColor = FlatWhiteDark()
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        // Create and animate the activity indicator
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicator.color = FlatWatermelonDark()
        indicator.center = overlay.center
        indicator.translatesAutoresizingMaskIntoConstraints = false
        //indicator.autoresizingMask = [.FlexibleLeftMargin, .FlexibleHeight, .FlexibleWidth, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin]
        indicator.startAnimating()
        overlay.addSubview(indicator)
        NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: overlay, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: indicator, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: overlay, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0).active = true
        
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.font = UIFont(name: "Avenir-Heavy", size: 14.0)
            label.textColor = FlatBlackDark()
            label.sizeToFit()
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            label.translatesAutoresizingMaskIntoConstraints = true
            label.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin]
            overlay.addSubview(label)
        }
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        UIView.commitAnimations()
        
        currentOverlay = overlay
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
    }
}