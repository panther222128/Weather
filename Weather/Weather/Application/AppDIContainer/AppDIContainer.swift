//
//  AppDIContainer.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import Foundation

final class AppDIContainer {

    lazy var apiDataTransferService: DataTransferService = {
        let apiDataNetwork = DefaultNetworkService()
        return DefaultDataTransferService(networkService: apiDataNetwork)
    }()
    
    func makeSceneDIContainer() -> SceneDIContainer {
        let dependencies = SceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return SceneDIContainer(dependencies: dependencies)
    }
    
}
