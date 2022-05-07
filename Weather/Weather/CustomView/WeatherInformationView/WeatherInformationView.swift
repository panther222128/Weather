//
//  WeatherInformation.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/06.
//

import UIKit

class WeatherInformationView: UIView {

    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var weatherStateImageView: CustomImageView!
    @IBOutlet weak var weatherStateNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadViewFromXib()
    }

    func loadViewFromXib(){
        let viewFromXib = Bundle.main.loadNibNamed("WeatherInformationView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
}
