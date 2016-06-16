//
//  WineViewController.swift
//  Alcolator
//
//  Created by Reed on 6/14/16.
//  Copyright © 2016 Reed Mangino. All rights reserved.
//

import UIKit

class WineViewController: UIViewController {

  // MARK: Properties
  
  @IBOutlet weak var beerPercentTextField: UITextField!
  @IBOutlet weak var beerCountSlider: UISlider!
  @IBOutlet weak var resultLabel: UILabel!
  
  // MARK: UIViewController Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  // MARK: Actions
  
  @IBAction func textFieldDidChange(sender: UITextField) {
    var shouldClear = false
    
    // Disallow non-numerics and 0
    // NOTE: It would be better to just set the keyboard of the textfield to NumberPad
    if let enteredText = sender.text, let enteredNumber = Float(enteredText) {
      if enteredNumber.isZero {
        shouldClear = true
      }
    }
    else {
      shouldClear = true
    }
    
    if shouldClear {
      sender.text = ""
    }
  }
  
  @IBAction func sliderValueDidChange(sender: UISlider) {
    print("Slider value changed to \(sender.value)")
    self.beerPercentTextField.resignFirstResponder()
  }
  
  @IBAction func calculateButtonPressed(sender: UIButton) {
    self.beerPercentTextField.resignFirstResponder()
    
    let numberOfBeers = self.beerCountSlider.value
    
    // How much alcohol is in all beers?
    let ouncesInOneBeerGlass: Float = 12.0
    let alcoholPercentageOfBeer = Float(self.beerPercentTextField.text!)! / 100.0
    let ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer
    let ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers
    
    // How much alcohol in that much wine?
    let ouncesInOneWineGlass: Float = 5.0
    let alcoholPercentageOfWine: Float = 0.13 // 13%
    let ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    let numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    let beerText = Int(numberOfBeers) == 1 ? NSLocalizedString("beer", comment: "singular beer") :
                                             NSLocalizedString("beers", comment: "plural of beer")
    
    let wineText = Int(numberOfWineGlassesForEquivalentAlcoholAmount) == 1 ? NSLocalizedString("glass", comment: "singular glass") :
                                                                             NSLocalizedString("glasses", comment: "plural of glass")
    
    let numGlassesString = String(format: "%.2f", numberOfWineGlassesForEquivalentAlcoholAmount)
    
    let resultString = "\(numberOfBeers) \(beerText) (with \(self.beerPercentTextField.text!)% alcohol) contains " +
                       "as much alcohol as \(numGlassesString) \(wineText) of wine."
    self.resultLabel.text = resultString
  }
  
  @IBAction func tapGestureDidFire(sender: UITapGestureRecognizer) {
    self.beerPercentTextField.resignFirstResponder()
  }

}

