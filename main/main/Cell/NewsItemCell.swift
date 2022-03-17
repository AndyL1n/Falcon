//
//  NewsItemCell.swift
//  main
//
//  Created by Andy on 2022/3/17.
//

import UIKit
import Kingfisher

class NewsItemCell: UICollectionViewCell {
    static let id = "NewsItemCellID"
    static let height: CGFloat = 120
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var scriptLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        scriptLabel.adjustsFontSizeToFitWidth = true
    }

    public func config(with news: NewsItem) {
        guard let apperance = news.appearance else { return }
        
        contentLabel.text = apperance.mainTitle ?? ""
        datelabel.text = news.createdDate?.detailDateString ?? ""
        sourceLabel.text = apperance.subTitle ?? ""
        scriptLabel.text = apperance.appearanceSubscript
        
        if let thumbnailURL = URL(string: apperance.thumbnail ?? "") {
            thumbnailImageView.kf.setImage(with: thumbnailURL)
        }
    }
}

extension Date {
    public var detailDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.calendar = Calendar.current
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "MMM dd, yyyy 'at' HH:mm a"
        return formatter.string(from: self)
    }
}
