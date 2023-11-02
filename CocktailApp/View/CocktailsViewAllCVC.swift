//
//  CocktailsViewAllCVC.swift
//  CocktailApp
//
//  Created by BerkH on 1.11.2023.
//

import UIKit

class CocktailsViewAllCVC: UICollectionViewCell {
    
    let imgCocktail: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let lblCocktail: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
//        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
    }
    
    func addViews(){
        addSubview(imgCocktail)
        addSubview(lblCocktail)
        
        imgCocktail.translatesAutoresizingMaskIntoConstraints = false
        imgCocktail.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgCocktail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        imgCocktail.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imgCocktail.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        lblCocktail.translatesAutoresizingMaskIntoConstraints = false
        lblCocktail.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        lblCocktail.leadingAnchor.constraint(equalTo: imgCocktail.trailingAnchor, constant: 16).isActive = true
        lblCocktail.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func configureUI() {
        backgroundColor = .white
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
    }
}
