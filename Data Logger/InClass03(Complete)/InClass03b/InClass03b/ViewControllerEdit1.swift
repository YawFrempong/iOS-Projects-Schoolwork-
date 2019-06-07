//
//  ViewControllerEdit1.swift
//  InClass03b
//
//  Created by Frempong, Yaw on 1/30/19.
//  Copyright © 2019 Frempong, Yaw. All rights reserved.
//

import UIKit

class ViewControllerEdit1: UIViewController {

    var currentName:String?
    @IBOutlet weak var inputText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.text = currentName

    }
    
    @IBAction func cancel(_ sender: Any)
    {
        self.dismiss(animated: true)
        {
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "GoBack1"
        {
            
            let destinationVC = segue.destination as! ViewController2
            destinationVC.data1 = self.inputText.text
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "GoBack1"
        {
            if self.inputText.text == ""
            {
                let alert = UIAlertController(title: "Error", message: "Please make sure all Fields are complete!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:  "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            else
            {
                return true
            }
        }
        return true
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

