//
//  MokeNetworkServicesTests.swift
//  SporteroTests
//
//  Created by Asalah Sayed on 08/05/2023.
//

import XCTest
@testable import Sportero

final class MokeNetworkServicesTests: XCTestCase {
    let networkService = MokeNetworkServices()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testLeaguesDecoding() {
        networkService.fetchLeaguesResult(sport: "football"){ result in
            guard let leagues = result else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(leagues.result.count, 0)
        }
    }
    func testFixturesDecoding() {
        networkService.fetchFixturesResult(sport: "football", leagueId: 4){ result in
            guard let fixtures = result else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(fixtures.result?.count, 0)
        }
    }
    func testLiveScoreDecoding() {
        networkService.fetchLiveScoreResult(sport: "football", leagueId: 257){ result in
            guard let liveScore = result else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(liveScore.result?.count, 0)
        }
    }
    func testCricketLiveScoreDecoding() {
        networkService.fetchCricketLivescoreResult(leagueId: 257){ result in
            guard let cricketLiveScore = result else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(cricketLiveScore.result.count, 0)
        }
    }
    func testTeamsDecoding() {
        networkService.fetchTeamsResult(sport: "football", leagueId: 257){ result in
            guard let teams = result else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(teams.result.count, 0)
        }
    }
    func testSingleTeamDecoding() {
        networkService.fetchSingleTeamResult(sport: "football", teamId: 74){ result in
            guard let singleTeam = result else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(singleTeam.result.count, 0)
        }
    }
    func testTennisPlayerDecoding() {
        networkService.fetchTennisPlayerResult(playerId: 37799){ result in
            guard let tennisPlayer = result else{
                XCTFail()
                return
            }
            XCTAssertNotEqual(tennisPlayer.result.count, 0)
        }
    }

    

}
