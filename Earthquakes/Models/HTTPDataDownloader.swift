//
//  HTTPDataDownloader.swift
//  Earthquakes-iOS
//
//  Created by Данил Шипицын on 26.10.2023.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

let validStatus = 200...399

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: from) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw QuakeError.networkError
        }
        return data
    }
}
