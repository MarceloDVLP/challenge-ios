//
//  TabViewController.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.barTintColor = .black

        setViewControllers([
                            TVShowListConfigurator.make(),
                            SearchTVShowConfigurator.make(),
                            MyFavoriteListConfigurator.make()
                          ],
                          animated: true)
    }
    
    
    
}
