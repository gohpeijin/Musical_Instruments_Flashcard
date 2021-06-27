//
//  MyCollectionViewCell.swift
//  assignment1
//
//  Created by gohpeijin on 26/06/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit



class InstrumentViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "InstrumentViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setImage(_ image : UIImage){
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib (nibName: "InstrumentViewCell", bundle: nil)
    }

}
