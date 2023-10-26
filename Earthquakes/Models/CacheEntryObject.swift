//
//  CacheEntryObject.swift
//  Earthquakes-iOS
//
//  Created by Данил Шипицын on 26.10.2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

enum CacheEntry {
    case inProgress(Task<QuakeLocation, Error>)
    case ready(QuakeLocation)
}

final class CacheEntryObject {
    var entry: CacheEntry
    init(entry: CacheEntry) {
        self.entry = entry
    }
}
