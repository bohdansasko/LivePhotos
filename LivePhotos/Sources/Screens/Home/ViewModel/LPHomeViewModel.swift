//
//  LPPhotosScrollView.swift
//  LivePhotos
//
//  Created by Bogdan Sasko on 14.01.2020.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Photos
import RxSwift
import RxRelay
import PromiseKit

final class LPHomeViewModel: LPHomeViewModelAble {
    
    private let _photosRepository: LPPhotosRepository

    private let _items = BehaviorRelay<[PHLivePhoto]>(value: [])
    private let _isActivityIndicatorAnimation = BehaviorRelay(value: false)
    private let _isSaveButtonEnabled = BehaviorRelay(value: true)
    private let _savedStatusMessage = PublishSubject<String>()
    private let _errorMessage = PublishSubject<LPErrorMessage>()
    
    // MARK: - Lifecycle
    
    init(photosRepository: LPPhotosRepository) {
        _photosRepository = photosRepository
    }
    
    func item(at indexPath: IndexPath) -> PHLivePhoto {
        let item = _items.value[indexPath.row]
        return item
    }
    
}

// MARK: - Getters

extension LPHomeViewModel {
    
    var numberOfItems: Int {
        return _items.value.count
    }
    
    var kPagePadding: CGFloat {
        return 10
    }
    
}

// MARK: - Rx Getters

extension LPHomeViewModel {
    
    var isActivityIndicatorAnimation: Observable<Bool> {
        return _isActivityIndicatorAnimation.asObservable()
    }
    
    var isSaveButtonEnabled: Observable<Bool> {
        return _isSaveButtonEnabled.asObservable()
    }
    
    
    var items: Observable<[PHLivePhoto]> {
        return _items.asObservable()
    }
    
    var savedPhotoStatusMessage: Observable<String> {
        return _savedStatusMessage.asObservable()
    }
    
    var errorMessage: Observable<LPErrorMessage> {
        return _errorMessage.asObservable()
    }
    
}

// MARK: - API

extension LPHomeViewModel {
    
    func fetchPhotos() {
        _isActivityIndicatorAnimation.accept(true)
        
        _photosRepository.fetchLivePhotos()
            .done { [weak self] photos in
                guard let self = self else { return }
                self._items.accept(photos)
            }
            .catch { [weak self] err in
                guard let self = self else { return }
                
                let message: String?
                if let e = err as? LPLivePhotoError {
                    message = e.localizedDescription
                } else {
                    message = err.localizedDescription
                }
                
                let errMsg = LPErrorMessage(title: "LOADING_PHOTOS".localized, message: message)
                self._errorMessage.onNext(errMsg)
            }.finally { [weak self] in
                self?._isActivityIndicatorAnimation.accept(false)
            }
    }
    
    func saveLivePhoto(_ livePhoto: PHLivePhoto) {
        _isActivityIndicatorAnimation.accept(true)
        _isSaveButtonEnabled.accept(false)
        
        _photosRepository.savePhoto(livePhoto)
            .done { [weak self] success in
                let localizedStatusKey: String
                if success {
                    localizedStatusKey = "SUCCESFULLY_SAVED_PHOTO_TO_GALLERY"
                } else {
                    localizedStatusKey = "ERROR_SAVED_PHOTO_TO_GALLERY"
                }
                self?._savedStatusMessage.onNext(localizedStatusKey.localized)
            }
            .catch { [weak self] err in
                guard let self = self else { return }
                
                let message: String?
                if let e = err as? LPLivePhotoError {
                    message = e.localizedDescription
                } else {
                    message = err.localizedDescription
                }
                
                let errMsg = LPErrorMessage(title: "HOME_SCREEN_TITLE".localized, message: message)
                self._errorMessage.onNext(errMsg)
            }.finally { [weak self] in
                guard let self = self else { return }
                self._isActivityIndicatorAnimation.accept(false)
                self._isSaveButtonEnabled.accept(true)
            }
    }
    
}
