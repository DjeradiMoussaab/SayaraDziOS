//
//  SideMenuController.swift
//  SayaraDz
//
//  Created by Mac on 9/12/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SideMenuController: UIViewController  {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func CloseButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func MonProfileButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func MesFavorisButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func MesOffresButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func MesAnnoncesButtonClick(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NouvelleController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        //let mainController = storyBoard.instantiateViewController(withIdentifier: "AccueilController") as! AccueilController
        //self.navigationController?.pushViewController(NouvelleController, animated: true)
        NouvelleController.selectedIndex = 3
        self.navigationController?.isNavigationBarHidden = true
        self.show(NouvelleController, sender: NouvelleController)
        
    }
    
    @IBAction func AboutButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func ContactUsButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func WebsiteButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func DeconnecterButtonClick(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logOut()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NouvelleController = storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginController
        self.navigationController?.pushViewController(NouvelleController, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
}
