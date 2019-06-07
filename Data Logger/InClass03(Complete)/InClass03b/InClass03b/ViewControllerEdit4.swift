//
//  ViewControllerEdit4.swift
//  InClass03b
//
//  Created by Frempong, Yaw on 1/30/19.
//  Copyright © 2019 Frempong, Yaw. All rights reserved.
//

import UIKit

class ViewControllerEdit4: UIViewController {

    var currentSeg:String?
    @IBOutlet weak var initPicker: UISegmentedControl!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if currentSeg == "CS"
        {
            initPicker.selectedSegmentIndex = 0
        }
        else if currentSeg == "SIS"
        {
            initPicker.selectedSegmentIndex = 1
        }
        else if currentSeg == "BIO"
        {
            initPicker.selectedSegmentIndex = 2
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any)
    {
        self.dismiss(animated: true)
        {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "GoBack4"
        {
            
            let destinationVC = segue.destination as! ViewController2
            if initPicker.selectedSegmentIndex == 0
            {
                destinationVC.data4 = "CS"
            }
            else if initPicker.selectedSegmentIndex == 1
            {
                destinationVC.data4 = "SIS"
            }
            else if initPicker.selectedSegmentIndex == 2
            {
                destinationVC.data4 = "BIO"
            }
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
