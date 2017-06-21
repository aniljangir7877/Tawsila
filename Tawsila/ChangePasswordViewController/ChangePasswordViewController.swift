
import UIKit
import RappleProgressHUD
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
         self.changePassword()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
   
    @IBAction func actionBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func changePassword()
    {
        if  Reachability.isConnectedToNetwork() == false
        {
            Utility.sharedInstance.showAlert("Alert", msg: "Internet Connection not Availabel!", controller: self)
            return
        }
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        
        
        let parameterString = String(format : "reset_forgot_password&username=%@",((USER_DEFAULT.object(forKey: "userData") as! NSDictionary).object(forKey: "id") as? String)!)
        
        Utility.sharedInstance.postDataInDataForm(header: parameterString, inVC: self) { (dataDictionary, msg, status) in
            
            if status == true
            {
                let userDict = dataDictionary.object(forKey: "result") as! NSArray
                
                print(userDict.count)
                print(userDict)
                if msg == "No record found"
                {
                    Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
                }
                else
                {
//                    self.arrayRideData = userDict.mutableCopy()  as! NSMutableArray
//                    self.tblMyRides.reloadData()
                }
                
                
                
            }
            else
                
            {
                Utility.sharedInstance.showAlert(kAPPName, msg: msg as String, controller: self)
            }
            
        }
        
        
    }
    
   

}
