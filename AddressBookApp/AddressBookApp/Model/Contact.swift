//
//  Contact.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/22/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import Foundation
import Contacts

struct Contact: Comparable {
    private let familyName: String?
    private let givenName: String?
    private let tel: String?
    private let email: String?
    private let image: Data?
    
    init(contact: CNContact) {
        self.familyName = contact.familyName
        self.givenName = contact.givenName
        
        if contact.phoneNumbers.count > 0 {
            self.tel = (contact.phoneNumbers[0].value ).stringValue
        } else {
            self.tel = nil
        }
        
        if contact.emailAddresses.count > 0, let emailAddress = contact.emailAddresses.first {
            self.email = emailAddress.value as String
        } else {
            self.email = nil
        }
        
        if let imageData = contact.imageData {
            self.image = imageData
        } else {
            self.image = nil
        }
    }
    
    func getFamilyName() -> String? {
        return familyName
    }
    
    func getGivenName() -> String? {
        return givenName
    }
    
    func getName() -> String {
        guard let givenName = givenName else {
            return familyName ?? ""
        }
        guard let familyName = familyName else {
            return givenName
        }
        
        return familyName + " " + givenName
    }
    
    func getTel() -> String? {
        return tel
    }
    
    func getEmail() -> String? {
        return email
    }
    
    func getImage() -> Data? {
        return image
    }
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        guard lhs.getFamilyName() == rhs.getFamilyName() else {
            return lhs.getFamilyName() ?? "" < rhs.getFamilyName() ?? ""
        }
        return lhs.getGivenName() ?? "" < rhs.getGivenName() ?? ""
    }
    
    func searchWord(_ word: String) -> Bool {
        let firstInitialExtractor = FirstInitialExtractor()
        
        guard let familyName = familyName else {
            return false
        }
        
        if word.first == familyName.first {
            return true
        }
        
        let inputFirstIntial = firstInitialExtractor.extract(string: word)
        let familyNameFirstIntial = firstInitialExtractor.extract(string: familyName)
        
        
        if inputFirstIntial.first == word.first {
            return inputFirstIntial == familyNameFirstIntial
        }
        
        return false
    }
}
