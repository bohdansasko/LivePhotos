//
//  LPPhotosRepository.swift
//  LivePhotos
//
//  Created by Office Mac on 1/26/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import PromiseKit
import Photos

protocol LPPhotosRepository {
    func fetchLivePhotos() -> Promise<[PHLivePhoto]>
}

final class LPLocalPhotosRepository {
    
    private let _photosAPI: LPLocalLivePhotosService
    private let _storage: LPPhotosStorage
    
    init(photosAPI: LPLocalLivePhotosService, storage: LPPhotosStorage) {
        _photosAPI = photosAPI
        _storage = storage
    }
    
}

// MARK: - LPPhotosRepository

extension LPLocalPhotosRepository: LPPhotosRepository {
    
    func fetchLivePhotos() -> Promise<[PHLivePhoto]> {
        let assets = _storage.fetchLivePhotoAssets()
        let photos = _photosAPI.fetchPhotos(by: assets)
        return photos
    }
    
}
