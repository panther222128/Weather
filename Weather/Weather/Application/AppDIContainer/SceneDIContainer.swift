//
//  SceneDIContainer.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import UIKit

final class SceneDIContainer: ViewFlowCoordinatorDependencies {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeViewFlowCoordinator(navigationController: UINavigationController) -> ViewFlowCoordinator {
        return ViewFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - WeatherSearch
    
    private func makeWeatherSearchRepository() -> WeatherSearchRepository {
        return DefaultWeatherSearchRepository(dataTransferService: self.dependencies.apiDataTransferService)
    }
    
    private func makeWeatherSearchUseCase() -> WeatherSearchUseCase {
        return DefaultWeatherSearchUseCase(weatherSearchRepository: self.makeWeatherSearchRepository())
    }
    
    private func makeWeatherSearchViewModel(action: WeatherSearchViewModelAction) -> WeatherSearchViewModel {
        return DefaultWeatherSearchViewModel(weatherSearchUseCase: self.makeWeatherSearchUseCase(), action: action)
    }
    
    func makeWeatherSearchViewController(action: WeatherSearchViewModelAction) -> WeatherSearchViewController {
        return WeatherSearchViewController.create(with: self.makeWeatherSearchViewModel(action: action))
    }
    
    // MARK: - LocationWeather
    
    private func makeLocationWeatherRepository() -> LocationWeatherRepository {
        return DefaultLocationWeatherRepository(dataTransferService: self.dependencies.apiDataTransferService)
    }
    
    private func makeLocationWeatherUseCase() -> LocationWeatherUseCase {
        return DefaultLocationWeatherUseCase(locationWeatherRepository: self.makeLocationWeatherRepository())
    }
    
    private func makeLocationWeatherViewModel(woeid: Int) -> LocationWeatherViewModel {
        return DefaultLocationWeatherViewModel(woeid: woeid, locationWeatherUseCase: self.makeLocationWeatherUseCase())
    }
    
    func makeLocationWeatherViewController(woeid: Int) -> LocationWeatherViewController {
        return LocationWeatherViewController.create(with: self.makeLocationWeatherViewModel(woeid: woeid))
    }
}
