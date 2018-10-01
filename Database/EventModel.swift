//
//  EventModel.swift
//  Database
//
//  Created by kiran on 9/28/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import Foundation
class EventModel {
    var eventName: String?
    
    init(name: NSDictionary) {
        self.eventName = name["name"] as? String
    }
}
