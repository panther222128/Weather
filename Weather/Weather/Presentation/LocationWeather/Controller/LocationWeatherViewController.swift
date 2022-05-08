//
//  SecondViewController.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/06.
//

import UIKit

final class LocationWeatherViewController: UIViewController {
    
    @IBOutlet weak var todayWeatherInformationView: WeatherInformationView!
    @IBOutlet weak var tomorrowWeatherInformationView: WeatherInformationView!
    
    static let storyboardName = "Main"
    static let storyboardID = "LocationWeatherViewControllerID"
    
    private var locationWeatherViewModel: LocationWeatherViewModel!
    
    lazy var dataLoadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.view.addSubview(self.dataLoadingActivityIndicator)
    }
    
    static func create(with viewModel: LocationWeatherViewModel) -> LocationWeatherViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID) as? LocationWeatherViewController else { return LocationWeatherViewController() }
        viewController.locationWeatherViewModel = viewModel
        return viewController
    }
    
    private func bind() {
        self.locationWeatherViewModel.locationWeathersStorage.bind { [weak self] in
            self?.hideViews()
            guard let self = self else { return }
            guard let data = $0 else { return }
            self.configure(locationWeathers: data)
            self.dataLoadingActivityIndicator.stopAnimating()
            self.presentViews()
        }
        self.locationWeatherViewModel.isError.bind { [weak self] isError in
            guard let self = self else { return }
            guard let error = self.locationWeatherViewModel.error.value else { return }
            self.presentErrorAlert(of: error)
        }
    }
    
    private func presentErrorAlert(of error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        let addErrorAlertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(addErrorAlertAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
}

extension LocationWeatherViewController {
    
    private func configure(locationWeathers: [LocationWeather]) {
        self.todayWeatherInformationView.dateTitleLabel.text = "Today"
        self.todayWeatherInformationView.weatherStateNameLabel.text = "\(locationWeathers[0].weatherStateName)"
        self.todayWeatherInformationView.temperatureLabel.text = "\(Int(locationWeathers[0].temperature))°C"
        self.todayWeatherInformationView.humidityLabel.text = "\(locationWeathers[0].humidity)%"
        let todayWeatherImageUrlString = ImageHotlink.hotlink + locationWeathers[0].weatherStateAbbreviation + ".png"
        self.todayWeatherInformationView.weatherStateImageView.loadImageUsingUrlString(urlString: todayWeatherImageUrlString)
        
        self.tomorrowWeatherInformationView.dateTitleLabel.text = "Tomorrow"
        self.tomorrowWeatherInformationView.weatherStateNameLabel.text = "\(locationWeathers[1].weatherStateName)"
        self.tomorrowWeatherInformationView.temperatureLabel.text = "\(Int(locationWeathers[1].temperature))°C"
        self.tomorrowWeatherInformationView.humidityLabel.text = "\(locationWeathers[1].humidity)%"
        let tomorrowWeatherImageUrlString = ImageHotlink.hotlink + locationWeathers[1].weatherStateAbbreviation + ".png"
        self.tomorrowWeatherInformationView.weatherStateImageView.loadImageUsingUrlString(urlString: tomorrowWeatherImageUrlString)
    }
    
}

extension LocationWeatherViewController {
    
    private func hideViews() {
        self.todayWeatherInformationView.isHidden = true
        self.tomorrowWeatherInformationView.isHidden = true
    }
    
    private func presentViews() {
        self.todayWeatherInformationView.isHidden = false
        self.tomorrowWeatherInformationView.isHidden = false
    }
    
}
