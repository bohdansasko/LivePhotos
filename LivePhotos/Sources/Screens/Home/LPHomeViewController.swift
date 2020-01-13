//
//  ViewController.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit
import PromiseKit

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
    
        setupNavigationBar()
        fetchPhotos()
    }

}

// MARK: - Setup methods

private extension LPHomeViewController {
    
    func setupNavigationBar() {
        navigationController!.navigationBar.isHidden = true
    }
    
}

// MARK: - Set methods

private extension LPHomeViewController {
    
    func setImage(for index: Int) {
        let image = images[index]
        log.debug(image)
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

// MARK: - API

private extension LPHomeViewController {
    
    func fetchPhotos() {
        rootView.activityIndicator.startAnimating()
        _photosService.fetchPhotos()
            .done { [weak self] photos in
                guard let self = self else { return }
                self.images = photos
                self.setImage(for: self.imageIndex)
            }
            .catch { [weak self] err in
                guard let self = self else { return }
                let errMsg = LPErrorMessage(title: "Loading Photos", message: err.localizedDescription)
                self.handleError(errMsg)
            }.finally { [weak self] in
                self?.rootView.activityIndicator.stopAnimating()
            }
    }
    
}
