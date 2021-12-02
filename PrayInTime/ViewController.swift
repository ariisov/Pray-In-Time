//
//  ViewController.swift
//  PrayInTime
//
//  Created by Булат Хатмуллин on 13.11.2021.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var morningButton: UIButton!
    @IBOutlet weak var oyleButton: UIButton!
    @IBOutlet weak var ikendeButton: UIButton!
    @IBOutlet weak var ahsamButton: UIButton!
    @IBOutlet weak var yastuButton: UIButton!
    
    @IBOutlet weak var circlePathButton: UIButton!
    
    let lightGreen = UIColor(red: 0.37, green: 0.871, blue: 0.643, alpha: 1)
    let lightRed = UIColor(red: 0.957, green: 0.369, blue: 0.427, alpha: 1)
    let lightOrange = UIColor(red: 1, green: 0.615, blue: 0.38, alpha: 1)
    let lightPurple = UIColor(red: 0.714, green: 0.471, blue: 1, alpha: 1)
    let lightBlue = UIColor(red: 0.01, green: 0.424, blue: 1, alpha: 1)
    var radiusCorners = 36.0
        
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        morningButton.backgroundColor = lightGreen
        morningButton.layer.cornerRadius = radiusCorners
        oyleButton.backgroundColor = lightRed
        oyleButton.layer.cornerRadius = radiusCorners
        ikendeButton.backgroundColor = lightOrange
        ikendeButton.layer.cornerRadius = radiusCorners
        ahsamButton.backgroundColor = lightPurple
        ahsamButton.layer.cornerRadius = radiusCorners
        yastuButton.backgroundColor = lightBlue
        yastuButton.layer.cornerRadius = radiusCorners
        
        if UserDefaults.standard.bool(forKey: "isMorningButtonDark") {
            changeMorningButtonDarkness()
        }
        if UserDefaults.standard.bool(forKey: "isOyleButtonDark") {
            changeOyleButtonDarkness()
        }
        if UserDefaults.standard.bool(forKey: "isIkendeButtonDark") {
            changeIkendeButtonDarkness()
        }
        if UserDefaults.standard.bool(forKey: "isAhsamButtonDark") {
            changeAhsamButtonDarkness()
        }
        if UserDefaults.standard.bool(forKey: "isYastuButtonDark") {
            changeYastuButtonDarkness()
        }
    }

    // MARK: Morning button's methods
 
    fileprivate func changeMorningButtonDarkness() {
        let darkGreen = UIColor(red: 0.146, green: 0.333, blue: 0.249, alpha: 1)
        morningButton.backgroundColor = darkGreen
    }
    
    @IBAction func didPressedMorningButton(_ sender: UIButton) {
        changeMorningButtonDarkness()
        UserDefaults.standard.set(true, forKey: "isMorningButtonDark")
    }
    
    // MARK: Oyle button's methods

    fileprivate func changeOyleButtonDarkness() {
        let darkRed = UIColor(red: 0.388, green: 0, blue: 0, alpha: 1)
        oyleButton.backgroundColor = darkRed
    }
    
    @IBAction func didPressedOyleButton(_ sender: UIButton) {
        changeOyleButtonDarkness()
        UserDefaults.standard.set(true, forKey: "isOyleButtonDark")
    }
    
    // MARK: Ikende button's methods

    fileprivate func changeIkendeButtonDarkness() {
        let darkOrange = UIColor(red: 0.478, green: 0.272, blue: 0, alpha: 1)
        ikendeButton.backgroundColor = darkOrange
    }
    
    @IBAction func didPressedIkendeButton(_ sender: UIButton) {
        changeIkendeButtonDarkness()
        UserDefaults.standard.set(true, forKey: "isIkendeButtonDark")
    }
    
    // MARK: Ahsam button's methods
    
    fileprivate func changeAhsamButtonDarkness() {
        let darkPurple = UIColor(red: 0.185, green: 0, blue: 0.351, alpha: 1)
        ahsamButton.backgroundColor = darkPurple
    }
    
    @IBAction func didPressedAhsamButton(_ sender: UIButton) {
        changeAhsamButtonDarkness()
        UserDefaults.standard.set(true, forKey: "isAhsamButtonDark")
    }
    
    // MARK: Yastu button's methods
    
    fileprivate func changeYastuButtonDarkness() {
        let darkBlue = UIColor(red: 0, green: 0.164, blue: 0.5, alpha: 1)
        yastuButton.backgroundColor = darkBlue
    }
    
    @IBAction func didPressedYastuButton(_ sender: UIButton) {
        changeYastuButtonDarkness()
        UserDefaults.standard.set(true, forKey: "isYastuButtonDark")

    }
    
    // MARK: Cancel buttons' darkness
    
    @IBAction func didPressedCirclePathButton(_ sender: Any) {
        morningButton.backgroundColor = lightGreen
        UserDefaults.standard.set(false, forKey: "isMorningButtonDark")

        oyleButton.backgroundColor = lightRed
        UserDefaults.standard.set(false, forKey: "isOyleButtonDark")

        ikendeButton.backgroundColor = lightOrange
        UserDefaults.standard.set(false, forKey: "isIkendeButtonDark")

        ahsamButton.backgroundColor = lightPurple
        UserDefaults.standard.set(false, forKey: "isAhsamButtonDark")

        yastuButton.backgroundColor = lightBlue
        UserDefaults.standard.set(false, forKey: "isYastuButtonDark")

    }
    
}
