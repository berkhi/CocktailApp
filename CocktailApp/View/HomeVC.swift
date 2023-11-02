//
//  ViewController.swift
//  CocktailApp
//
//  Created by BerkH on 26.10.2023.
//

import UIKit
import Kingfisher

class HomeVC: UIViewController, DrinksViewModelOutput {
    func updateView(drinks: [Drink]) {
        self.drinks = drinks
        self.filteredDrinks = drinks
//        print(drinks)
    }
    var drinks: [Drink] = [] {
        didSet {
            DispatchQueue.main.async {
                self.cocktailsCollectionView.reloadData()
            }
        }
    }
    private var filteredDrinks: [Drink] = []
    
    private let viewModel: DrinksViewModel
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarVisible = false
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Paloma Cocktails"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let cocktailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let lblCocktails: UILabel = {
        let label = UILabel()
        label.text = "Cocktails"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let lblCocktailsViewAll: UILabel = {
        let label = UILabel()
        label.text = "View All"
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    let cocktailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CocktailsCVC.self, forCellWithReuseIdentifier: "cocktailCell")
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        let shoppingCartButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(shoppingCartTapped))
        shoppingCartButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = shoppingCartButton
        
        view.backgroundColor = UIColor.systemBackground
        
        cocktailsCollectionView.delegate = self
        cocktailsCollectionView.dataSource = self
        cocktailsCollectionView.isScrollEnabled = false
        cocktailsCollectionView.showsVerticalScrollIndicator = false
        
        cocktailsStackView.addArrangedSubview(lblCocktails)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewAllCocktailsTapped))
        lblCocktailsViewAll.isUserInteractionEnabled = true
        lblCocktailsViewAll.addGestureRecognizer(tapGesture)
        cocktailsStackView.addArrangedSubview(lblCocktailsViewAll)
        
        view.addSubview(scrollView)
        scrollView.addSubview(cocktailsStackView)
        scrollView.addSubview(cocktailsCollectionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cocktailsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            cocktailsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            cocktailsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            cocktailsCollectionView.topAnchor.constraint(equalTo: cocktailsStackView.bottomAnchor, constant: 16),
            cocktailsCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cocktailsCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cocktailsCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            cocktailsCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            cocktailsCollectionView.heightAnchor.constraint(equalToConstant: 960),
            
        ])
    }
    @objc func shoppingCartTapped() {
        
    }
    
    @objc func viewAllCocktailsTapped(){
        let drinksService: DrinksService = APIManager()
        let viewModel = DrinksViewModel(drinksService: drinksService)
        let cocktailsViewAllVC = CocktailsViewAllVC(viewModel: viewModel)
        navigationController?.pushViewController(cocktailsViewAllVC, animated: false)
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
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(3, drinks.count) 
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cocktailCell", for: indexPath) as? CocktailsCVC else {
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
        return CGSize(width: width, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension HomeVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterCocktails(searchController.searchBar.text)
    }
}
