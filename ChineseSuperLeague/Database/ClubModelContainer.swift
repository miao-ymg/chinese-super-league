//
//  ClubModelContainer.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 03.01.25.
//

import SwiftData
import os

@MainActor
let clubContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Club.self)

        // Check if the SwiftData DB is empty
        var itemFetchDescriptor = FetchDescriptor<Club>()
        itemFetchDescriptor.fetchLimit = 1

        guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else {
            Logger().info("Info: Club DB is already pre-populated")
            return container
        }

        Logger().info("Info: Pre-populating club DB for the first time...")

        let clubs = [
            Club(id: "BEIJING", idApi: 830, nameShort: "Beijing Guoan"),
            Club(id: "CHANGCHUN", idApi: 834, nameShort: "Changchun YT"),
            Club(id: "CHENGDU", idApi: 5648, nameShort: "Chengdu RC"),
            Club(id: "DALIAN", idApi: 21263, nameShort: "Dalian YB"),
            Club(id: "HENAN", idApi: 840, nameShort: "Henan FC"),
            Club(id: "MEIZHOU", idApi: 1439, nameShort: "Meizhou HK"),
            Club(id: "QINGDAO_WESTCOAST", idApi: 17265, nameShort: "Qingdao WC"),
            Club(id: "QINGDAO_HAINIU", idApi: 1431, nameShort: "Qingdao HN"),
            Club(id: "SHANDONG", idApi: 844, nameShort: "Shandong TS"),
            Club(id: "SHANGHAI_PORT", idApi: 836, nameShort: "Shanghai Port"),
            Club(id: "SHANGHAI_SHENHUA", idApi: 833, nameShort: "Shanghai SH"),
            Club(id: "SHENZHEN", idApi: 5686, nameShort: "Shenzhen PC"),
            Club(id: "TIANJIN", idApi: 837, nameShort: "Tianjin JMT"),
            Club(id: "WUHAN", idApi: 5695, nameShort: "Wuhan 3T"),
            Club(id: "YUNNAN", idApi: 21265, nameShort: "Yunnan YK"),
            Club(id: "ZHEJIANG", idApi: 848, nameShort: "Zhejiang FC")
        ]

        for club in clubs {
            container.mainContext.insert(club)
        }
        return container

    } catch {
        fatalError("ERROR: Failed to create container")
    }
}()
