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
    @IBOutlet weak var instrumentName: UILabel!
    
    static let identifier = "InstrumentViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        instrumentName.alpha = 0
    }
    
    public func flipCell (){

        if (instrumentName.alpha == 1) {
            UIView.animate(withDuration: 0.2){
                self.instrumentName.alpha = 0
            }
        }
        else {
            UIView.animate(withDuration: 0.5){
                self.instrumentName.alpha = 1
            }
        }
        
    }
    
    public func setImage(_ image : UIImage, _ name : String){
        imageView.image = image
        instrumentName.text = name
    }
    
    
    static func nib() -> UINib {
        return UINib (nibName: "InstrumentViewCell", bundle: nil)
    }

}
