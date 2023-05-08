//
//  NetworkServicesTest.swift
//  SporteroTests
//
//  Created by Asalah Sayed on 08/05/2023.
//

import XCTest
@testable import Sportero
final class NetworkServicesTest: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchLeaguesResult() {
        let expectation = expectation(description: "Waiting for Api")
        let network = NetworkServices()
        network.fetchLeaguesResult(sport: "football"){ result in
            guard let leagues = result else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(leagues.result.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchFixturesResult() {
        let expectation = expectation(description: "Waiting for Api")
        let network = NetworkServices()
        network.fetchFixturesResult(sport: "football" , leagueId: 4){ result in
            guard let fixtures = result else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(fixtures.result?.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchLiveScoreResult() {
        let expectation = expectation(description: "Waiting for Api")
        let network = NetworkServices()
        network.fetchLiveScoreResult(sport: "football" , leagueId: 257){ result in
            guard let liveScore = result else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(liveScore.result?.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchCricketLiveScoreResult() {
        let expectation = expectation(description: "Waiting for Api")
        let network = NetworkServices()
        network.fetchCricketLivescoreResult(leagueId: 8435){ result in
            guard let liveScore = result else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(liveScore.result.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchTeamsResult() {
        let expectation = expectation(description: "Waiting for Api")
        let network = NetworkServices()
        network.fetchTeamsResult(sport: "football",leagueId: 4){ result in
            guard let teams = result else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(teams.result.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchSingleTeamResult() {
        let expectation = expectation(description: "Waiting for Api")
        let network = NetworkServices()
        network.fetchSingleTeamResult(sport: "football",teamId: 74){ result in
            guard let team = result else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(team.result.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchTennisPlayerResult() {
        let expectation = expectation(description: "Waiting for Api")
        let network = NetworkServices()
        network.fetchTennisPlayerResult(playerId: 37799){ result in
            guard let player = result else{
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertNotEqual(player.result.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    
}
