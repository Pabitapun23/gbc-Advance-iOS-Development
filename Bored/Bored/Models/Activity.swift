//
//  Activity.swift
//  Bored
//
//  Created by J Patel on 2024-03-07.
//

import Foundation

struct Activity : Codable{
    var activityName : String?
    var type : String?
    
    init(){
        self.activityName = "Sit back and relax"
        self.type = "relaxation"
    }
    
    init(activityName: String? = nil, type: String? = nil) {
        self.activityName = activityName
        self.type = type
    }
    
    enum ActivityKeys: String, CodingKey{
        case activity
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActivityKeys.self)
        
        self.activityName = try container.decodeIfPresent(String.self, forKey: .activity)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing to encode
    }
}
