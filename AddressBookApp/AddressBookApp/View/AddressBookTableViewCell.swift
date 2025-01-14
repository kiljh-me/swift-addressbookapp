//
//  AddressBookTableViewCell.swift
//  AddressBookApp
//
//  Created by joon-ho kil on 8/21/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class AddressBookTableViewCell: UITableViewCell {
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profile.image = UIImage(named: "addressbook-default-profile")
        nameLabel.text = nil
        emailLabel.text = nil
        telLabel.text = nil
    }

    func putInfo(contactDTO: Contact) {
        self.nameLabel.text = contactDTO.getName()
        
        if let telNumber = contactDTO.getTel() {
            self.telLabel.text = telNumber
        }
        
        if let emailAddress = contactDTO.getEmail() {
            self.emailLabel.text = emailAddress
        }
        
        if let imageData = contactDTO.getImage() {
            self.profile.image = UIImage(data: imageData)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.superview?.endEditing(true)
    }
}
