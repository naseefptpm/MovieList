//
//  ResponseModelClass.swift  
//
//  Created by codeteki private Ltd on 21/12/20.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieResponse = try MovieResponse(json)

import Foundation

// MARK: - MovieResponse
class MovieResponse: Codable {
    var search: [Search]?
    var totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }

    init(search: [Search]?, totalResults: String?, response: String?) {
        self.search = search
        self.totalResults = totalResults
        self.response = response
    }
}

// MARK: MovieResponse convenience initializers and mutators

extension MovieResponse {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(MovieResponse.self, from: data)
        self.init(search: me.search, totalResults: me.totalResults, response: me.response)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        search: [Search]?? = nil,
        totalResults: String?? = nil,
        response: String?? = nil
    ) -> MovieResponse {
        return MovieResponse(
            search: search ?? self.search,
            totalResults: totalResults ?? self.totalResults,
            response: response ?? self.response
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Search
class Search: Codable {
    var title, year, imdbID, type: String?
    var poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }

    init(title: String?, year: String?, imdbID: String?, type: String?, poster: String?) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
}

// MARK: Search convenience initializers and mutators

extension Search {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Search.self, from: data)
        self.init(title: me.title, year: me.year, imdbID: me.imdbID, type: me.type, poster: me.poster)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        title: String?? = nil,
        year: String?? = nil,
        imdbID: String?? = nil,
        type: String?? = nil,
        poster: String?? = nil
    ) -> Search {
        return Search(
            title: title ?? self.title,
            year: year ?? self.year,
            imdbID: imdbID ?? self.imdbID,
            type: type ?? self.type,
            poster: poster ?? self.poster
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
