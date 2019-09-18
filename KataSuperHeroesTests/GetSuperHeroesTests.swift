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

    fileprivate let repository = MockSuperHeroesRepository()

    func test_execute_givenOnlyOneSuperHeroInRepository_shouldReturnTheSameSuperHero() {
        let superHero = givenASuperHero()
        
        GetSuperHeroes(repository: repository).execute { (superHeroes) in
            expect(superHeroes).to(equal([superHero]))
        }
    }
    
    func test_excute_giveEmptyRepository_shouldReturnEmpty() {
        givenEmptyRepository()
        
        GetSuperHeroes(repository: repository).execute { (superHeroes) in
            expect(superHeroes).to(equal([]))
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
