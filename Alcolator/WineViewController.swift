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
  
  private let ouncesInGlassOfWine: Float   = 5.0
  private let wineAlcoholPercentage: Float = 0.13 // 13%
  
  @IBOutlet weak var beerPercentTextField: UITextField!
  @IBOutlet weak var beerCountSlider: UISlider!
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var calculateButton: UIButton!
  
  // MARK: UIViewController Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: Helpers
  
  func calculateNumberOfUnitsFor(numberOfBeers: Float, ouncesOfOther: Float, alcoholPercentageOfOther: Float) -> Float {
    let numberOfBeers = self.beerCountSlider.value
    
    // How much alcohol is in all beers?
    let ouncesInOneBeerGlass: Float = 12.0
    let alcoholPercentageOfBeer = Float(self.beerPercentTextField.text!)! / 100.0
    let ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer
    let ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers
    
    // How much alcohol in that much wine?
    let ouncesInOneWineGlass = ouncesOfOther
    let ouncesOfAlcoholPerUnit = ouncesInOneWineGlass * alcoholPercentageOfOther;
    let numberOfUnitsForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerUnit
    
    return numberOfUnitsForEquivalentAlcoholAmount
  }

}

// MARK: Actions

extension WineViewController {
  
  @IBAction func textFieldDidChange(_ sender: UITextField) {
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
      sender.text = nil
      self.calculateButton.isEnabled = false
    }
    else {
      self.calculateButton.isEnabled = true
    }
  }
  
  @IBAction func sliderValueDidChange(_ sender: UISlider) {
    self.beerPercentTextField.resignFirstResponder()
    
    // Bail early if there is no text in the alcohol textfield
    if self.beerPercentTextField.text == nil || (self.beerPercentTextField.text?.isEmpty)! {
      print("\(#function): nothing to calculate")
      return
    }
  }
  
  @IBAction func calculateButtonPressed(_ sender: UIButton) {
    self.beerPercentTextField.resignFirstResponder()
    
    let numberOfBeers = self.beerCountSlider.value
    
    let numGlassesOfWine = self.calculateNumberOfUnitsFor(numberOfBeers: numberOfBeers,
                                                          ouncesOfOther: self.ouncesInGlassOfWine,
                                                          alcoholPercentageOfOther: self.wineAlcoholPercentage)
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    let beerText = Int(numberOfBeers) == 1 ? NSLocalizedString("beer", comment: "singular beer") :
                                             NSLocalizedString("beers", comment: "plural of beer")
    
    let wineText = Int(numGlassesOfWine) == 1 ? NSLocalizedString("glass", comment: "singular glass") :
                                                NSLocalizedString("glasses", comment: "plural of glass")
    
    let numGlassesString = String(format: "%.2f", numGlassesOfWine)
    
    let resultString = "\(numberOfBeers) \(beerText) (with \(self.beerPercentTextField.text!)% alcohol) contains " +
                       "as much alcohol as \(numGlassesString) \(wineText) of wine."
    self.resultLabel.text = resultString
    
    self.tabBarItem.badgeValue = "\(numGlassesOfWine)"
  }
  
  @IBAction func tapGestureDidFire(_ sender: UITapGestureRecognizer) {
    self.beerPercentTextField.resignFirstResponder()
  }

}

