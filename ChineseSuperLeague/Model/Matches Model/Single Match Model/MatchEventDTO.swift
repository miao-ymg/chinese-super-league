//
//  MatchEventDTO.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 06.08.26.
//

struct MatchEventDTO: Decodable {
    let seqNumber: Int
    let timeElapsed: EventTimeDTO
    let eventType: String
    let team: String
    let eventTypeData: EventTypeDataDTO

    private enum CodingKeys: CodingKey {
        case seqNumber, timeElapsed, eventType, team
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        seqNumber = try container.decode(Int.self, forKey: .seqNumber)
        timeElapsed = try container.decode(EventTimeDTO.self, forKey: .timeElapsed)
        eventType = try container.decode(String.self, forKey: .eventType)
        team = try container.decode(String.self, forKey: .team)

        // Decode event-type-specific properties
        eventTypeData = switch eventType {
        case "goal":    .goal(try GoalEventDTO(from: decoder))
        case "card":    .card(try CardEventDTO(from: decoder))
        case "sub":     .sub(try SubstitutionEventDTO(from: decoder))
        case "var":     .video(try VideoAssistEventDTO(from: decoder))
        case "miss":    .miss(try MissEventDTO(from: decoder))
        default:        .unknown
        }
    }
}

struct EventTimeDTO: Decodable {
    let regular: Int
    let added: Int?
}

enum EventTypeDataDTO {
    case goal(GoalEventDTO)
    case card(CardEventDTO)
    case sub(SubstitutionEventDTO)
    case video(VideoAssistEventDTO)
    case miss(MissEventDTO)
    case unknown
}

// --- Event-type-specific DTOs ---

struct GoalEventDTO: Decodable {
    let goalType: String
    let goalscorer: NamedEntityDTO
    let assist: NamedEntityDTO?
    let newScore: HomeAwayValuesDTO
}

struct CardEventDTO: Decodable {
    let cardType: String
    let player: NamedEntityDTO
    let missesNextMatch: Bool
}

struct SubstitutionEventDTO: Decodable {
    let playerIn: NamedEntityDTO
    let playerOut: NamedEntityDTO
    let reason: String?
}

struct VideoAssistEventDTO: Decodable {
    let decision: String
    let reason: String?
}

struct MissEventDTO: Decodable {
    let missType: String
    let player: NamedEntityDTO
}
