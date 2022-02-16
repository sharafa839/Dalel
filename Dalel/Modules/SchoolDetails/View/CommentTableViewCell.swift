//
//  CommentTableViewCell.swift
//  Dalel
//
//  Created by Shgardi on 16/02/2022.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var commentLabe: UILabel!
    @IBOutlet weak var DummyImage: UIImageView!
    @IBOutlet weak var _1stButton: UIButton!
    @IBOutlet weak var _2stButton: UIButton!
    @IBOutlet weak var _3stButton: UIButton!
    @IBOutlet weak var _4stButton: UIButton!
    @IBOutlet weak var _5stButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(review:ReviewsModelPayload){
        nameLabel.text = review.reviewableType
        date.text = DateAndTimeInString(date: review.createdAt ?? "", local: "en_US").1
        averageRate(rate: review.rate ?? "0")
        commentLabe.text = review.review
    }
    
    func DateAndTimeInString(date: String,local:String) -> (String,String) {
        let fromDateFormatter = DateFormatter()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: local)
        dateFormatter.dateStyle = .long
        timeFormatter.locale = Locale(identifier: local)
        timeFormatter.dateFormat = "HH:mm"
        fromDateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        guard  let date = fromDateFormatter.dateFromMultipleFormats(fromString: date) else {return ("","")}
        let createdDay = date.stringDate(withFormat: "dd-MM-yyyy")
        return (createdDay,timeFormatter.string(from: date))
    }
    
    private func averageRate(rate:String){
        switch rate {
        case "1":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .gray
            _3stButton.imageView?.tintColor = .gray
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case "2":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .gray
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case "3":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        case "4":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .systemYellow
            _5stButton.imageView?.tintColor = .gray
            
        case "5":
            _1stButton.imageView?.tintColor = .systemYellow
            _2stButton.imageView?.tintColor = .systemYellow
            _3stButton.imageView?.tintColor = .systemYellow
            _4stButton.imageView?.tintColor = .systemYellow
            _5stButton.imageView?.tintColor = .systemYellow
            
        default:
            _1stButton.imageView?.tintColor = .gray
            _2stButton.imageView?.tintColor = .gray
            _3stButton.imageView?.tintColor = .gray
            _4stButton.imageView?.tintColor = .gray
            _5stButton.imageView?.tintColor = .gray
        }
    }
}
extension DateFormatter {
    func dateFromMultipleFormats(fromString dateString: String) -> Date? {
        let formats: [String] = [
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSZ",
            "yyyy-MM-dd'T'HH:mm:ss.SZ",
            "yyyy-MM-dd'T'HH:mm:SSZ",
            "yyyy-MM-dd'T'HH:mm:SZ",
            "yyyy-MM-dd'T'HH:mm"
        ]
        for format in formats {
            self.dateFormat = format
            timeZone = TimeZone.init(secondsFromGMT: 0)
            locale = Locale(identifier: "en_US")
            if let date = self.date(from: dateString) {
                return date
            }
        }
        return nil
    }
}
extension Date {
    
    func getCurrentDate(timeZone : String) -> Date!{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        let localDate = dateFormatter.date(from:  Date().description)
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        guard localDate != nil else { return nil}
        return dateFormatter.date(from: "\(localDate!)")
    }

    
    func stringDate(withFormat format:String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
    
    
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
