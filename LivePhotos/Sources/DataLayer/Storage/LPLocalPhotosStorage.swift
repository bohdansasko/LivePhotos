//
//  LPLocalPhotosStorage.swift
//  LivePhotos
//
//  Created by Office Mac on 1/25/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit
import Photos

final class LPLocalPhotosStorage {
    // do nothing
}

// MARK: - LPPhotosStorage

extension LPLocalPhotosStorage: LPPhotosStorage {
    
    func savePhoto(_ livePhoto: PHLivePhoto) -> Promise<Bool> {
        return Promise { seal in
            LivePhoto.extractResources(from: livePhoto, completion: { resources in
                guard let resources = resources else {
                    seal.reject(LPLivePhotoError.unknownSavingError)
                    return
                }
                LivePhoto.saveToLibrary(resources, completion: { s in
                    log.info("isSaved - \(s)")
                    seal.fulfill(s)
                })
            })
        }
    }
    
    func fetchLivePhotoAssets() -> [LPLiveAsset] {
        do {
            let plistURL = Bundle.main.url(
                forResource: LPConstants.kAssetsListFilename,
                withExtension: LPConstants.kAssetsListExt
            )!
            let data = try Data(contentsOf: plistURL)
            let value = try PropertyListDecoder().decode([LPLiveAsset].self, from: data)
            return value
        } catch (let err) {
            log.error(err)
        }
        return []
    }
    
}
