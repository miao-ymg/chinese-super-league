//
//  TeamModelContainer.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.04.26.
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
            Team(id: "BEIJING", idApi: 243648644304690, nameShort: "Beijing Guoan"),
            Team(id: "CHENGDU", idApi: 347550392128893, nameShort: "Chengdu RC"),
            Team(id: "CHONGQING", idApi: 364059303202682, nameShort: "Chongqing TLL"),
            Team(id: "DALIAN", idApi: 131245727453769, nameShort: "Dalian YB"),
            Team(id: "HENAN", idApi: 351763246366879, nameShort: "Henan FC"),
            Team(id: "LIAONING", idApi: 138736837032722, nameShort: "Liaoning TR"),
            Team(id: "QINGDAO_WESTCOAST", idApi: 279365726737681, nameShort: "Qingdao WC"),
            Team(id: "QINGDAO_HAINIU", idApi: 116258301028942, nameShort: "Qingdao HN"),
            Team(id: "SHANDONG", idApi: 299685784399792, nameShort: "Shandong TS"),
            Team(id: "SHANGHAI_PORT", idApi: 233196699786207, nameShort: "Shanghai Port"),
            Team(id: "SHANGHAI_SHENHUA", idApi: 210551171745140, nameShort: "Shanghai SH"),
            Team(id: "SHENZHEN", idApi: 194067536343288, nameShort: "Shenzhen PC"),
            Team(id: "TIANJIN", idApi: 248650751065326, nameShort: "Tianjin JMT"),
            Team(id: "WUHAN", idApi: 327820802634988, nameShort: "Wuhan 3T"),
            Team(id: "YUNNAN", idApi: 352858520299133, nameShort: "Yunnan YK"),
            Team(id: "ZHEJIANG", idApi: 122673939733235, nameShort: "Zhejiang FC")
        ]

        for team in teams {
            container.mainContext.insert(team)
        }
        return container

    } catch {
        fatalError("ERROR: Failed to create container")
    }
}()
