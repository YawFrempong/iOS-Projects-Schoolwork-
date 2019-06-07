//
//  ViewController2.swift
//  InClass03
//
//  Created by Frempong, Yaw on 1/30/19.
//  Copyright © 2019 Frempong, Yaw. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    var data:String?
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if data != "" {
            self.label1.text = data
        }
        else {
            self.label1.text = ""
        }
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
        {
            
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
