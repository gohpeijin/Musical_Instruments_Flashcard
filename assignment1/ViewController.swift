//
//  ViewController.swift
//  assignment1
//  This application content of two view
//  1. Flashcard View
//  2. Collection View (View all the card together)
//  Created by gohpeijin on 26/06/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1. single flashcard view code
    @IBOutlet weak var singleView: UIView! // the view of the single card view
    @IBOutlet weak var singleScrollView: UIScrollView! // the scroll view of the sinlge card view
    @IBOutlet weak var buttonLeft: UIButton! // move to previous image
    @IBOutlet weak var buttonRight: UIButton! // move to next image
    @IBOutlet weak var imagePlaceholder: UIImageView!
    @IBOutlet weak var labelCounter: UILabel! // display the number of the instrument viewing
    @IBOutlet weak var instrumentName: UILabel!
    
    // 2. collection view code
    @IBOutlet weak var instrumentCollectionView: UICollectionView!  // the view for all the card at once
    let imageSize = 180 //image size of the instruments in collection view
    
    // Define the paramters of the instrument
    struct instrument {
        var name : String
        var image : String
    }
    var instrumentlist: [instrument] = []
    var startindex = 0 // strat index for the instrument to be shown
    
    // Create instrument and store in the list
    func createArray () -> [instrument] {
        var tempInstrument: [instrument] = []
        
        let instrument1 = instrument(name: "Triangle", image: "triangle")
        let instrument2 = instrument(name: "Guitar", image: "guitar")
        let instrument3 = instrument(name: "Keyboard Piano", image: "keyboard_piano")
        let instrument4 = instrument(name: "Bongos", image: "bongos")
        let instrument5 = instrument(name: "Violin", image: "violin")
        let instrument6 = instrument(name: "Saxophone", image: "saxophone")
        let instrument7 = instrument(name: "Keytar", image: "keytar")
        let instrument8 = instrument(name: "Harp" ,image: "harp")
        let instrument9 = instrument(name: "Grand Piano",image: "grand-piano")
        let instrument10 = instrument(name: "Trumpet", image: "trumpet")
        let instrument11 = instrument(name: "Drum Set", image: "drum-set")
        let instrument12 = instrument(name: "Clarinet", image: "clarinet")
        
        tempInstrument.append(instrument1)
        tempInstrument.append(instrument2)
        tempInstrument.append(instrument3)
        tempInstrument.append(instrument4)
        tempInstrument.append(instrument5)
        tempInstrument.append(instrument6)
        tempInstrument.append(instrument7)
        tempInstrument.append(instrument8)
        tempInstrument.append(instrument9)
        tempInstrument.append(instrument10)
        tempInstrument.append(instrument11)
        tempInstrument.append(instrument12)
        
        return tempInstrument
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instrumentlist = createArray()
        
        // 1. single flashcard view code
        // set the size of the scrolling view to ensure objects is scrollable in landscape mode
        singleScrollView.contentSize = singleView.frame.size
        setImage()
        
        // 2. collection view code
        // set the collectionview cell size
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: imageSize, height: imageSize)
        instrumentCollectionView.collectionViewLayout = layout
        
        instrumentCollectionView.register(InstrumentViewCell.nib(), forCellWithReuseIdentifier: InstrumentViewCell.identifier) // register the cell to the collection
        instrumentCollectionView.delegate = self
        instrumentCollectionView.dataSource = self
    }
    
    // 1. single flashcard view code
    @IBAction func buttonLeft(_ sender: UIButton) { startindex -= 1; setImage()}
    @IBAction func buttonRight(_ sender: UIButton) {startindex += 1; setImage()}
   
    func setImage(){
        instrumentName.alpha = 0 // ensure the label is hidden
        imagePlaceholder.image = (UIImage(named: instrumentlist[startindex].image)!)
        instrumentName.text = instrumentlist[startindex].name
        labelCounter.text = String(startindex+1)
        
        if (startindex == 0){buttonLeft.isHidden = true}
        else{buttonLeft.isHidden = false}
        
        if (startindex == instrumentlist.count-1){buttonRight.isHidden = true}
        else{buttonRight.isHidden = false}
        
    }

    // toggle the label to visible when user interact to the magnifying glass button
    @IBAction func buttonToggle(_ sender: UIButton) {
        if (instrumentName.alpha == 1) {
            UIView.animate(withDuration: 0.2){
                self.instrumentName.alpha = 0
            }
        }
        else {
            UIView.animate(withDuration: 0.5){
                self.instrumentName.alpha = 1
                // auto change to alpha 0 if user no click it after 4 second
                Timer.scheduledTimer(withTimeInterval: 4, repeats: false){ (_) in
                    UIView.animate(withDuration: 0.5){
                        self.instrumentName.alpha = 0
                    }
                }
            }
        }
    }
    
    
    // to cahnge the view of 1. flashcard mode to 2. collection mode or vise versa
    @IBAction func buttonChangeView(_ sender: UIButton) {
        if(singleView.isHidden == false){
            singleScrollView.isHidden = true
            instrumentCollectionView.isHidden = false
        }
        else{
            singleScrollView.isHidden = false
            instrumentCollectionView.isHidden = true
        }
        
    }
    
}

// 2. collection view code

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cell = collectionView.cellForItem(at: indexPath) as! InstrumentViewCell
        cell.flipCell()
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
        cell.setImage(UIImage(named: instrument.image)!, instrument.name)
        
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    //to set the cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageSize, height: imageSize)
    }
}



