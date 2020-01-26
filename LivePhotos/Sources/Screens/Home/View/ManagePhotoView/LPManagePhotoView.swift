//
//  LPManagePhotoView.swift
//  LivePhotos
//
//  Created by Office Mac on 1/26/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

protocol LPManagePhotoViewDelegate: class {
    func didActSaveButton(_ manageView: LPManagePhotoView)
}

final class LPManagePhotoView: UIView {
    @IBOutlet fileprivate weak var saveButton: UIButton!
    
    var delegate: LPManagePhotoViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSaveButton()
    }

}

// MARK: - Setup

private extension LPManagePhotoView {
    
    func setupSaveButton() {
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
    }
    
}


// MARK: - User interaction

private extension LPManagePhotoView {
    
    @IBAction func actSave(_ sender: Any) {
        delegate?.didActSaveButton(self)
    }
    
}
