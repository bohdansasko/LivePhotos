//
//  LPHomeRootView.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

final class LPHomeRootView: LPBaseView {
    @IBOutlet fileprivate weak var imageView: UIImageView!
}


// MARK: - Set methods

extension LPHomeRootView {
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
}
