//
//  NewsViewModel.swift
//  main
//
//  Created by Andy on 2022/3/17.
//

import Foundation
import Alamofire

public enum NewsType: String {
    case broken
    case carousel
    case divider
    case news
}

public class NewsViewModel {
    private var newsList: [NewsItem] = [] {
        didSet {
            var sectionName = ""
            newsList.filter { $0.type != NewsType.carousel.rawValue }.forEach {
                if $0.type == NewsType.divider.rawValue {
                    sectionName = $0.title ?? ""
                    dataSorce[sectionName] = []
                } else {
                    dataSorce[sectionName]?.append($0)
                }
            }
        }
    }
    
    public var dataSorce = [String: [NewsItem]]()
    
    public func fetchNewsList(complete: @escaping (() -> Void)) {
        request { [unowned self] result in
            switch result {
            case .success(let newsList):
                self.newsList = newsList
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            complete()
        }
    }
    
    
    private func request(complete: @escaping ((Result<([NewsItem]), Error>) -> Void)) {
        AF.request("https://static.mixerbox.com/interview/interview_get_vector.json").responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(Responsehandler<GetVector>.self, from: data)
                    complete(.success(items.getVector.items))
                } catch let error {
                    complete(.failure(error))
                }
            case .failure(let error):
                complete(.failure(error))
            }
        }
        
        
    }
}
