//
//  TabBarController.swift
//  CocktailApp
//
//  Created by BerkH on 26.10.2023.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addSomeTabItems()
    }
    override func loadView() {
        super.loadView()
        setupCustomTabBar()
    }
    func setupCustomTabBar() {
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.itemWidth = 50
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 150
        self.tabBar.tintColor = UIColor(hex: "#fe989b", alpha: 1.0)
    }
    func addSomeTabItems() {
        let drinksService: DrinksService = APIManager()
        let viewModel = DrinksViewModel(drinksService: drinksService)
        let vc1 = UINavigationController(rootViewController: HomeVC(viewModel: viewModel))
        let vc2 = UINavigationController(rootViewController: ViewC2())
        vc1.title = "Home"
        vc2.title = "Profile"
        setViewControllers([vc1, vc2], animated: false)
        guard let items = tabBar.items else { return}
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "person.fill")

    }
}

class ViewC1 : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .gray
    }
}
class ViewC2 : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemGray
    }
}

extension UIColor {
    public convenience init?(hex: String, alpha: Double = 1.0) {
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (pureString.hasPrefix("#")) {
            pureString.remove(at: pureString.startIndex)
        }
        if ((pureString.count) != 6) {
            return nil
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
            return
        }
        return nil
    }
}

