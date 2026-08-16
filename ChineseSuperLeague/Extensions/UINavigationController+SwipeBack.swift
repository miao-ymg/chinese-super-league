//
//  UINavigationController+SwipeBack.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.08.26.
//

import UIKit

/// Re-enable the interactive swipe-back gesture for navigation
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
