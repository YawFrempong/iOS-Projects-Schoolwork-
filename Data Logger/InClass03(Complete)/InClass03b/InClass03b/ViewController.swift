//Assignment: In Class 03
//File Name: InClass03b
//Name: Yaw Frempong & Lukas Gupta-Leary

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var initPicker: UISegmentedControl!
    
    
    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegToView2"
        {
            //print("Pass")
            let destinationVC = segue.destination as! ViewController2
            destinationVC.data1 = self.textField1.text
            destinationVC.data2 = self.textField2.text
            destinationVC.data3 = self.textField3.text
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
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "SegToView2"
        {
            if self.textField1.text == "" || self.textField2.text == "" || self.textField3.text == ""
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
}
extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
