//
//  SuperHeroesViewControllerTests.swift
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

class SuperHeroesViewControllerTests: AcceptanceTestCase {

    fileprivate let repository = MockSuperHeroesRepository()

    func testShowsEmptyCaseIfThereAreNoSuperHeroes() {
        givenThereAreNoSuperHeroes()

        openSuperHeroesViewController()

        tester().waitForView(withAccessibilityLabel: "¯\\_(ツ)_/¯")
    }
    
    func testShowLoading() {
        let numberOfSuperHeroes = 1
        
        _ = givenThereAreSomeSuperHeroes(numberOfSuperHeroes)
        
        tester().waitForView(withAccessibilityLabel: "LoadingView")
    }
    
    func testHideLoadingViewIfThereAreSomeSuperHeroes() {
        let numberOfSuperHeroes = 1
        
        _ = givenThereAreSomeSuperHeroes(numberOfSuperHeroes)
        
        openSuperHeroesViewController()
        
        tester().waitForAbsenceOfView(withAccessibilityLabel: "LoadingView")
    }
    
    func testShowsSuperHeroesCaseIfThereAreSuperHeroes() {
        let numberOfSuperHeroes = 10
        
        givenThereAreSuperHeroes(numberOfSuperHeroes)
        
        let viewController = openSuperHeroesViewController()
    
        for i in 0..<numberOfSuperHeroes {
            tester().waitForCell(at: IndexPath(item: i, section: 0), in: viewController.tableView)
        }
    }
    
    func testShowSuperHeroNameIfThereIsSuperHero() {
        let numberOfSuperHeroes = 1
        let superHeroName = "SuperHero - 0"
        
        givenThereAreSuperHeroes(numberOfSuperHeroes)
        
        let viewController = openSuperHeroesViewController()
        
        let cell = tester().waitForCell(at: IndexPath(item: 0, section: 0), in: viewController.tableView) as! SuperHeroTableViewCell
        
        expect(cell.nameLabel.text).to(equal(superHeroName))
    }
    
    func testShowSuperHeroImageIfThereIsSuperHero() {
        let numberOfSuperHeroes = 1
        let image = try? UIImage(data: Data(contentsOf: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg")!))?.pngData()
        
        givenThereAreSuperHeroes(numberOfSuperHeroes)
        
        let viewController = openSuperHeroesViewController()
        
        let cell = tester().waitForCell(at: IndexPath(item: 0, section: 0), in: viewController.tableView) as! SuperHeroTableViewCell
        
        expect(cell.photoImageView?.image?.pngData()).to(equal(image))
    }
    
    func testShowSuperHeroBadgeIfThereIsSuperHero() {
        let numberOfSuperHeroes = 1
        
        _ = givenThereAreSomeSuperHeroes(numberOfSuperHeroes, avengers: true)
        
        let viewController = openSuperHeroesViewController()
        
        let cell = tester().waitForCell(at: IndexPath(item: 0, section: 0), in: viewController.tableView) as! SuperHeroTableViewCell
    
        expect(cell.avengersBadgeImageView.isHidden).to(beFalse())
    }
    
    func testHideSuperHeroBadgeIfThereIsSuperHero() {
        let numberOfSuperHeroes = 1
        
        _ = givenThereAreSomeSuperHeroes(numberOfSuperHeroes)
        
        let viewController = openSuperHeroesViewController()
        
        let cell = tester().waitForCell(at: IndexPath(item: 0, section: 0), in: viewController.tableView) as! SuperHeroTableViewCell
        
        expect(cell.avengersBadgeImageView.isHidden).to(beTrue())
    }
    
    func testShowSuperHeroDetailIfTapped() {
        let numberOfSuperHeroes = 1
        _ = givenThereAreSomeSuperHeroes(numberOfSuperHeroes)
       
        openSuperHeroesViewController()
        
        tester().tapRow(at: IndexPath(row: numberOfSuperHeroes-1, section: 0),
                        inTableViewWithAccessibilityIdentifier: "SuperHeroesTableView")
        
        tester().waitForView(withAccessibilityLabel:"SuperHero - 0")
    }
    
    // MARK: -

    fileprivate func givenThereAreNoSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(0)
    }
    
    fileprivate func givenThereAreSuperHeroes(_ numberOfSuperHeroes: Int) {
        _ = givenThereAreSomeSuperHeroes(numberOfSuperHeroes)
    }


    fileprivate func givenThereAreSomeSuperHeroes(_ numberOfSuperHeroes: Int = 10,
        avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "SuperHero - \(i)",
                photo: NSURL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg") as URL?,
                isAvenger: avengers, description: "Description - \(i)")
            superHeroes.append(superHero)
        }
        repository.superHeroes = superHeroes
        return superHeroes
    }

    @discardableResult
    fileprivate func openSuperHeroesViewController() -> SuperHeroesViewController {
        let superHeroesViewController = ServiceLocator()
            .provideSuperHeroesViewController() as! SuperHeroesViewController
        superHeroesViewController.presenter = SuperHeroesPresenter(ui: superHeroesViewController,
                getSuperHeroes: GetSuperHeroes(repository: repository))
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroesViewController]
        present(viewController: rootViewController)
        tester().waitForAnimationsToFinish()
        return superHeroesViewController
    }
}
