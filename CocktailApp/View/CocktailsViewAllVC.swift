//
//  CocktailsViewAllVC.swift
//  CocktailApp
//
//  Created by BerkH on 1.11.2023.
//

import UIKit

class CocktailsViewAllVC: UIViewController, DrinksViewModelOutput {
    func updateView(drinks: [Drink]) {
        self.drinks = drinks
        self.filteredDrinks = drinks
    }
    var drinks: [Drink] = [] {
        didSet {
            DispatchQueue.main.async {
                self.cocktailsCollectionView.reloadData()
                self.filteredDrinks = self.drinks
            }
        }
    }
    private var filteredDrinks: [Drink] = []
    
    private let viewModel: DrinksViewModel
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarVisible = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cocktails"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let cocktailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CocktailsViewAllCVC.self, forCellWithReuseIdentifier: "cocktailVieAllCell")
        return collectionView
    }()
    
    init(viewModel: DrinksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSearchController()
        self.viewModel.fetchDrinks()
    }
    
    private func setupViews(){
        self.navigationItem.titleView = titleLabel
        view.backgroundColor = UIColor.systemBackground
        
        cocktailsCollectionView.delegate = self
        cocktailsCollectionView.dataSource = self
        cocktailsCollectionView.isScrollEnabled = true
        cocktailsCollectionView.showsVerticalScrollIndicator = false

        view.addSubview(cocktailsCollectionView)
        
        NSLayoutConstraint.activate([
            cocktailsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            cocktailsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cocktailsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cocktailsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search drink"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    private func filterCocktails(_ searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            drinks = filteredDrinks
            cocktailsCollectionView.reloadData()
            return
        }
        drinks = filteredDrinks.filter { $0.strDrink.lowercased().contains(searchText.lowercased()) }
        cocktailsCollectionView.reloadData()
    }
}

extension CocktailsViewAllVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(drinks)
        return drinks.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cocktailVieAllCell", for: indexPath) as? CocktailsViewAllCVC else {
            fatalError("Hücre oluşturulamadı")
        }
        let drink = drinks[indexPath.item]
        cell.lblCocktail.text = drink.strDrink
        if let url = URL(string: drink.strDrinkThumb) {
            cell.imgCocktail.kf.setImage(with: url)
        }
        //        print(drink)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDrink = drinks[indexPath.item]
        let selectedDrinkId = selectedDrink.idDrink
        
        let drinksDetailServices: DrinksDetailService = APIServiceDetails()
        let viewModel = DrinksDetailViewModel(drinksDetailServices: drinksDetailServices)
        
        let detailVC = CocktailDetailsVC(viewModel: viewModel)
        detailVC.selectedDrinkId = selectedDrinkId
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 100)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

}

extension CocktailsViewAllVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterCocktails(searchController.searchBar.text)
    }
}
