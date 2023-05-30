//
//  UIView.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func showLoading(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
        
        let activityIndicator = UIActivityIndicatorView.init()
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = UIColor.blue
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    func removeLoading(loadingView: UIView) {
        DispatchQueue.main.async {
            loadingView.removeFromSuperview()
        }
    }
}
