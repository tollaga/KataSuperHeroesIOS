//
//  SuperHero+Test.swift
//  KataSuperHeroesTests
//
//  Created by Jose Gil on 13/09/2019.
//  Copyright © 2019 GoKarumi. All rights reserved.
//

@testable import KataSuperHeroes
import Fakery

extension SuperHero: Equatable {
    public static func == (lhs: SuperHero, rhs: SuperHero) -> Bool {
        return (lhs.name == rhs.name && lhs.photo == rhs.photo && lhs.isAvenger == rhs.isAvenger && lhs.description == rhs.description)
    }
    
    public static func random(name: String = Faker().name.name(),
                              photo: URL? = URL(string: Faker().internet.image()),
                              isAvenger: Bool = Faker().number.randomBool(),
                              description: String = Faker().lorem.paragraph()) -> SuperHero {
        return SuperHero(name: name, photo: photo, isAvenger: isAvenger, description: description)
    }
    
}
