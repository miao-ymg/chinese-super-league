//
//  ClubModelContainer.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.04.26.
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
            Club(id: "BEIJING", idApi: 243648644304690, nameShort: "Beijing Guoan"),
            Club(id: "CHENGDU", idApi: 347550392128893, nameShort: "Chengdu RC"),
            Club(id: "CHONGQING", idApi: 364059303202682, nameShort: "Chongqing TLL"),
            Club(id: "DALIAN", idApi: 131245727453769, nameShort: "Dalian YB"),
            Club(id: "HENAN", idApi: 351763246366879, nameShort: "Henan FC"),
            Club(id: "LIAONING", idApi: 138736837032722, nameShort: "Liaoning TR"),
            Club(id: "QINGDAO_WESTCOAST", idApi: 279365726737681, nameShort: "Qingdao WC"),
            Club(id: "QINGDAO_HAINIU", idApi: 116258301028942, nameShort: "Qingdao HN"),
            Club(id: "SHANDONG", idApi: 299685784399792, nameShort: "Shandong TS"),
            Club(id: "SHANGHAI_PORT", idApi: 233196699786207, nameShort: "Shanghai Port"),
            Club(id: "SHANGHAI_SHENHUA", idApi: 210551171745140, nameShort: "Shanghai SH"),
            Club(id: "SHENZHEN", idApi: 194067536343288, nameShort: "Shenzhen PC"),
            Club(id: "TIANJIN", idApi: 248650751065326, nameShort: "Tianjin JMT"),
            Club(id: "WUHAN", idApi: 327820802634988, nameShort: "Wuhan 3T"),
            Club(id: "YUNNAN", idApi: 352858520299133, nameShort: "Yunnan YK"),
            Club(id: "ZHEJIANG", idApi: 122673939733235, nameShort: "Zhejiang FC")
        ]

        for club in clubs {
            container.mainContext.insert(club)
        }
        return container

    } catch {
        fatalError("ERROR: Failed to create container")
    }
}()
