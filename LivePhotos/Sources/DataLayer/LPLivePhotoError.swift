//
//  LPLivePhotoError.swift
//  LivePhotos
//
//  Created by Office Mac on 1/25/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Foundation

enum LPLivePhotoError: Error {
    case unknownSavingError
    case missingImageAsset
    case missingVideoAsset
}

extension LPLivePhotoError {
    
    var localizedDescription: String {
        switch self {
        case .unknownSavingError:
            return "UNKNOWN_SAVING_ERROR".localized
        case .missingImageAsset:
            return "MISSING_IMAGE_ASSET_ERROR".localized
        case .missingVideoAsset:
            return "MISSING_VIDEO_ASSET_ERROR".localized
        }
        
    }
    
}
