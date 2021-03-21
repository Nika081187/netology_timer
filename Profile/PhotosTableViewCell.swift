//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by v.milchakova on 16.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class PhotosTableViewCell: UITableViewCell {
    private lazy var photos = ProfilePhotoStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(photos)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
