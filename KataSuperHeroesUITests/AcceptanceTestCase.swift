//
//  Created by Jose Gil <jose.gil@tollaga.com> on 13/03/2020.
//  Copyright © 2020 Tollaga. All rights reserved.
//

import Foundation
import KIF

class AcceptanceTestCase: KIFTestCase {

    fileprivate var originalRootViewController: UIViewController?
    fileprivate var rootViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }

        set(newRootViewController) {
            UIApplication.shared.keyWindow?.rootViewController = newRootViewController
        }
    }

    override func tearDown() {
        super.tearDown()
        if let originalRootViewController = originalRootViewController {
            rootViewController = originalRootViewController
        }
    }

    func present(viewController: UIViewController) {
        originalRootViewController = rootViewController
        rootViewController = viewController
    }
}
