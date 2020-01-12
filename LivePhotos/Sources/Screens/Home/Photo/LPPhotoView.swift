//
//  LPPhotoView.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

final class LPPhotoView: LPBaseView {
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    var image: UIImage? {
        set { imageView.image = newValue }
        get { return imageView.image }
    }
}
