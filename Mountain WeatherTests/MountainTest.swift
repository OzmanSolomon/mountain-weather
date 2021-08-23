//
//  MountainTest.swift
//  Mountain WeatherTests
//
//  Created by Osman Solomon on 22/08/2021.
//

import XCTest
import RealmSwift
@testable import Mountain_Weather

class MountainTest: XCTestCase {
    var persistenceManager: PersistenceManager!
    var apiManager:ApiManager!
    var environmentManager:EnvironmentManager!
    var weatherListPresenter: WeatherListPresenterProtocol!
    var weatherListInteractor: WeatherListInteractor!
    var settingPresenter: SettingPresenterProtocol!
    var settingInteractor: SettingsInteractorProtocol!
    var detailScreenPresenter: DetailScreenPresenterProtocol!
    var detailsInteractor: DetailsInteractorProtocol!
    var store:AppState!
    
    override func setUpWithError() throws {
        persistenceManager = PersistenceManager()
        environmentManager = EnvironmentManager()
        weatherListInteractor = WeatherListInteractor()
        weatherListPresenter = WeatherListPresenter()
        settingInteractor = SettingsInteractor()
        settingPresenter = SettingPresenter()
        detailScreenPresenter = DetailScreenPresenter()
        detailsInteractor = DetailsInteractor()
        apiManager = ApiManager()
        store = AppState.shared
    }
    
    override func tearDownWithError() throws {
        persistenceManager = nil
        environmentManager = nil
        apiManager = nil
        weatherListInteractor = nil
        weatherListPresenter = nil
        settingInteractor = nil
        settingPresenter = nil
        detailScreenPresenter = nil
        detailsInteractor = nil
        store = AppState()
    }
    
    func test_interactor(){
        let expectation = self.expectation(description: "interactor")
        XCTAssertNotNil(store.state)
        weatherListInteractor.fetchWeather{
            expectation.fulfill()
        }
        waitForExpectations(timeout:9, handler: nil)
        XCTAssertNotEqual(store.state,  WeatherStateEnum.loading)
      
    }
    
    func test_Presenter_faild(){
        store.state = .idle
        weatherListPresenter.WeatherListFaild(error: "error")
        XCTAssertEqual(store.state,  WeatherStateEnum.failed("error"))
    }
    
    func test_temp() {
        store.unit = 0
        XCTAssertNotNil(weatherListPresenter.temp(temp: "21"))
        store.unit = 1
        XCTAssertNotNil(weatherListPresenter.temp(temp: "21"))
    }
    
    func test_save_local_weather() throws{
        let list = [WeatherListModel]()
        let model = WeatherBaseModel(cod: nil, message: nil, cnt: nil, list: nil, city:nil )
        XCTAssertNoThrow(try weatherListInteractor.saveLocalWeather(list: list, model: model))
    }
    
    func test_get_local_weather() throws{
        XCTAssertNoThrow(try weatherListInteractor.getLocalWeather())
    }
    
    func test_presistence() throws {
        let model = weatherLocalModel()
        XCTAssertNoThrow(try persistenceManager.presistence(model: [model]))
    }
    
    func test_unpresistence() throws {
        XCTAssertNoThrow(try persistenceManager.unpresistence(model: weatherLocalModel.self))
    }
    
    func test_clean_presistence() throws {
        XCTAssertNoThrow(try persistenceManager.cleanPresistenced(model: weatherLocalModel.self))
    }
    
    func test_get_local_data(){
        let expectation = self.expectation(description: "get_local_data")
        store.state = .idle
        let localData = try! PersistenceManager().unpresistence(model:weatherLocalModel.self )
        weatherListPresenter.gotLocalDataSuccessfully(localData:localData, action: {  expectation.fulfill()})
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotEqual(store.state, WeatherStateEnum.idle)
    }
    
    func test_url(){
        XCTAssertEqual(apiManager.iconUrl(id: "id"), "http://openweathermap.org/img/wn/id@2x.png")
        XCTAssertEqual(apiManager.baseUrl(), "https://api.openweathermap.org/data/2.5/forecast?q=Dubai&mode=json&appid=3bdd4bb0592c7314f5eb78bf4a92f3be&units=metric")
        
    }
    func test_env(){
        XCTAssertEqual(PlistKey.value(.apiKey)(), "apiKey")
        XCTAssertEqual(environmentManager.configuration(PlistKey.apiKey), "3bdd4bb0592c7314f5eb78bf4a92f3be")
    }
    
    func test_api_error(){
        var myError:Error?
        var response:Data?
        let expectation = self.expectation(description: "apiCall")
        apiManager.getMethod(url: "" , withSuccess: { (data,error,statusCode)   in
            response = data
            expectation.fulfill()
        })
        { (error) in
            myError = error
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(myError)
        XCTAssertNil(response)
    }
    
    func test_api_no_error(){
        var myError:Error?
        var response:Data?
        let expectation = self.expectation(description: "apiCall")
        apiManager.getMethod(url: apiManager.baseUrl() , withSuccess: { (data,error,statusCode)   in
            response = data
            expectation.fulfill()
        })
        { (error) in
            myError = error
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(myError)
        XCTAssertNotNil(response)
    }
    
    func testSearchResponse() throws {
        guard let path = Bundle.main.path(forResource: "josnFile", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(WeatherBaseModel.self, from: data)
            XCTAssertEqual(response.city?.name, "Dubai")
            XCTAssertEqual(response.cod, "200")
            XCTAssertEqual(response.message, 0)
            XCTAssertEqual(response.list?.count, 40)
            let repo = response.list?.first
            XCTAssertEqual(repo?.wind?.speed,3.31)
        } catch {
            print(error)
        }
    }
    
    
}
