//
//  CollectionViewCell.swift
//  LivePhotos
//
//  Created by Office Mac on 1/26/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit
import PhotosUI
import Photos

final class LPPhotoViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var livePhotoView: LPLivePhotoView!
    
    var livePhoto: PHLivePhoto? {
        set { livePhotoView.livePhoto = newValue }
        get { return livePhotoView.livePhoto }
    }

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
