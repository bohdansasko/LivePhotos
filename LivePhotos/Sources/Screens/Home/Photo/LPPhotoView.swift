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
    
              fileprivate      var isAnimation: Bool = false
    
    var livePhoto: PHLivePhoto? {
        set {
            livePhotoView.livePhoto = newValue
//            actDoubleTap(self)
        }
        get { return livePhotoView.livePhoto }
    }
    
}

private extension LPPhotoView {
    
    @IBAction func actDoubleTap(_ sender: Any) {
//        livePhotoView.delegate = self
        isAnimation.toggle() 
        if isAnimation {
//            livePhotoView.startPlayback(with: .hint)
        } else {
//            livePhotoView.stopPlayback()
        }
    }
    
}
