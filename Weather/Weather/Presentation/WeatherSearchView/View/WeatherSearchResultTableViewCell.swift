//
//  WeatherSearchResultTableViewCell.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/06.
//

import UIKit

class WeatherSearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherSearchResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(at index: Int, with locationSearchResults: [LocationSearchResult]) {
        self.weatherSearchResultLabel.text = locationSearchResults[index].title
    }
    
}
