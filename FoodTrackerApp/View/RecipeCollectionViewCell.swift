//
//  RecipeCollectionViewCell.swift
//  FoodTrackerApp
//
//  Created by Srivalli Kanchibotla on 4/26/25.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RecipeCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: FoodItem) {
        titleLabel.text = recipe.name
        if let cachedImage = ImageCache.shared.object(forKey: recipe.name as NSString) {
            imageView.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: URL(string: recipe.photo_url_small)!) { [weak self] data, _, error in
                guard let data = data else {
                    return
                }
                guard let image = UIImage(data: data) else {
                    return
                }
                ImageCache.shared.setObject(image, forKey: recipe.photo_url_small as NSString)
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
                
            }.resume()
        }
    }
    
}
