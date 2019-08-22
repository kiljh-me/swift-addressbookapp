//
//  Contact.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/22/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import Foundation
import Contacts

struct ContactDTO {
    private let name: String
    private let tel: String
    private let email: String?
    private let image: Data?
    
    init(contact: CNContact) {
        self.name = contact.familyName + " " + contact.givenName
        self.tel = (contact.phoneNumbers[0].value ).stringValue
        
        if let emailAddress = contact.emailAddresses.first {
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
    
    func getName() -> String {
        return name
    }
    func getTel() -> String {
        return tel
    }
    func getEmail() -> String? {
        return email
    }
    func getImage() -> Data? {
        return image
    }
}
