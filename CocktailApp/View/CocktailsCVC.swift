//
//  CategoriesCVC.swift
//  CocktailApp
//
//  Created by BerkH on 26.10.2023.
//

import UIKit

class CocktailsCVC: UICollectionViewCell {
    
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
        
        imgCocktail.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgCocktail.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imgCocktail.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imgCocktail.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        lblCocktail.topAnchor.constraint(equalTo: imgCocktail.bottomAnchor, constant: 10).isActive = true
        lblCocktail.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        lblCocktail.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lblCocktail.textAlignment = .center
        
    }
    
    func configureUI() {
        backgroundColor = .white
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
    }
}
