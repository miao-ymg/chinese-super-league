//
//  TeamModelContainer.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 03.01.25.
//

import SwiftData
import os

@MainActor
let teamsContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Team.self)

        // Check if the SwiftData DB is empty
        var itemFetchDescriptor = FetchDescriptor<Team>()
        itemFetchDescriptor.fetchLimit = 1

        guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else {
            Logger().info("Info: Teams DB is already pre-populated")
            return container
        }

        Logger().info("Info: Pre-populating teams DB for the first time...")

        let teams = [
            Team(id: "BEIJING", idApi: 830, nameShort: "Beijing Guoan"),
            Team(id: "CHANGCHUN", idApi: 834, nameShort: "Changchun YT"),
            Team(id: "CHENGDU", idApi: 5648, nameShort: "Chengdu RC"),
            Team(id: "DALIAN", idApi: 21263, nameShort: "Dalian YB"),
            Team(id: "HENAN", idApi: 840, nameShort: "Henan FC"),
            Team(id: "MEIZHOU", idApi: 1439, nameShort: "Meizhou HK"),
            Team(id: "QINGDAO_WESTCOAST", idApi: 17265, nameShort: "Qingdao WC"),
            Team(id: "QINGDAO_HAINIU", idApi: 1431, nameShort: "Qingdao HN"),
            Team(id: "SHANDONG", idApi: 844, nameShort: "Shandong TS"),
            Team(id: "SHANGHAI_PORT", idApi: 836, nameShort: "Shanghai Port"),
            Team(id: "SHANGHAI_SHENHUA", idApi: 833, nameShort: "Shanghai SH"),
            Team(id: "SHENZHEN", idApi: 5686, nameShort: "Shenzhen PC"),
            Team(id: "TIANJIN", idApi: 837, nameShort: "Tianjin JMT"),
            Team(id: "WUHAN", idApi: 5695, nameShort: "Wuhan 3T"),
            Team(id: "YUNNAN", idApi: 21265, nameShort: "Yunnan YK"),
            Team(id: "ZHEJIANG", idApi: 848, nameShort: "Zhejiang FC")
        ]

        for team in teams {
            container.mainContext.insert(team)
        }
        return container

    } catch {
        fatalError("ERROR: Failed to create container")
    }
}()
