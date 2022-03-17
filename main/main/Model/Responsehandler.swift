//
//  Responsehandler.swift
//  main
//
//  Created by Andy on 2022/3/17.
//

import Foundation

// MARK: - Welcome
public struct Responsehandler<T>: Codable where T: Codable {
    let getVector: T
}

// MARK: - GetVector
public struct GetVector: Codable {
    let items: [NewsItem]
}

// MARK: - NewsItem
public struct NewsItem: Codable {
    let type: String
    let title: String?
    let _meta: Meta?
    let style: String?
    let items: [ApperanceItem]?
    let source: String?
    let ref: String?
    let appearance: Appearance?
    let extra: Extra?
    
    public var createdDate: Date? {
        guard let time = extra?.created else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(time))
    }
}

// MARK: - ItemItem
public struct ApperanceItem: Codable {
    let type: String
    let source: String
    let ref: String
    let appearance: Appearance
    let extra: Extra
    let _meta: Meta
}
// MARK: - Appearance
public struct Appearance: Codable {
    let mainTitle: String?
    let subTitle: String?
    let thumbnail: String?
    let appearanceSubscript: String?
    
    enum CodingKeys: String, CodingKey {
        case mainTitle, subTitle, thumbnail
        case appearanceSubscript = "subscript"
    }

}



// MARK: - Extra
struct Extra: Codable {
    let created: Int?
    let extraDescription: String?
}


// MARK: - Meta
struct Meta: Codable {
    let section: String
    let category: [String]
}


