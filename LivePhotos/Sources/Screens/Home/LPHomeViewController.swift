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
    
    private let _photosService: LPLivePhotosService

    private var images: [LPLivePhoto] = []
    private var imageIndex = 0
    
    // MARK: - Lifecycle

    init(photosService: LPLivePhotosService) {
        _photosService = photosService
        
        super.init(LPHomeViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = _photosService.fetchPhotos()
        setupUI()
    }

}

// MARK: - Setup methods

private extension LPHomeViewController {
    
    func setupNavigationBar() {
        navigationController!.navigationBar.isHidden = true
    }
    
    func setupUI() {
        setupNavigationBar()
        setImage(for: imageIndex)
    }
    
}

// MARK: - Set methods

private extension LPHomeViewController {
    
    func setImage(for index: Int) {
        let image = images[index]
    }
    
}


// MARK: - User interactions

private extension LPHomeViewController {
    
    @IBAction func actSwipeLeft(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actSwipeRight(_ sender: Any) {
        print(#function)
    }
    
}
