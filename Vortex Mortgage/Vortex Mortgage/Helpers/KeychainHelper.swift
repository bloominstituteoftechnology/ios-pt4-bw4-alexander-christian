//
//  KeychainHelper.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct KeychainItem {
    
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError
    }
    
    // MARK: Properties
    
    let service: String
    
    private(set) var account: String
    
    let accessGroup: String?
    
    // MARK: Initialization
    
    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // MARK:
}
