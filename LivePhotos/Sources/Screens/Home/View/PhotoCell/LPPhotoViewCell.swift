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
    
    // MARK: - IBOutlets
    
    @IBOutlet fileprivate weak var livePhotoView: LPLivePhotoView!
    
    // MARK: - Properties
    
    var livePhoto: PHLivePhoto? {
        set { livePhotoView.livePhoto = newValue }
        get { return livePhotoView.livePhoto }
    }

    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        livePhotoView.stopPlayback()
    }

}

// MARK: - Help animation methods

extension LPPhotoViewCell {
    
    func hint() {
        livePhotoView.startPlayback(with: .hint)
    }
    
}
