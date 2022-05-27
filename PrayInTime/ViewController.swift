//
//  ViewController.swift
//  PrayInTime
//
//  Created by Булат Хатмуллин on 13.11.2021.
//

import UIKit
import CoreXLSX


class MainViewController: UIViewController
{
    
    @IBOutlet weak var morningButton: UIButton!
    @IBOutlet weak var oyleButton: UIButton!
    @IBOutlet weak var ikendeButton: UIButton!
    @IBOutlet weak var ahsamButton: UIButton!
    @IBOutlet weak var yastuButton: UIButton!
    
    @IBOutlet weak var circlePathButton: UIButton!
    
    let lightGreen = UIColor(rgb: 0xe2d3cd)
    let lightRed = UIColor(rgb: 0xe3dad5)
    let lightOrange = UIColor(rgb: 0xe6cdb5)
    let lightPurple = UIColor(rgb: 0xf7d8b5)
    let lightBlue = UIColor(rgb: 0xd0c8b6)
    var radiusCorners = 36.0
    
    @IBOutlet weak var morningStartTimeLabel: UILabel!
    @IBOutlet weak var morningFinishTimeLabel: UILabel!
    @IBOutlet weak var oyleTimeLabel: UILabel!
    @IBOutlet weak var ikendeTimeLabel: UILabel!
    @IBOutlet weak var ahsamTimeLabel: UILabel!
    @IBOutlet weak var yastuTimeLabel: UILabel!
    @IBOutlet weak var clockTimeLabel: UILabel!
    
    var timer = Timer()

    var installedTimes = Array(repeating: "", count: 6)
        
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduledTimerWithTimeInterval()

        morningButton.layer.cornerRadius = radiusCorners
        oyleButton.layer.cornerRadius = radiusCorners
        ikendeButton.layer.cornerRadius = radiusCorners
        ahsamButton.layer.cornerRadius = radiusCorners
        yastuButton.layer.cornerRadius = radiusCorners

        if UserDefaults.standard.bool(forKey: "Time was set"){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd"
            if (UserDefaults.standard.string(forKey: "Date") == dateFormatter.string(from: Date())){
                alreadySetTimes()
            }
            else{
                launchGetTimes()
                dateFormatter.dateFormat = "MM.dd"
                UserDefaults.standard.set(dateFormatter.string(from: Date()), forKey: "Date")

            }
        }
        else {
            launchGetTimes()
        }
        launchGetTimes()
        let distanceBetweenButtons = morningButton.frame.height / 8
        oyleButton.topAnchor.constraint(equalTo: morningButton.bottomAnchor, constant: distanceBetweenButtons).isActive = true
        ikendeButton.topAnchor.constraint(equalTo: oyleButton.bottomAnchor, constant: distanceBetweenButtons).isActive = true
        ahsamButton.topAnchor.constraint(equalTo: ikendeButton.bottomAnchor, constant: distanceBetweenButtons).isActive = true
        yastuButton.topAnchor.constraint(equalTo: ahsamButton.bottomAnchor, constant: distanceBetweenButtons).isActive = true
    }
        
    // MARK: ViewWillAppear

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.view.backgroundColor = UIColor.white
        
        
        morningButton.backgroundColor = lightGreen
        oyleButton.backgroundColor = lightRed
        ikendeButton.backgroundColor = lightOrange
        ahsamButton.backgroundColor = lightPurple
        yastuButton.backgroundColor = lightBlue
        
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

        
       
    
    // MARK: Timer clock
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.timeUpdating() })
    }
    
    func timeUpdating(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        self.clockTimeLabel.text = dateFormatter.string(from: Date())
    }

    // MARK: Installing dark status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    // MARK: Setting Times
    
    func alreadySetTimes(){
        installedTimes = UserDefaults.standard.stringArray(forKey: "Already set times")!
        self.morningStartTimeLabel.text =   installedTimes[0]
        self.morningFinishTimeLabel.text =  installedTimes[1]
        self.oyleTimeLabel.text =           installedTimes[2]
        self.ikendeTimeLabel.text =         installedTimes[3]
        self.ahsamTimeLabel.text =          installedTimes[4]
        self.yastuTimeLabel.text =          installedTimes[5]
    }
    
    // MARK: Output times to the labels
    
    func getTimesFromSource()
    {
        var xlsxFile: XLSXFile?
        
        if let file = XLSXFile(filepath: Bundle.main.path(forResource: "Times of Namaz", ofType: "xlsx") ?? "") {
            xlsxFile = file
        } else {
          fatalError("XLSX file is corrupted or does not exist")
        }

        do {
            for wbk in try xlsxFile!.parseWorkbooks() {
                let worksheets = try xlsxFile!.parseWorksheetPathsAndNames(workbook: wbk)
                let path = worksheets.first!.path
                let worksheet = try xlsxFile!.parseWorksheet(at: path)
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy.MM.dd"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"

//                for row in worksheet.data?.rows ?? [] {
//                    print("\n\nRow \(row.reference) of size \(row.cells.count)")
//
//                    for c in row.cells {
//                        print("Cell \(c.reference) - \(c.dateValue?.formatted() ?? "nil"): \(c.type?.rawValue ?? "nil")")
//
//                    }
//                }
                
                var rowNumber = UInt.init(366/2)
                var maxNumber = UInt.init(365)
                var minNumber = UInt.init(0)
                
                repeat {

                    let dateSelectedCell = worksheet.cells(atColumns: [ ColumnReference("A")! ], rows: [ rowNumber ]).first
                    let day = Calendar.current.component(.day, from: dateSelectedCell!.dateValue!)
                    let month = Calendar.current.component(.month, from: dateSelectedCell!.dateValue!)
                    let year = Calendar.current.component(.year, from: dateSelectedCell!.dateValue!)
                    let selectedDate: Date? = dateFormatterGet.date(from: "\(year).\(month).\(day)")

                    if (dateFormatter.string(from: selectedDate!) == dateFormatter.string(from: Date())){
                        break
                    }
                    else{
                        
                        if (dateFormatter.string(from: selectedDate!) > dateFormatter.string(from: Date())){
                            maxNumber = rowNumber
                            rowNumber = (maxNumber - minNumber)/2
                        }
                        else {
                            minNumber = rowNumber
                            rowNumber = rowNumber + ((maxNumber - minNumber)/2)
                        }
                    }
                } while (true)
                
                let morningStartSelectedCell = worksheet.cells(atColumns: [ ColumnReference("B")! ], rows: [ rowNumber ]).first
                var hour = Calendar.current.component(.hour, from: morningStartSelectedCell!.dateValue!)
                var minute = Calendar.current.component(.minute, from: morningStartSelectedCell!.dateValue!)

                dateFormatterGet.dateFormat = "HH:mm"
                dateFormatter.dateFormat = "HH:mm"
                var date: Date? = dateFormatterGet.date(from: "\(hour):\(minute)")
                
                self.installedTimes[0] = dateFormatter.string(from: date!)
                
                let morningFinishSelectedCell = worksheet.cells(atColumns: [ ColumnReference("D")! ], rows: [ rowNumber ]).first
                hour = Calendar.current.component(.hour, from: morningFinishSelectedCell!.dateValue!)
                minute = Calendar.current.component(.minute, from: morningFinishSelectedCell!.dateValue!)
                date = dateFormatterGet.date(from: "\(hour):\(minute)")
                self.installedTimes[1] = dateFormatter.string(from: date!)


                let oyleSelectedCell = worksheet.cells(atColumns: [ ColumnReference("E")! ], rows: [ rowNumber ]).first
                hour = Calendar.current.component(.hour, from: oyleSelectedCell!.dateValue!)
                minute = Calendar.current.component(.minute, from: oyleSelectedCell!.dateValue!)
                date = dateFormatterGet.date(from: "\(hour):\(minute)")
                self.installedTimes[2] = dateFormatter.string(from: date!)
                
                if (dateFormatter.string(from: Date()) > dateFormatter.string(from: date!)){
                    let morningStartSelectedCell = worksheet.cells(atColumns: [ ColumnReference("B")! ], rows: [ rowNumber + 1 ]).first
                    var hour = Calendar.current.component(.hour, from: morningStartSelectedCell!.dateValue!)
                    var minute = Calendar.current.component(.minute, from: morningStartSelectedCell!.dateValue!)

                    dateFormatterGet.dateFormat = "HH:mm"
                    dateFormatter.dateFormat = "HH:mm"
                    var date: Date? = dateFormatterGet.date(from: "\(hour):\(minute)")
                    
                    self.installedTimes[0] = dateFormatter.string(from: date!)
                    
                    let morningFinishSelectedCell = worksheet.cells(atColumns: [ ColumnReference("D")! ], rows: [ rowNumber + 1 ]).first
                    hour = Calendar.current.component(.hour, from: morningFinishSelectedCell!.dateValue!)
                    minute = Calendar.current.component(.minute, from: morningFinishSelectedCell!.dateValue!)
                    date = dateFormatterGet.date(from: "\(hour):\(minute)")
                    self.installedTimes[1] = dateFormatter.string(from: date!)
                }

                let ikendeSelectedCell = worksheet.cells(atColumns: [ ColumnReference("G")! ], rows: [ rowNumber ]).first
                hour = Calendar.current.component(.hour, from: ikendeSelectedCell!.dateValue!)
                minute = Calendar.current.component(.minute, from: ikendeSelectedCell!.dateValue!)
                date = dateFormatterGet.date(from: "\(hour):\(minute)")
                self.installedTimes[3] = dateFormatter.string(from: date!)

                let ahsamSelectedCell = worksheet.cells(atColumns: [ ColumnReference("H")! ], rows: [ rowNumber ]).first
                hour = Calendar.current.component(.hour, from: ahsamSelectedCell!.dateValue!)
                minute = Calendar.current.component(.minute, from: ahsamSelectedCell!.dateValue!)
                date = dateFormatterGet.date(from: "\(hour):\(minute)")
                self.installedTimes[4] = dateFormatter.string(from: date!)
                
                let yastuSelectedCell = worksheet.cells(atColumns: [ ColumnReference("I")! ], rows: [ rowNumber ]).first
                hour = Calendar.current.component(.hour, from: yastuSelectedCell!.dateValue!)
                minute = Calendar.current.component(.minute, from: yastuSelectedCell!.dateValue!)
                date = dateFormatterGet.date(from: "\(hour):\(minute)")
                self.installedTimes[5] = dateFormatter.string(from: date!)

                UserDefaults.standard.set(true, forKey: "Time was set")
                UserDefaults.standard.set(installedTimes, forKey: "Already set times")
            }
        } catch (let error) {
            print(error.localizedDescription)
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
        
        UserDefaults.standard.set(false, forKey: "Time was set")

        launchGetTimes()
    }
    
    func launchGetTimes(){
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.getTimesFromSource()
            DispatchQueue.main.async {
                self.alreadySetTimes()
            }
        }
    }
    
}



extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
