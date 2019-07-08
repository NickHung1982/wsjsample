//
//  MainTableViewCell.swift
//  WSJ
//
//  Created by Nick on 5/13/19.
//  Copyright © 2019 NickOwn. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let reuseID: String = "Cell"
    
    lazy var labelTitle : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 24)
        return label
    }()
    
    lazy var labelSubTitle : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private func setupUI() {
        let vStackView = UIStackView(arrangedSubviews: [labelTitle,labelSubTitle])
        vStackView.axis = .vertical
        vStackView.spacing = 5
        vStackView.alignment = .leading
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(vStackView)
        
        //layout
        vStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5.0).isActive = true
        vStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        vStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
    }
    
    func setup(feed: RSS) {
        labelTitle.text = feed.title
        labelSubTitle.text = feed.description
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
