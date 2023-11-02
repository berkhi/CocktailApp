//
//  CocktailDetailsVC.swift
//  CocktailApp
//
//  Created by BerkH on 31.10.2023.
//

import UIKit

class CocktailDetailsVC: UIViewController, DrinksDetailViewModelOutput {
    func updateView(drinks: [DrinkDetail]) {
        print(drinks)
        if let firstDrink = drinks.first {
            DispatchQueue.main.async {
                self.lblName.text = firstDrink.strDrink
                self.lblDetail.text = firstDrink.strInstructions
                if let url = URL(string: firstDrink.strDrinkThumb) {
                    self.imgCocktail.kf.setImage(with: url)
                }
            }
        }
    }
    private let viewModel: DrinksDetailViewModel
    var selectedDrinkId: String?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let imgCocktail: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .yellow
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        return imageView
    }()
    let lblName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lblDetail: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        return label
    }()
    init(viewModel: DrinksDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.outputDetail = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.viewModel.fetchDrinksDetail(for: selectedDrinkId ?? "")
    }
    
    private func setupViews(){
        self.navigationItem.titleView = titleLabel
        
        view.backgroundColor = UIColor.systemBackground
        
        detailStackView.addArrangedSubview(imgCocktail)
        detailStackView.addArrangedSubview(lblName)
        detailStackView.addArrangedSubview(lblDetail)
        
        view.addSubview(detailStackView)
        
        NSLayoutConstraint.activate([
            
            detailStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            detailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            imgCocktail.heightAnchor.constraint(equalToConstant: 360),
            
            lblName.heightAnchor.constraint(equalToConstant: 30),
            lblDetail.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),

            detailStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
        ])
    }
    
}
