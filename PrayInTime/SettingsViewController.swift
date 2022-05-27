//
//  SettingsViewController.swift
//  PrayInTime
//
//  Created by Булат Хатмуллин on 04.04.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var switchDarkTheme: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchDarkThemeChanged(_ sender: Any) {
        if switchDarkTheme.isOn == true {
            self.view.backgroundColor = UIColor.darkGray
           

        }else{
            self.view.backgroundColor = UIColor.white
         

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
