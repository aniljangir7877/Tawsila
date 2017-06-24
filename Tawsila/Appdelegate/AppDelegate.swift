
//
//  AppDelegate.swift
//  Tawsila
//
//  Created by Dinesh Mahar on 10/06/17.
//  Copyright © 2017 scientificweb. All rights reserved.
//Anil

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import CoreLocation
import UserNotifications
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    var lat: Double!
    var long: Double!
    var  latitude : String!
    var longitude : String!
    let locationManager = CLLocationManager()
    var deviceTokenStr = ""
    var window: UIWindow?
    var navController : UINavigationController?
    var strLanguage: String!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
      
        // checekApplication selected language (Vikram Singh)//20-jun-2017
            strLanguage = checkAppLanguage()
        
       // Fabric.sharedSDK().debug = true
        //Fabric.with([Crashlytics.self()])

        
        GMSServices.provideAPIKey("AIzaSyAHgc0o2XkUDVwnw7F0ru8b7JpWlPL5aOc")
        GMSPlacesClient.provideAPIKey("AIzaSyAHgc0o2XkUDVwnw7F0ru8b7JpWlPL5aOc")
        
       // let obj : SignInOrCreateNewAccount = SignInOrCreateNewAccount(nibName: "SignInOrCreateNewAccount", bundle: nil)
        
//<<<<<<< HEAD
////        let obj : HomeViewControlle = HomeViewControlle(nibName: "HomeViewControlle", bundle: nil)
////        
////        navContorller = SlideNavigationController.init(rootViewController: obj)
////        self.window = UIWindow(frame: UIScreen.main.bounds)
////        self.window?.rootViewController = navContorller
////        navContorller?.navigationBar.isHidden = true
////        self.window?.makeKeyAndVisible()
//=======
        self.sliderMenuControllser()
       // let obj : HomeViewControlle = HomeViewControlle(nibName: "HomeViewControlle", bundle: nil)
        
//        navContorller = SlideNavigationController.init(rootViewController: obj)
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = navContorller
//        navContorller?.navigationBar.isHidden = true
//        self.window?.makeKeyAndVisible()
//>>>>>>> a13e96c6d8c53c14144ab82d6a026b09a1d35d23
        
        
        
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted)
                {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                else{
                    //Do stuff if unsuccessful...
                }
            })
            
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        application.applicationIconBadgeNumber = 0
        Thread.sleep(forTimeInterval: 2)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.sliderMenuControllser()
        
     //   self.checkNewVerisonAvailabel(viewController:)
        
     //---- FONT FAMILY
//        let fontFamilyNames = UIFont.familyNames
//        for familyName in fontFamilyNames {
//            print("------------------------------")
//            print("Font Family Name = [\(familyName)]")
//            let names = UIFont.fontNames(forFamilyName: familyName )
//            print("Font Names = [\(names)]")
//        }

        self.sliderMenuControllser()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
      
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.application(application, didFinishLaunchingWithOptions: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
            strLanguage = UserDefaults.standard.value(forKey: "LanguageSelected") as! String
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
      
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Tawsila")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: - NOTIFICATIONCENTER
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        deviceTokenStr = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        
        print(deviceTokenStr)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("i am not available in simulator \(error)")
        
    }
    

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: - Validate User Information Fields  ///vikram singh depawat
    
    // check Validation on Email field
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) as NSPredicate? {
            return emailTest.evaluate(with: testStr)
        }
        return false
    }
    
    // check validation on User Name field
    func isValidUserName(_ testStr: String)->Bool{
    
        let userNameRegEx = "[A-Za-z]{3,30}"
        if let userNameTest = NSPredicate(format: "SELF MATCHES %@", userNameRegEx) as NSPredicate?{
            return userNameTest.evaluate(with:testStr)
        }
        return false
    }
    
    // check validation on mobile field
    func isValidMobileNumber(_ testStr: String)->Bool{
       let mobNumerRegEx = "[0-9]{10}"
        if let mobileTest = NSPredicate(format: "SELF MATCHES %@", mobNumerRegEx) as NSPredicate?{
            return mobileTest.evaluate(with:testStr)
        }
        return false
    }
    
    //check validation on password field
    func isValidPassword(_ testStr: String)->Bool{
        
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{6,32}$"
        if let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx) as NSPredicate?
        {
            return passwordTest.evaluate(with: testStr)
        }
        return false
    }

    
    
    
    func sliderMenuControllser()
    {
        self.window = UIWindow(frame:  UIScreen.main.bounds)
        self.window?.backgroundColor=UIColor(white: 255.0, alpha: 1.0)
      
        let userId  = USER_DEFAULT.object(forKey: "isLogin") as? String
        if userId == "0" || userId == nil
        {
            let homeVC : SignInOrCreateNewAccount = SignInOrCreateNewAccount(nibName : "SignInOrCreateNewAccount" , bundle : nil)
            self.navController = SlideNavigationController(rootViewController: homeVC)
        }
        else
        {
          
            let homeVC : HomeViewControlle = HomeViewControlle(nibName : "HomeViewControlle" , bundle : nil)
            self.navController = SlideNavigationController(rootViewController: homeVC)
            
        }
          self.navController?.isNavigationBarHidden  = true
        UINavigationBar.appearance().isTranslucent = false
     
        let leftVC : LeftMenuViewController = LeftMenuViewController(nibName : "LeftMenuViewController" , bundle : nil)
        SlideNavigationController.sharedInstance().leftMenu=leftVC
        
        let rightVC: rightMenuViewController = rightMenuViewController(nibName: "rightMenuViewController", bundle: nil)
        SlideNavigationController.sharedInstance().rightMenu = rightVC
        
        self.window?.rootViewController = self.navController
        self.window?.makeKeyAndVisible()
    
    }
    //MARK: --------------- LOGOUT A USER ---------------
    
    func logoutAUser()
    {
        
//        do {
//            
//            var request = URLRequest(url: URL(string: String(format : "%@logout&username=%@&unique_id=%@",BSE_URL,((UserDefaults.standard.object(forKey: "userData") as? NSDictionary)!.object(forKey: "email") as? String)!,self.UUID()))!)
//            let session = URLSession.shared
//            request.httpMethod = "GET"
//            
//            let task = session.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                    OperationQueue.main.addOperation {
//                    }
//                    print("error=\(error)")
//                    return
//                }
//                
//                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                    print("response = \(response)")
//                }
//                
//                let responseString = String(data: data, encoding: .utf8)
//                print("responseString = \(responseString)")
//                
//                
//                
//            }
//            task.resume()
//            
//        } catch let error {
//            print("got an error creating the request: \(error)")
//        }
        
    }
    
    //MARK: --------------- GET UDID ---------------
  //  func UUID() -> String {
        
//        let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
//        let accountName = "incoding"
//        
//        var applicationUUID = SSKeychain.password(forService: bundleName, account: accountName)
//        
//        if applicationUUID == nil {
//            
//            applicationUUID = UIDevice.current.identifierForVendor?.uuidString
//            
//            SSKeychain.setPassword(applicationUUID, forService: bundleName, account: accountName)
//            // Save applicationUUID in keychain without synchronization
//        }
//        
//        return applicationUUID!
//}
    
    
    
    
    // MARK: -------------------------- Get User Curretn Location --------------
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = manager.location
        lat = location!.coordinate.latitude
        long = location!.coordinate.longitude
        latitude = String(format: "%f",lat)
        longitude = String(format: "%f",long)
        
    }
    func getLocationInfo(latitude : Double , longitude : Double) -> NSArray
    {
        let address : NSMutableArray  = []
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary)
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString
            {
                print(locationName)
            }
            
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                print(street)
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                UserDefaults.standard.set(city, forKey: "city")
                UserDefaults.standard.synchronize()
                
                address.add(city)
                print(city)
            }
            
            
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                print(zip)
            }
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                UserDefaults.standard.set(country, forKey: "country")
                UserDefaults.standard.synchronize()
                
                address.add(country)
                print(country)
            }
            
            
        })
        return address
    }
    
    

    
    //MARK: --------------- Check APP VERSION ---------------
    func checkNewVerisonAvailabel(viewController : UIViewController)
    {
        do {
             var request = URLRequest(url: URL(string: String(format : "%@get_app_version",BSE_URL))!)
            let session = URLSession.shared
            request.httpMethod = "POST"
            
            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    OperationQueue.main.addOperation {
                    }
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        OperationQueue.main.addOperation {
                            let dict = parseJSON["result"] as! NSDictionary
                            let availabelVerDict = dict.object(forKey: "results") as! NSDictionary
                            
                            let dict1 = availabelVerDict.object(forKey: "") as! NSDictionary
                            
                            let availabelVer = dict1.object(forKey: "app_version") as! NSString
                            
                            
                            Utility.sharedInstance.showAlert(kAPPName, msg: availabelVer as String, controller: viewController)
                            let nsObject: AnyObject! = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
                            
                            
                            let versionC = nsObject as! NSString
                            if (availabelVer).floatValue > (versionC).floatValue
                            {
                                let vMSG  = String(format : "New version available(%@) ", dict.object(forKey: "Version") as! String)
                                let vMSGDesc  =  dict.object(forKey: "Description") as! String
                                let alertController = UIAlertController(title: vMSG, message: vMSGDesc, preferredStyle: .alert)
                                
                                let sendButton = UIAlertAction(title: "Download", style: .default, handler: { (action) -> Void in
                                  //  open(scheme: "https://www.google.com/")
                                })
                                
                                
                                let cancelButton = UIAlertAction(title: "Remind Me later", style: .cancel, handler: { (action) -> Void in
                                    
                                })
                                
                                
                                alertController.addAction(sendButton)
                                
                                alertController.addAction(cancelButton)
                                
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }
                        }
                        
                    }
                    
                }
                catch {
                    print(error)
                    OperationQueue.main.addOperation {
                        
                        
                    }
                }
                
            }
            task.resume()
            
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    
    // MARK: -------------------------- HEX STRING TO COLOR --------------
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor (
            
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    // MARK: -------------------------- Convert Null to nill string --------------
    func convertAllDictionaryValueToNil(_ dict: NSMutableDictionary) -> NSMutableDictionary
    {
        let arrayOfKeys = dict.allKeys as NSArray
        print(arrayOfKeys)
        for i in 0..<arrayOfKeys.count
        {
            if (dict.object(forKey: arrayOfKeys.object(at: i))) is NSNull
            {
                dict .setObject("" as AnyObject, forKey: arrayOfKeys.object(at: i) as! String as NSCopying)
            }
        }
        
        return dict
    }
   
    //MARK:-------------------------Check App Langauge---------------------------------------
    func checkAppLanguage() -> String {
        // Get selectedLanguage for UserDefault  Vikram Singh depawat
        var lang : String!
        if UserDefaults.standard.value(forKey: "LanguageSelected") != nil  {
            lang = UserDefaults.standard.value(forKey: "LanguageSelected") as! String
        }
        else {
            UserDefaults.standard.setValue("en", forKey: "LanguageSelected")
            lang = "en"
        }
        return lang
    }
}

