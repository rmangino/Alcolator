//
//  WhiskeyViewController.swift
//  Alcolator
//
//  Created by Reed on 6/16/16.
//  Copyright © 2016 Reed Mangino. All rights reserved.
//

import UIKit

class WhiskeyViewController: WineViewController {
  
  // MARK: Properties
  
  private let ouncesInShot: Float             = 1.0
  private let whiskeyAlcoholPercentage: Float = 0.4 // 40%
  
  // MARK: UIViewController Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

// MARK: Actions

extension WhiskeyViewController {
  
  @IBAction override func sliderValueDidChange(_ sender: UISlider) {
    self.beerPercentTextField.resignFirstResponder()
    
    // Bail early if there is no text in the alcohol textfield
    if self.beerPercentTextField.text == nil || (self.beerPercentTextField.text?.isEmpty)! {
      print("\(#function): nothing to calculate")
      self.navigationItem.title = "Whiskey"
      return
    }
  }

  @IBAction override func calculateButtonPressed(_ sender: UIButton) {
    self.beerPercentTextField.resignFirstResponder()
    
    let numberOfBeers = self.beerCountSlider.value
    
    
    let numShotsOfWhiskey = self.calculateNumberOfUnitsFor(numberOfBeers: numberOfBeers,
                                                           ouncesOfOther: self.ouncesInShot,
                                                           alcoholPercentageOfOther: self.whiskeyAlcoholPercentage)
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    let beerText = Int(numberOfBeers) == 1 ? NSLocalizedString("beer", comment: "singular beer") :
      NSLocalizedString("beers", comment: "plural of beer")
    
    let whiskeyText = Int(numShotsOfWhiskey) == 1 ? NSLocalizedString("shot", comment: "singular shot") :
                                                    NSLocalizedString("shots", comment: "plural of shot")
    let numShotsString = String(format: "%.2f", numShotsOfWhiskey)
    
    let resultString = "\(numberOfBeers) \(beerText) (with \(self.beerPercentTextField.text!)% alcohol) contains " +
      "as much alcohol as \(numShotsString) \(whiskeyText) of whiskey."
    
    self.resultLabel.text = resultString
    
    self.tabBarItem.badgeValue = String(Int(numShotsOfWhiskey))
  }

}

