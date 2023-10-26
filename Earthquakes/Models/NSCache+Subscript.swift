//
//  NSCache+Subscript.swift
//  Earthquakes-iOS
//
//  Created by Данил Шипицын on 26.10.2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    subscript(_ url: URL) -> CacheEntry? {
        get {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let object = CacheEntryObject(entry: entry)
                setObject(object, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
