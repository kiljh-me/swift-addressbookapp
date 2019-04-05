//
//  Contacts.swift
//  AddressBookApp
//
//  Created by 조재흥 on 19. 4. 1..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation
import Contacts

class Addresses {
    
    private var contacts = [String: Addresses]()
    
    init() {
        MGCContactStore.sharedInstance.fetchContacts { (contacts) in
            self.contacts += contacts
            self.sort()
            NotificationCenter.default.post(name: .updatedContacts, object: self)
        }
    }
    
    func count() -> Int {
        return self.contacts.count
    }
    
    func mgcContact(with number: Int) -> MGCContact? {
        guard 0 <= number, number < contacts.count else { return nil }
        let cnContact = contacts[number]
        let mgcContact = MGCContactStoreUtilities().parse(cnContact)
        return mgcContact
    }
    
    func sort() {
        let familyNameSortDescriptor = NSSortDescriptor(key: CNContact.familyNameSortKey, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let givenNameSortDescriptor = NSSortDescriptor(key: CNContact.givenNameSortKey, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        let sortDescriptors = [familyNameSortDescriptor, givenNameSortDescriptor]
        let sortedContacts = (contacts as NSArray).sortedArray(using: sortDescriptors)
        guard let contacts = sortedContacts as? [CNContact] else { return }
        self.contacts = contacts
    }
}

extension NSNotification.Name {
    static let updatedContacts = Notification.Name(rawValue: "updatedContacts")
}

extension CNContact {
    static let familyNameSortKey = "familyName"
    static let givenNameSortKey = "givenName"
}