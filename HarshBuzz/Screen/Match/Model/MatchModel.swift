//
//  MatchModel.swift
//  HarshBuzz
//
//  Created by My Mac Mini on 13/02/24.
//

import Foundation
 
 
import Foundation

struct MatchModel: Codable {

    let Matchdetail: Matchdetail
    let Teams: TeamData
    let Notes: Notes
    let Innings: [Innings]

}

struct Innings: Codable {
    let Number: String
    let Total: String
    let Wickets: String
    let Overs: String
   
}

struct Matchdetail: Codable {
    
    let Match: Match
    let Series: Series
    let Venue: Venue
    let Result: String
    let PlayerMatch: String
    
    private enum CodingKeys: String, CodingKey {
        
        case Match,Venue,Result,Series
        case PlayerMatch = "Player_Match"
        
    }
    
    
}

struct Match: Codable {

    let Livecoverage: String
    let Id: String
    let Code: String
    let League: String
    let Number: String
    let TypeField: String
    let Date: String
    let Time: String
    let Offset: String
    let Daynight: String
    
    enum CodingKeys: String, CodingKey {
      
        case TypeField = "Type"
        case Livecoverage,Id,Code,Date,League,Time,Number,Offset,Daynight
        
    }
    
}
struct Venue: Codable {

    let Id: String
    let Name: String

}
struct Series: Codable {

    let Id: String
    let TourName: String
    enum CodingKeys: String, CodingKey {
        case Id
        case TourName = "Tour_Name"
    }

}
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?

    init(stringValue: String) {
        self.stringValue = stringValue
    }

    init(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}

struct TeamData: Codable{
    let firstTeam: FirstTeam
    let secondTeam: SecondTeam

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var firstTeamKey: String?
        var secondTeamKey: String?
 
        for key in container.allKeys {
            if let intValue = Int(key.stringValue), intValue % 2 == 0 {
                firstTeamKey = key.stringValue
            } else {
                secondTeamKey = key.stringValue
            }
        }
 
        firstTeam = try container.decode(FirstTeam.self, forKey: DynamicCodingKeys(stringValue: firstTeamKey ?? ""))
        secondTeam = try container.decode(SecondTeam.self, forKey: DynamicCodingKeys(stringValue: secondTeamKey ?? ""))
    }
}
 
struct FirstTeam: Codable {
    let nameFull: String
    let nameShort: String
    let players: [String: Player]

    private enum CodingKeys: String, CodingKey {
        case nameFull = "Name_Full"
        case nameShort = "Name_Short"
        case players = "Players"
    }
}

struct SecondTeam: Codable {
    let nameFull: String
    let nameShort: String
    let players: [String: Player]

    private enum CodingKeys: String, CodingKey {
        case nameFull = "Name_Full"
        case nameShort = "Name_Short"
        case players = "Players"
    }
}
 

struct Player: Codable {
    let position: String
    let nameFull: String
    let isCaptain: Bool?
    let isKeeper: Bool?
    let batting: BattingStats
    let bowling: BowlingStats?

    private enum CodingKeys: String, CodingKey {
        case position = "Position"
        case nameFull = "Name_Full"
        case isCaptain = "Iscaptain"
        case isKeeper = "Iskeeper"
        case batting = "Batting"
        case bowling = "Bowling"
    }
}

struct BattingStats: Codable {
    let style: String
    let average: String
    let strikeRate: String
    let runs: String

    private enum CodingKeys: String, CodingKey {
        case style = "Style"
        case average = "Average"
        case strikeRate = "Strikerate"
        case runs = "Runs"
    }
}

struct BowlingStats: Codable {
    let style: String
    let average: String
    let economyRate: String
    let wickets: String

    private enum CodingKeys: String, CodingKey {
        case style = "Style"
        case average = "Average"
        case economyRate = "Economyrate"
        case wickets = "Wickets"
    }
}


struct Notes: Codable {
   let firstInningHighlights: [String]
   let secondInningHighlights: [String]
   enum CodingKeys: String, CodingKey {
     
       case firstInningHighlights = "1"
       case secondInningHighlights = "2"
       
   }
}
 

