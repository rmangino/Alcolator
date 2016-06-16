//
//  WhiskeyViewController.swift
//  Alcolator
//
//  Created by Reed on 6/16/16.
//  Copyright © 2016 Reed Mangino. All rights reserved.
//

import UIKit

class WhiskeyViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  @IBAction override func calculateButtonPressed(sender: UIButton) {
    self.beerPercentTextField.resignFirstResponder()
    
    let numberOfBeers = self.beerCountSlider.value
    
    // How much alcohol is in all beers?
    let ouncesInOneBeerGlass: Float = 12.0
    let alcoholPercentageOfBeer = Float(self.beerPercentTextField.text!)! / 100.0
    let ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer
    let ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers
    
    // How much alcohol in that much whiskey?
    let ouncesInOneWhiskeyGlass: Float = 1.0 // 1oz shot
    let alcoholPercentageOfWhiskey: Float = 0.4 // 40%
    let ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    let numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    let beerText = Int(numberOfBeers) == 1 ? NSLocalizedString("beer", comment: "singular beer") :
      NSLocalizedString("beers", comment: "plural of beer")
    
    let whiskeyText = Int(numberOfWhiskeyGlassesForEquivalentAlcoholAmount) == 1 ? NSLocalizedString("shot", comment: "singular shot") : NSLocalizedString("shots", comment: "plural of shot")
    
    let resultString = "\(numberOfBeers) \(beerText) (with \(self.beerPercentTextField.text!) alcohol) contains " +
      "as much alcohol as \(numberOfWhiskeyGlassesForEquivalentAlcoholAmount) \(whiskeyText) of whiskey."
    
    self.resultLabel.text = resultString
  }

}
