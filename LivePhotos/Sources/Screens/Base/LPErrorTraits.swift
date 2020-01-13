//
//  LPErrorTraits.swift
//  LivePhotos
//
//  Created by Bogdan Sasko on 14.01.2020.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

protocol LPErrorTraits {
    func handleError(_ errorMsg: LPErrorMessage)
    func showAlert(title: String?, message: String?, comment: String?)
    func showAlert(title: String?, message: String?, comment: String?, okTitle: String?, okActionHandler: ((UIAlertAction) -> Void)?)
}

extension LPErrorTraits where Self: UIViewController {
    
    func handleError(_ errorMsg: LPErrorMessage) {
        showAlert(title: errorMsg.title, message: errorMsg.message, comment: nil)
    }
    
    func showAlert(title: String?, message: String?, comment: String?) {
        showAlert(title: title, message: message, comment: comment, okTitle: "OK".localized, okActionHandler: nil)
    }
    
    func showAlert(title: String?, message: String?, comment: String?, okTitle: String?, okActionHandler: ((UIAlertAction) -> Void)?) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okActionHandler)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: nil)
    }
    
}
