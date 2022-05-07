//
//  ViewFlowCoordinator.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import UIKit

protocol ViewFlowCoordinatorDependencies {
    func makeWeatherSearchViewController(action: WeatherSearchViewModelAction) -> WeatherSearchViewController
    func makeLocationWeatherViewController(woeid: Int) -> LocationWeatherViewController
}

final class ViewFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: ViewFlowCoordinatorDependencies
    
    private weak var weatherSearchViewController: WeatherSearchViewController?
    
    init(navigationController: UINavigationController, dependencies: ViewFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let action = WeatherSearchViewModelAction(showLocationWeather: showLocationView(index:woeid:))
        let viewController = dependencies.makeWeatherSearchViewController(action: action)
        self.navigationController?.pushViewController(viewController, animated: true)
        self.weatherSearchViewController = viewController
    }
    
    func showLocationView(index: Int, woeid: Int) {
        let viewController = dependencies.makeLocationWeatherViewController(woeid: woeid)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
