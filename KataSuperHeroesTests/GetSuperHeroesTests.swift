//
//  GetSuperHeroesTests.swift
//  KataSuperHeroesTests
//
//  Created by Jose Gil on 13/09/2019.
//  Copyright © 2019 GoKarumi. All rights reserved.
//

import XCTest
import Nimble
@testable import KataSuperHeroes

class GetSuperHeroesTests: XCTestCase {

    fileprivate let repository = InMemorySuperHeroesRepository()

    func test_execute_givenOnlyOneSuperHeroInRepository_shouldReturnTheSameSuperHero() {
        let superHero = givenASuperHeroInTheRepository()
        
        GetSuperHeroes(repository: repository).execute { (superHeroes) in
            expect(superHeroes).to(equal([superHero]))
        }
    }
    
    func test_execute_giveEmptyRepository_shouldReturnEmpty() {
        givenEmptyRepository()
        
        GetSuperHeroes(repository: repository).execute { (superHeroes) in
            expect(superHeroes).to(equal([]))
        }
    }
    
    fileprivate func givenASuperHeroInTheRepository() -> SuperHero {
        let superHero = SuperHero.random()
        repository.superHeroes = [superHero]
        return superHero
    }
    
    fileprivate func givenEmptyRepository() -> Void {
        repository.superHeroes = []
    }

}
