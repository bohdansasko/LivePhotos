//
//  ViewController.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

final class LPHomeViewController: LPBaseViewController, LPRootableViewController {
    typealias RootView = LPHomeRootView
    
    private var images = [
        #imageLiteral(resourceName: "cdab193b86e53506966f2a9793c770da"), #imageLiteral(resourceName: "709e38db7637c2bd20f35073a96a45cc")
    ]
    
    private var imageIndex = 0
    private let animationDuratin: TimeInterval = 0.25
    private let switchingInterval: TimeInterval = 3
    private var transition = CATransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isHidden = true
        setImage(for: imageIndex)
        
    }
    
    
    private func setImage(for index: Int) {
        let image = images[index]
        rootView.setImage(image)
    }

}

