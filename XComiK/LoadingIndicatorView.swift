//
//  LoadingIndicatorView.swift
//  SwiftLoadingIndicator
//
//  Created by Vince Chan on 12/2/15.
//  Copyright © 2015 Vince Chan. All rights reserved.
//
import UIKit

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
        overlay.backgroundColor = UIColor.whiteColor()
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        // Create and animate the activity indicator
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicator.color = UIColor(red: 255.0/255.0, green: 86.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        indicator.translatesAutoresizingMaskIntoConstraints = true
        indicator.center = overlay.center
        indicator.translatesAutoresizingMaskIntoConstraints = true
        indicator.autoresizingMask = [.FlexibleLeftMargin, .FlexibleHeight, .FlexibleWidth, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin]
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        // Create label
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.font = UIFont(name: "Avenir-Heavy", size: 14.0)
            label.textColor = UIColor.blackColor()
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