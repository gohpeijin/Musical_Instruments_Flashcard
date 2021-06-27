//
//  ViewController.swift
//  assignment1
//
//  Created by gohpeijin on 26/06/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var instrumentCollectionView: UICollectionView!
    
    let imageSize = 180
    
    struct instrument {
        var name : String
        var image : String
    }
    
    var instrumentlist: [instrument] = []
    
    //create instrument and store in the list
    func createArray () -> [instrument] {
        var tempInstrument: [instrument] = []
        
        let instrument1 = instrument(name: "Triangle", image: "triangle")
        let instrument2 = instrument(name: "Guitar", image: "guitar")
        let instrument3 = instrument(name: "Keyboard Piano", image: "keyboard_piano")
        let instrument4 = instrument(name: "Bongos", image: "bongos")
        let instrument5 = instrument(name: "Violin", image: "violin")
        
        tempInstrument.append(instrument1)
        tempInstrument.append(instrument2)
        tempInstrument.append(instrument3)
        tempInstrument.append(instrument4)
        tempInstrument.append(instrument5)
        
        return tempInstrument
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instrumentlist = createArray()

        // set the collectionview cell size
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: imageSize, height: imageSize)
        instrumentCollectionView.collectionViewLayout = layout
        
        // register the cell to the collection
        instrumentCollectionView.register(InstrumentViewCell.nib(), forCellWithReuseIdentifier: InstrumentViewCell.identifier)
        
        instrumentCollectionView.delegate = self
        instrumentCollectionView.dataSource = self
    }

}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let alertController = UIAlertController(title: "Instrument Name", message: instrumentlist[indexPath.row].name, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style:.default, handler: nil)
        alertController.addAction(doneAction)
        self.present(alertController,animated: true,completion: nil)
        
    }
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instrumentlist.count
    }
    
    // update every cell by setting the image
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstrumentViewCell.identifier, for: indexPath) as! InstrumentViewCell
        
        let instrument = instrumentlist[indexPath.row]
        cell.setImage(UIImage(named: instrument.image)!)
        
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    //to set the cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageSize, height: imageSize)
    }
}



