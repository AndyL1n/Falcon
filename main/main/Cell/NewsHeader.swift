//
//  NewsHeader.swift
//  main
//
//  Created by Andy on 2022/3/17.
//

import UIKit

class NewsHeader: UICollectionReusableView {
    static let id = "NewsHeaderID"
    static let height: CGFloat = 50
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func config(with title: String) {
        titleLabel.text = title
    }
}
