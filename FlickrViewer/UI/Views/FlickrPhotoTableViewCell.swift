//
//  SearchTableViewCell.swift
//  FlickrViewer
//
//  Created by Fady on 3/30/17.
//  Copyright © 2017 orange. All rights reserved.
//

import UIKit

class FlickrPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        setupPhotoTitleLabel()
        setupPhotoImageView()
        setNeedsUpdateConstraints()
    }
    
    func setupCell() {
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    func setupPhotoTitleLabel() {
        self.photoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.photoTitleLabel.numberOfLines = 0
        self.photoTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupPhotoImageView() {
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.photoImageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        self.photoTitleLabel.text = ""
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            self.photoImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.photoImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.photoImageView.widthAnchor.constraint(equalToConstant: 60),
            self.photoImageView.heightAnchor.constraint(equalToConstant: 60),

            self.photoTitleLabel.leftAnchor.constraint(equalTo: self.photoImageView.rightAnchor, constant: 16),
            self.photoTitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.photoTitleLabel.topAnchor.constraint(equalTo: self.photoImageView.topAnchor),
            self.photoTitleLabel.bottomAnchor.constraint(equalTo: self.photoImageView.bottomAnchor)
            ])
    }

}
