//Assignment: In Class 03
//File Name: InClass03
//Name: Yaw Frempong & Lukas Gupta-Leary

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var textField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToView2" {
            print("Pass")
            let destinationVC = segue.destination as! ViewController2
            destinationVC.data = self.textField.text
        }
    }
    
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "SegueToView2"
        {
            if self.textField.text == ""
            {
                let alert = UIAlertController(title: "Error", message: "Please enter a name!", preferredStyle: .alert)
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

}
