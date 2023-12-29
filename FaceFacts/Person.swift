//
//  Person.swift
//  FaceFacts
//
//  Created by Javal Nanda on 22/12/23.
//

import Foundation
import SwiftData

@Model
class Person {
    var name: String
    var emailAdress: String
    var details: String
    var metAt: Event?
    @Attribute(.externalStorage) var photo: Data?

    init(name: String, emailAdress: String, details: String, metAt: Event? = nil) {
        self.name = name
        self.emailAdress = emailAdress
        self.details = details
        self.metAt = metAt
    }
}
