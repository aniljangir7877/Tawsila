
import UIKit

class ChangePasswordViewController: UIViewController
{
    @IBOutlet var txtCurrentPassword: UITextField!
    
    @IBOutlet weak var btnSavePassword: UIButton!
    @IBOutlet var txtNewPassword: UITextField!
    @IBOutlet var txtConfrPassword: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        btnSavePassword.layer.cornerRadius = 4.0
        btnSavePassword.layer.masksToBounds = true
    }
    @IBAction func actionSaveNewPassword(_ sender: Any) {
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
   
    @IBAction func actionBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

   

}
