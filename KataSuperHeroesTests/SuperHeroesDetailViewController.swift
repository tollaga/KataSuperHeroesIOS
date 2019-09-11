//
//  SuperHeroesTableViewController.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 13/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import KIF
import Nimble
import UIKit
@testable import KataSuperHeroes

class SuperHeroesDetailViewControllerTests: AcceptanceTestCase {
    
    fileprivate let repository = MockSuperHeroesRepository()

    func testShowsSuperHeroNameAsTitle() {
        let superHero = givenASuperHeroWithName()
        
        openSuperHeroDetailViewController(superHero.name)
        
        tester().waitForView(withAccessibilityLabel: superHero.name)
    }
    
    func testShowsSuperHeroUser() {
        let superHero = givenASuperHeroWithName()
        
        openSuperHeroDetailViewController(superHero.name)
        
        let userLabel = tester().waitForView(withAccessibilityLabel: "Name: \(superHero.name)") as? UILabel
        
        expect(userLabel?.isHidden).to(beFalse())
    }

    func testShowsSuperHeroUserWithContent() {
        let superHero = givenASuperHeroWithName()
        
        openSuperHeroDetailViewController(superHero.name)
        
        let userLabel = tester().waitForView(withAccessibilityLabel: "Name: \(superHero.name)") as? UILabel
        
        expect(userLabel?.text).to(equal(superHero.name))
    }

    func testShowsSuperHeroDescription() {
        let superHero = givenASuperHeroWithName()
        
        openSuperHeroDetailViewController(superHero.name)

        let descriptionLabel = tester().waitForView(withAccessibilityLabel: "Description: \(superHero.name)") as? UILabel
        
        expect(descriptionLabel?.isHidden).to(beFalse())
    }
    
    func testShowsSuperHeroDescriptionWithContent() {
        let superHero = givenASuperHeroWithName()
        
        openSuperHeroDetailViewController(superHero.name)
        
        let descriptionLabel = tester().waitForView(withAccessibilityLabel: "Description: \(superHero.name)") as? UILabel
        
        expect(descriptionLabel?.text).to(equal(superHero.description))
    }
    
    func testShowSuperHeroImageIfThereIsSuperHero() {
        let image = try? UIImage(data: Data(contentsOf: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg")!))?.pngData()
        
        let superHero = givenASuperHeroWithName()
        
        openSuperHeroDetailViewController(superHero.name)
        
        let photoImageView = tester().waitForView(withAccessibilityLabel: "SuperHero Image") as? UIImageView
        
        expect(photoImageView?.image?.pngData()).to(equal(image))
    }
    
    func testDoesNotShowAvengersBadgeIfTheHeroIsNotPartOfTheAvengersTeam() {
        let superHero = givenASuperHeroWithName(false)
        
        openSuperHeroDetailViewController(superHero.name)
        
        tester().waitForAbsenceOfView(withAccessibilityLabel: "Avengers Badge")
    }
    
    func testShowsAvengersBadgeIfTheSuperHeroIsPartOfTheAvengersTeam() {
        let superHero = givenASuperHeroWithName(true)
        
        openSuperHeroDetailViewController(superHero.name)
        
        tester().waitForView(withAccessibilityLabel: "Avengers Badge")
    }

    fileprivate func givenASuperHeroWithName(_ isAvenger: Bool = false) -> SuperHero {
        let superHero = SuperHero(name: "Mr. Clean",
                                  photo: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg"),
                                  isAvenger: isAvenger, description: "Description")
        repository.superHeroes = [superHero]
        return superHero
    }
    
    @discardableResult
    fileprivate func openSuperHeroDetailViewController(_ superHeroName: String) -> SuperHeroDetailViewController {
        let superHeroDetailViewController = ServiceLocator()
            .provideSuperHeroDetailViewController(superHeroName) as! SuperHeroDetailViewController
        superHeroDetailViewController.presenter = SuperHeroDetailPresenter(
            ui: superHeroDetailViewController,
            superHeroName: superHeroName,
            getSuperHeroByName: GetSuperHeroByName(repository: repository))
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroDetailViewController]
        present(viewController: rootViewController)
        tester().waitForAnimationsToFinish()
        return superHeroDetailViewController
    }
}
