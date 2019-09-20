//
//  CommandeController.swift
//  SayaraDz
//
//  Created by Mac on 7/5/19.
//  Copyright © 2019 mossab. All rights reserved.
//
import UIKit
import BraintreeDropIn
import Braintree


struct pageInfo {
    var versionName : String
    var versionDescription : String
    var versionPrice : String
    var versionImage : UIImage
    var versionCode : String
    var marqueCode : String
    var codeCouleur : String
    var clientName : String
    var clientEmail : String
    var clientPhone : String
    var versionImageChemin : String
}

class CommandeController: UIViewController {
    
    @IBOutlet weak var navBar: UIViewNavBar!
    @IBOutlet weak var montantLabel: UITextFieldCircleBorder!
    @IBOutlet weak var versionName: UILabel!
    @IBOutlet weak var versionDescription: UILabel!
    @IBOutlet weak var versionPrice: UILabel!
    @IBOutlet weak var versionImage: UIImageView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientEmail: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var confirmationButton: UIButtonBorderRadius!
    
    var commandeJSON: Commande?
    var commandeId: Int?
    var clientTokenJSON: ClientTokenCommande?
    var idAutomobiliste: String?
    var userToken: String?
    var vehiculeDisponibilityJSON: Array<VehiculeDisponobility>?
    var pageInfos: pageInfo = pageInfo.init(versionName: "", versionDescription: "", versionPrice: "", versionImage: UIImage.init(), versionCode: "", marqueCode: "", codeCouleur: "", clientName: "", clientEmail: "", clientPhone: "", versionImageChemin: "")
    var nom: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        self.idAutomobiliste = defaults.string(forKey: "IdAutomobiliste")!
        self.userToken = defaults.string(forKey: "Token")!
        self.initView()
    }
    
    func initView() {
        self.versionName.text = pageInfos.versionName
        self.versionDescription.text = "Le modéle de cette version est : \(pageInfos.versionDescription)"
        self.versionPrice.text = pageInfos.versionPrice
        if ( pageInfos.versionImage.images != nil ) {
            self.versionImage.image = pageInfos.versionImage
        } else {
            if(pageInfos.versionImageChemin != "") {
                let urlString = URL(string: pageInfos.versionImageChemin)
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        if let data = try? Data(contentsOf: urlString!) {
                            self.versionImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        self.clientName.text = pageInfos.clientName.uppercased()
        self.clientEmail.text = pageInfos.clientEmail
        self.clientPhone.text = pageInfos.clientPhone
        
        //self.confirmationButton.isEnabled = false
        montantLabel.addTarget(self, action: #selector(myTargetFunction), for: UIControlEvents.touchDown)

        navBar.menuButton.setBackgroundImage(UIImage(named: "back"), for: UIControlState.normal)
        navBar.title.text = "Commande"
        navBar.menuButton.addTarget(self, action: #selector(CommandeController.backButtonClicked(_:)), for: .touchUpInside)

    }
    
    @IBAction func OnConfirmationButtonClick(_ sender: Any) {
        //self.getToken()
        //self.pageInfos.codeCouleur = "6"
        self.getDisponibility(codeVersion: self.pageInfos.versionCode, codeCouleur: "\(self.pageInfos.codeCouleur)")
    }
    
    
    @objc func myTargetFunction(textField: UITextField) {
        if ( textField.text != "" ) {
            self.confirmationButton.isEnabled = true
        }
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                let nonce: String = ((result.paymentMethod?.nonce)!)

                self.postNonce(idCommande: self.commandeId! , Montant: "\(self.montantLabel!.text! )", payment_method_nonce: nonce)
                
            
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    @objc func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getToken() {
        CommandeService.sharedInstance.getToken(onSuccess: { data in
            let decoder = JSONDecoder()
            self.clientTokenJSON = try? decoder.decode(ClientTokenCommande.self, from: data)
            DispatchQueue.main.async {
                self.showDropIn(clientTokenOrTokenizationKey: self.clientTokenJSON!.clientToken)
            }
        }, onFailure: { error in
            print(error)
        })
    }
    
    func getDisponibility(codeVersion: String, codeCouleur: String) {
        VehiculeService.sharedInstance.getDisponibility(codeVersion: codeVersion, codeCouleur: codeCouleur,onSuccess: { data in
            let decoder = JSONDecoder()
            self.vehiculeDisponibilityJSON = try? decoder.decode(Array<VehiculeDisponobility>.self, from: data)
            DispatchQueue.main.async {
                if ( self.vehiculeDisponibilityJSON != nil && self.vehiculeDisponibilityJSON!.count != 0) {
                    self.createCommande(idAutomobiliste: self.idAutomobiliste!, NumChassis: (self.vehiculeDisponibilityJSON?[0].NumChassis)!, Montant: (self.vehiculeDisponibilityJSON?[0].Montant)!, Fabricant: self.pageInfos.marqueCode)
                } else {
                    let alertController = UIAlertController(title: "Non disponible", message: "la version n'est pas disponible", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction!) in
                    }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion:nil)
                }
            }
        }, onFailure: { error in
            print(error)
        })
    }
    
    func createCommande(idAutomobiliste: String, NumChassis: Int, Montant: Int, Fabricant: String) {
        CommandeService.sharedInstance.createCommande(Token: self.userToken!, idAutomobiliste: idAutomobiliste, NumChassis: NumChassis, Montant: Montant, Fabricant: Fabricant,onSuccess: { data in
            let decoder = JSONDecoder()
            self.commandeJSON = try? decoder.decode(Commande.self, from: data)
            DispatchQueue.main.async {
                print(self.commandeJSON)
                self.commandeId = self.commandeJSON?.idCommande
                self.getToken()
            }
        }, onFailure: { error in
            print(error)
        })
    }
    
    func postNonce(idCommande: Int, Montant: String, payment_method_nonce: String) {
        CommandeService.sharedInstance.postNonce(IdCommande: idCommande, Montant: Montant, Nonce: payment_method_nonce, onSuccess: { data in
            /*let decoder = JSONDecoder()
            self.commandeJSON = try? decoder.decode(Commande.self, from: data)*/
            DispatchQueue.main.async {
                //self.commandeId = self.commandeJSON?.idCommande
                //self.getToken()
                let strs = String(decoding: data, as: UTF8.self)
                print(strs)
            }
        }, onFailure: { error in
            print(error)
        })
    }
 
}
