//
//  SuperHero+Equtable.swift
//  KataSuperHeroesTests
//
//  Created by Jose Gil on 13/09/2019.
//  Copyright © 2019 GoKarumi. All rights reserved.
//

@testable import KataSuperHeroes

extension SuperHero: Equatable {
    public static func == (lhs: SuperHero, rhs: SuperHero) -> Bool {
        return (lhs.name == rhs.name && lhs.photo == rhs.photo && lhs.isAvenger == rhs.isAvenger && lhs.description == rhs.description)
    }
}
