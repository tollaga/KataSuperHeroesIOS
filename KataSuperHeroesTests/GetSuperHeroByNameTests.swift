//
//  GetSuperHeroByNameTests.swift
//  KataSuperHeroesTests
//
//  Created by Jose Gil on 18/09/2019.
//  Copyright © 2019 GoKarumi. All rights reserved.
//

import XCTest
import Nimble
@testable import KataSuperHeroes

class GetSuperHeroByNameTests: XCTestCase {
    
    fileprivate let repository = InMemorySuperHeroesRepository()
    
    func test_execute_givenASuperHeroInRepository_shouldReturnTheSameSuperHero() {
        let superHero = givenASuperHeroInRepository()
        
        GetSuperHeroByName(repository: repository).execute(superHero.name) { superHeroByName in
            expect(superHero).to(equal(superHeroByName))
        }
    }
    
    
    func test_execute_giveEmptyRepository_shouldReturnNil() {
        givenEmptyRepository()
        
        GetSuperHeroByName(repository: repository).execute("test") { superHeroByName in
            expect(superHeroByName).to(beNil())
        }
    }
    
    fileprivate func givenASuperHeroInRepository() -> SuperHero {
        let superHero = SuperHero.random()
        repository.superHeroes = [superHero]
        return superHero
    }
    
    fileprivate func givenEmptyRepository() -> Void {
        repository.superHeroes = []
    }
    
}
