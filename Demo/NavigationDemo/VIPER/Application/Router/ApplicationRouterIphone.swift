import UIKit
import AvitoNavigation

final class ApplicationRouterIphone: BaseDemoRouter, ApplicationRouter {
    // MARK: - Private properties
    private let authorizationModuleTrackingService: AuthorizationModuleTrackingService
    
    // MARK: - Init
    init(authorizationModuleTrackingService: AuthorizationModuleTrackingService,
         assemblyFactory: AssemblyFactory,
         routerSeed: RouterSeed)
    {
        self.authorizationModuleTrackingService = authorizationModuleTrackingService
        
        super.init(assemblyFactory: assemblyFactory, routerSeed: routerSeed)
    }
    
    // MARK: - ApplicationRouter
    func authorizationStatus(completion: ((isPresented: Bool) -> ())) {
        let authorizationModuleExistsInHistory = authorizationModuleTrackingService.doesAuthorizationModuleExistInHistory()
        completion(isPresented: authorizationModuleExistsInHistory)
    }
    
    func showAuthorziation(moduleOutput moduleOutput: AuthorizationModuleOutput) {
        pushViewControllerDerivedFrom { (routerSeed) -> UIViewController in
            let authorizationAssembly = assemblyFactory.authorizationAssembly()
            
            let viewController = authorizationAssembly.module(
                routerSeed: routerSeed,
                moduleOutput: moduleOutput
            )
            
            return viewController
        }
    }
    
    func showCategories() {
        pushViewControllerDerivedFrom { routerSeed -> UIViewController in
            let subcategoriesAssembly = assemblyFactory.categoriesAssembly()
            
            let viewController = subcategoriesAssembly.module(
                routerSeed: routerSeed
            )
            
            return viewController
        }
    }
    
    func showRecursion() {
        pushViewControllerDerivedFrom { routerSeed -> UIViewController in
            let recursionAssembly = assemblyFactory.recursionAssembly()
            
            let viewController = recursionAssembly.module(routerSeed: routerSeed)
            
            return viewController
        }
    }
}