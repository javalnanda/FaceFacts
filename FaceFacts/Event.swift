//
//  Event.swift
//  FaceFacts
//
//  Created by Javal Nanda on 22/12/23.
//

import Foundation
import SwiftData

@Model
class Event {
    var name: String
    var location: String
    var people = [Person]()

    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
