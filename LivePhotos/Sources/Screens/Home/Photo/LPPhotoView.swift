//
//  LPPhotoView.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PhotosUI

final class LPLivePhotoView: PHLivePhotoView {
    
}

final class LPPhotoView: LPBaseView {
    @IBOutlet fileprivate weak var livePhotoView: LPLivePhotoView!
    
    var livePhoto: PHLivePhoto? {
        set { livePhotoView.livePhoto = newValue }
        get { return livePhotoView.livePhoto }
    }
    
}
