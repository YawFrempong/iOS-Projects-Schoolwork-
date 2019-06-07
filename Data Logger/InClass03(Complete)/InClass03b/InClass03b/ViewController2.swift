//
//  ViewController2.swift
//  InClass03b
//
//  Created by Frempong, Yaw on 1/30/19.
//  Copyright © 2019 Frempong, Yaw. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    var data1:String?
    var data2:String?
    var data3:String?
    var data4:String?
    
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label03: UILabel!
    @IBOutlet weak var label04: UILabel!
    @IBOutlet weak var show: UIButton!
    
    func getStars(_ num:Int)->String
    {
        if num <= 0
        {
            return ""
        }
        var stringArray = [String]()
        for _ in 1...num
        {
            stringArray.append("*")
        }
        return stringArray.joined(separator: "")
    }
    @IBAction func showAction(_ sender: Any)
    {
        self.label03.text = data3
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if data1 != "" && data2 != "" && data3 != "" && data4 != ""
        {
            self.label01.text = data1
            self.label02.text = data2
            self.label03.text = getStars(data3!.count)
            self.label04.text = data4
        }
        else
        {
            self.label01.text = "."
            self.label02.text = "."
            self.label03.text = "."
            self.label04.text = "."
        }
    }
    
    @IBAction func myUnwindFunction(unwindSegue: UIStoryboardSegue)
    {
        self.label01.text = data1
        self.label02.text = data2
        self.label03.text = getStars(data3!.count)
        self.label04.text = data4
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
        {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier
        {
            case "SegToEdit1":
                let destinationVC = segue.destination as! ViewControllerEdit1
                destinationVC.currentName = data1
            case "SegToEdit2":
                let destinationVC = segue.destination as! ViewControllerEdit2
                destinationVC.currentEmail = data2
            case "SegToEdit3":
                let destinationVC = segue.destination as! ViewControllerEdit3
                destinationVC.currentPassword = data3
            case "SegToEdit4":
                let destinationVC = segue.destination as! ViewControllerEdit4
                destinationVC.currentSeg = data4
            default:
                    print("Error")
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
