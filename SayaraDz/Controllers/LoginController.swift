//
//  ViewController.swift
//  SayaraDz
//
//  Created by Mac on 3/4/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn


class LoginController: UIViewController, LoginButtonDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: FBLoginButton!
    
    
    var userInfo : [String : Any] = ["IdAutomobiliste" : "", "Nom": "", "Prenom" : "","Email" : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self

    }
    
    func saveUserInfo() {
        let defaults = UserDefaults.standard
        
        defaults.set(self.userInfo["IdAutomobiliste"], forKey: "IdAutomobiliste")
        defaults.set(self.userInfo["Nom"], forKey: "Nom")
        defaults.set(self.userInfo["Prenom"], forKey: "Prenom")
        defaults.set(self.userInfo["Email"], forKey: "Email")
        defaults.set(AccessToken.current!.tokenString, forKey: "Token")
        
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        saveUserInfo()
       self.loadLoggedInView()
        //self.createAutomobiliste(body: userInfo, token: AccessToken.current!.tokenString)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
    @IBAction func loginFacebookAction(_ sender: Any) {
        let fbLoginManager : LoginManager = LoginManager()
        if (AccessToken.current == nil ) {
            fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
                if (error == nil){
                    let fbloginresult : LoginManagerLoginResult = result!
                    if (result?.isCancelled)!{
                        return
                    }
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                    }
                }
            }
        } else {
            fbLoginManager.logOut()
        }
        
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    var resultDictionary = (result as! Dictionary<String, Any>)
                    self.userInfo["IdAutomobiliste"] = resultDictionary["id"]
                    self.userInfo["Nom"] = resultDictionary["last_name"]
                    self.userInfo["Prenom"] = resultDictionary["first_name"]
                    self.userInfo["Email"] = resultDictionary["email"]
                    self.saveUserInfo()
                    //self.loadLoggedInView()
                    self.createAutomobiliste(token: AccessToken.current!.tokenString, idAutomobiliste: self.userInfo["IdAutomobiliste"] as! String, Nom: self.userInfo["Nom"] as! String, Prenom: self.userInfo["Prenom"] as! String, NumTel: "00")
                }
            })
        }
    }
    
    func loadLoggedInView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NouvelleController = storyBoard.instantiateViewController(withIdentifier: "Nouvelle") as! NouvelleController
        self.navigationController?.pushViewController(NouvelleController, animated: true)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func createAutomobiliste(token: String, idAutomobiliste: String, Nom: String, Prenom: String, NumTel: String) {
        print("staaarting")

        LoginService.sharedInstance.createAutomobiliste(token: token, idAutomobiliste: idAutomobiliste, Nom: Nom, Prenom: Prenom, NumTel: NumTel, onSuccess: { data in
            print(data)
            print("doooooonnnnne")
        }, onFailure: { error in
            print(error)
            print("doooooonnnnne2")

        })
    }
    
}

