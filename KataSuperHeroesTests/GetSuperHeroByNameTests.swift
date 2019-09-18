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
    
    fileprivate let repository = MockSuperHeroesRepository()
    
    func test_execute_givenASuperHeroInRepository_shouldReturnTheSameSuperHero() {
        let superHero = givenASuperHero()
        
        GetSuperHeroByName(repository: repository).execute(superHero.name) { superHeroByName in
            expect(superHero).to(equal(superHeroByName))
        }
    }
    
    
    func test_excute_giveEmptyRepository_shouldReturnNull() {
        givenEmptyRepository()
        
          GetSuperHeroByName(repository: repository).execute("test") { superHeroByName in
            expect(superHeroByName).to(beNil())
        }
    }
    
    fileprivate func givenASuperHero() -> SuperHero {
        let superHero = SuperHero(name: "Mr. Clean",
                                  photo: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg"),
                                  isAvenger: false, description: "Description")
        repository.superHeroes = [superHero]
        return superHero
    }
    
    fileprivate func givenEmptyRepository() -> Void {
        repository.superHeroes = []
    }
    
}
