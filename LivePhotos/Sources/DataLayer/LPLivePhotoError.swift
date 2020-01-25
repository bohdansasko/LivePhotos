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
}

extension LPLivePhotoError {
    
    var localizedDescription: String {
        switch self {
        case .unknownSavingError:
            return "UNKNOWN_SAVING_ERROR".localized
        }
    }
    
}
