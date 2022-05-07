//
//  FirstViewModel.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import Foundation

struct WeatherSearchViewModelAction {
    typealias Woeid = Int
    typealias IndexPathRow = Int
    let showLocationWeather: ((Woeid, IndexPathRow) -> Void)
}

protocol WeatherSearchViewModel {
    var searchResultsStorage: Observable<[LocationSearchResult]> { get }
    var isError: Observable<Bool> { get }
    var error: Observable<Error?> { get }
    
    func didSearch(using searchKeyword: String)
    func didSelectItem(at index: Int, woeid: Int)
}

final class DefaultWeatherSearchViewModel: WeatherSearchViewModel {
    
    let searchResultsStorage: Observable<[LocationSearchResult]>
    let isError: Observable<Bool>
    let error: Observable<Error?>

    private let weatherSearchUseCase: WeatherSearchUseCase
    private let action: WeatherSearchViewModelAction
    
    init(weatherSearchUseCase: WeatherSearchUseCase, action: WeatherSearchViewModelAction) {
        self.weatherSearchUseCase = weatherSearchUseCase
        self.searchResultsStorage = Observable([])
        self.isError = Observable(false)
        self.error = Observable(nil)
        self.action = action
    }
    
    private func fetchSearchResult(searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], Error>) -> Void) {
        self.weatherSearchUseCase.excuteSearch(with: searchKeyword) { result in
            switch result {
            case .success(let data):
                self.searchResultsStorage.value = data
                completion(.success(data))
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                completion(.failure(error))
            }
        }
    }

    private func load(with searchKeyword: String) {
        self.fetchSearchResult(searchKeyword: searchKeyword) { result in
            switch result {
            case .success(let data):
                self.searchResultsStorage.value = data
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
            }
        }
    }
    
    private func resetData() {
        self.searchResultsStorage.value.removeAll()
    }

    private func update(using searchKeyword: String) {
        self.resetData()
        self.load(with: searchKeyword)
    }
    
    func didSearch(using searchKeyword: String) {
        self.update(using: searchKeyword)
    }
    
    func didSelectItem(at index: Int, woeid: Int) {
        action.showLocationWeather(index, self.searchResultsStorage.value[index].woeid)
    }

}
