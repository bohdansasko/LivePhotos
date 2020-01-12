//
//  LPRootableViewController.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

protocol LPRootableViewController {
    associatedtype RootView
    var rootView: RootView! { get }
}

// MARK: - ViewController

extension LPRootableViewController where Self: UIViewController {
    
    var rootView: RootView! {
        return view as? RootView
    }
    
}
