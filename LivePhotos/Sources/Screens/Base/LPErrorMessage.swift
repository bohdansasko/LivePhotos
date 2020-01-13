//
//  TAErrorMessage.swift
//  LivePhotos
//
//  Created by Bogdan Sasko on 13.01.2020.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Foundation

struct LPErrorMessage: Error {
    var id: UUID
    var title: String?
    var message: String?
    
    init(title: String?, message: String?) {
        self.id      = UUID()
        self.title   = title
        self.message = message
    }
    
}
