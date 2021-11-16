//
//  KeychainHelper.swift
//  Vortex Mortgage
//
//  Created by Alex Thompson on 6/18/20.
//  Copyright © 2020 BloomTech. All rights reserved.
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
    
    
    // MARK: Keychain access
    
    func readItem() throws -> String {
        var query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard status != errSecItemNotFound else { throw
            KeychainError.noPassword }
        
        guard status == noErr else { throw KeychainError.unhandledError }
        
        guard let existingItem = queryResult as? [String: AnyObject],
        let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
        
            else {
                throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
    
    func saveItem(_ password: String) throws {
        
        let encodedPassword = password.data(using: String.Encoding.utf8)!
        
        do {
            try _ = readItem()
            
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?
            
            let query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            guard status == noErr else { throw KeychainError.unhandledError
                
            }
            
        } catch KeychainError.noPassword {
            var newItem = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedPassword as AnyObject?
            
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            guard status == noErr else { throw KeychainError.unhandledError
                
            }
        }
    }
    
    func deleteItem() throws {
        let query = KeychainItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == noErr || status == errSecItemNotFound else { throw
            KeychainError.unhandledError }
    }
    
    // MARK: Convenience
    
    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String: AnyObject] {
        
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
    
    static var currentUserIdentifier: String {
        do {
            let storedIdentifier = try KeychainItem(service: bundleIdentifier, account: "userIdentifier").readItem()
            return storedIdentifier
            
        } catch {
            return ""
        }
    }
    
    static func deleteUserIdentifierFromKeychain() {
        do {
            try KeychainItem(service: bundleIdentifier, account: "userIdentifier").deleteItem()
        } catch {
            print("Unable to delete userIdentifier from keychain unfortunatly")
        }
    }
}

extension KeychainItem {
    static var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? "com.ChristianLorenzo.Vortex-Mortgage"
    }
    
    static var userid: String? {
        get {
            return try? KeychainItem(service: bundleIdentifier, account: "userid").readItem()
        }
        set {
            guard let value = newValue else {
                try? KeychainItem(service: bundleIdentifier, account: "userid").deleteItem()
                return
            }
            do {
                try KeychainItem(service: bundleIdentifier, account: "userid").saveItem(value)
            } catch {
                print("Unable to save userIdentifier to keychain.")
            }
        }
    }
    
    //Get and Set Current User First Name. Set nil to delete.
    static var firstName: String? {
        get {
            return try? KeychainItem(service: bundleIdentifier, account: "firstName").readItem()
        }
        set {
            guard let value = newValue else {
                try? KeychainItem(service: bundleIdentifier, account: "firstName").deleteItem()
                return
            }
            do {
                try KeychainItem(service: bundleIdentifier, account: "firstName").saveItem(value)
            } catch {
                print("Unable to save userFirstName to keychain.")
            }
        }
    }
    
    //Get and Set Current User Last Name. Set nil to delete.
    static var lastName: String? {
        get {
            return try? KeychainItem(service: bundleIdentifier, account: "lastName").readItem()
        }
        set {
            guard let value = newValue else {
                try? KeychainItem(service: bundleIdentifier, account: "lastName").deleteItem()
                return
            }
            do {
                try KeychainItem(service: bundleIdentifier, account: "lastName").saveItem(value)
            } catch {
                print("Unable to save userLastName to keychain.")
            }
        }
    }
    
    
    //Get and Set Current User Email. Set nil to delete.
    static var email: String? {
        get {
            return try? KeychainItem(service: bundleIdentifier, account: "email").readItem()
        }
        set {
            guard let value = newValue else {
                try? KeychainItem(service: bundleIdentifier, account: "email").deleteItem()
                return
            }
            do {
                try KeychainItem(service: bundleIdentifier, account: "email").saveItem(value)
            } catch {
                print("Unable to save userEmail to keychain.")
            }
        }
    }
}

