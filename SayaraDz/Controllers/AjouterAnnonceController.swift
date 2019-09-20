//
//  AjouterAnnonceController.swift
//  SayaraDz
//
//  Created by Mac on 9/2/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit

class AjouterAnnonceController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate  {

    
    @IBOutlet weak var tokenImage: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var marqueButton: UIButton!
    @IBOutlet weak var marqueLabel: UILabel!
    @IBOutlet weak var modeleButton: UIButton!
    @IBOutlet weak var modeleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionButton: UIButton!
    @IBOutlet weak var carburantLabel: UILabel!
    @IBOutlet weak var carburantButton: UIButton!
    
    @IBOutlet weak var prixLabel: UITextFieldCircleBorder!
    @IBOutlet weak var anneeLabel: UITextFieldCircleBorder!
    @IBOutlet weak var couleurLabel: UITextFieldCircleBorder!
    @IBOutlet weak var kmLabel: UITextFieldCircleBorder!
    @IBOutlet weak var photoButton: UIButtonBorderRadiusPurple!
    @IBOutlet weak var changePhotoButton: UIButtonBorderRadiusPurple!
    @IBOutlet weak var photoLabel: UILabel!

    @IBOutlet weak var pickerView: ToolbarPickerView!
    @IBOutlet weak var navBar: UIViewNavBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var toolbarButton: UIBarButtonItem!
    
    var marquesJSON: Array<Marque>?
    var chosenMarqueID: Int = -1
    var modelesJSON: Array<Modele>?
    var chosenModeleID: Int = -1
    var versionsJSON: Array<Version>?
    var chosenVersionID: Int = -1
    var chosenCarburant: String?
    var chosenKm: String?
    var chosenCouleur: String?
    var chosenAnnee: String?
    var chosenPrix: String?
    let carburantList = ["Essence", "Diesel", "GPL"]
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.anneeLabel.delegate = self
        self.kmLabel.delegate = self
        self.couleurLabel.delegate = self
        self.prixLabel.delegate = self
        self.initView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        if (textField.tag == 0) {
            chosenKm = kmLabel.text
        } else if (textField.tag == 1) {
            chosenCouleur = couleurLabel.text
        } else if (textField.tag == 2) {
            chosenAnnee = anneeLabel.text
        }  else if (textField.tag == 3) {
            chosenPrix = prixLabel.text
        }
        return true
    }
    

 
    func initView() {
        self.indicator.isHidden = true
        changePhotoButton.isHidden = true
        navBar.menuButton.setBackgroundImage(UIImage(named: "back"), for: UIControlState.normal)
        navBar.title.text = "Ajouter Annonce"
        navBar.menuButton.addTarget(self, action: #selector(AjouterAnnonceController.backButtonClicked(_:)), for: .touchUpInside)
        marqueButton.addTarget(self, action: #selector(AjouterAnnonceController.OnMarqueButtonClick(_:)), for: .touchUpInside)
        modeleButton.addTarget(self, action: #selector(AjouterAnnonceController.OnModeleButtonClick(_:)), for: .touchUpInside)
        versionButton.addTarget(self, action: #selector(AjouterAnnonceController.OnVersionButtonClick(_:)), for: .touchUpInside)
        carburantButton.addTarget(self, action: #selector(AjouterAnnonceController.OnCarburantButtonClick(_:)), for: .touchUpInside)
    }
    
    
    @IBAction func takePhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getImage(fromSourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(fromSourceType) {
            imagePicker.delegate = self
            imagePicker.sourceType = fromSourceType
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        tokenImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoButton.isHidden = true
        photoLabel.isHidden = true
        changePhotoButton.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for i in [1, 2] {
        //    self.pickerView.subviews[i].isHidden = true
        }
    }
    
    @objc func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func OnMarqueButtonClick(_ sender: UIButton) {
        self.initPickerView()
        self.pickerView.tag = 0
        if (marquesJSON == nil) {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            self.getAllMarques()
        }
        self.afficherPickerView(_sender: sender)
    }
    
    @objc func OnModeleButtonClick(_ sender: UIButton) {
        self.initPickerView()
        self.pickerView.tag = 1
        if (modelesJSON == nil) {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            self.getAllModeles()
        }
        self.afficherPickerView(_sender: sender)
    }
    
    @objc func OnVersionButtonClick(_ sender: UIButton) {
        self.initPickerView()
        self.pickerView.tag = 2
        if(versionsJSON == nil) {
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            self.getAllVersions()
        }
        self.afficherPickerView(_sender: sender)
    }
    
    @objc func OnCarburantButtonClick(_ sender: UIButton) {
        self.initPickerView()
        self.pickerView.tag = 3
        self.pickerView.reloadAllComponents()
        self.afficherPickerView(_sender: sender)
    }
    
    func initPickerView() {
        self.pickerView.tag = -1
        self.pickerView.reloadAllComponents()
    }

    func afficherPickerView(_sender: UIButton) {
        self.pickerView.reloadAllComponents()
        self.ArrowButtonsDown()
        if ( self.pickerView.isHidden == false ) {
            self.toolbar.isHidden = true
            self.pickerView.isHidden = true
            _sender.setImage(UIImage(named: "arrow_down"), for: .normal)
        } else {
            self.toolbar.isHidden = false
            self.pickerView.isHidden = false
            _sender.setImage(UIImage(named: "arrow_up"), for: .normal)
        }
    }
    
    @IBAction func OnToolbarButtonClick(_ sender: Any) {
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
        self.ArrowButtonsDown()
        self.toolbar.isHidden = true
        self.pickerView.isHidden = true
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        if (self.pickerView.tag == 0) {
            if (marquesJSON != nil && marquesJSON?.count != 0) {
                chosenMarqueID = marquesJSON![row].CodeMarque
                marqueLabel.text = marquesJSON![row].NomMarque
            }
        } else if (self.pickerView.tag == 1) {
            if (modelesJSON != nil && modelesJSON?.count != 0) {
                chosenModeleID = modelesJSON![row].CodeModele
                modeleLabel.text = modelesJSON![row].NomModele
            }
        } else if (self.pickerView.tag == 2) {
            if (versionsJSON != nil && versionsJSON?.count != 0) {
                chosenVersionID = versionsJSON![row].CodeVersion
                versionLabel.text = versionsJSON![row].NomVersion
            }
        } else if (self.pickerView.tag == 3)  {
            carburantLabel.text = carburantList[row]
            chosenCarburant = carburantList[row]
        } else {
            
        }
    }
    
    func ArrowButtonsDown() {
        self.marqueButton.setImage(UIImage(named: "arrow_down"), for: .normal)
        self.modeleButton.setImage(UIImage(named: "arrow_down"), for: .normal)
        self.versionButton.setImage(UIImage(named: "arrow_down"), for: .normal)
        self.carburantButton.setImage(UIImage(named: "arrow_down"), for: .normal)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (marquesJSON != nil && self.pickerView.tag == 0) {
            return (marquesJSON?.count)!
        }
        else if (modelesJSON != nil && self.pickerView.tag == 1) {
            return (modelesJSON?.count)!
        }
        else if (versionsJSON != nil && self.pickerView.tag == 2) {
            return (versionsJSON?.count)!
        } else if (self.pickerView.tag == 3) {
            return carburantList.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (marquesJSON != nil && self.pickerView.tag == 0) {
            return marquesJSON![row].NomMarque
        }
        else if (modelesJSON != nil && self.pickerView.tag == 1) {
            return modelesJSON![row].NomModele
        }
        else if (versionsJSON != nil && self.pickerView.tag == 2) {
            return versionsJSON![row].NomVersion
        } else if (self.pickerView.tag == 3) {
            return carburantList[row]
        }
        return nil
    }
    
    func getAllMarques() {
        if (self.marquesJSON == nil) {
            MarqueService.sharedInstance.getAllMarques(onSuccess: { data in
                let decoder = JSONDecoder()
                self.marquesJSON = try? decoder.decode(Array<Marque>.self, from: data)
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    self.pickerView.reloadAllComponents()
                }
            }, onFailure: { error in
                print(error)
            })
        }
    }
    
    func getAllModeles() {
        if ( chosenMarqueID != -1 ) {
            if (self.modelesJSON == nil) {
                ModeleService.sharedInstance.getAllModeles(codeMarque: chosenMarqueID,onSuccess: { data in
                    let decoder = JSONDecoder()
                    self.modelesJSON = try? decoder.decode(Array<Modele>.self, from: data)
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.pickerView.reloadAllComponents()
                    }
                }, onFailure: { error in
                    print(error)
                })
            }
        }
    }
    
    func getAllVersions() {
        if ( chosenModeleID != -1 ) {
            if (self.versionsJSON == nil) {
                VersionService.sharedInstance.getAllVersions(codeModele: chosenModeleID, onSuccess: { data in
                    let decoder = JSONDecoder()
                    self.versionsJSON = try? decoder.decode(Array<Version>.self, from: data)
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.pickerView.reloadAllComponents()
                    }
                }, onFailure: { error in
                    print(error)
                })
            }
        }
    }
    
    func verifyFields() -> Bool {
        return (chosenMarqueID != -1 && chosenModeleID != -1 && chosenVersionID != -1 && chosenKm != nil && chosenCouleur != nil && chosenCouleur != "" && chosenAnnee != nil && chosenAnnee != "" && chosenCarburant != nil && chosenCarburant != "" && chosenPrix != nil && chosenPrix != "" && tokenImage != nil)
    }
    
    @IBAction func AjouterAnnonce(_ sender: Any) {
        //if (verifyFields()) {
        
            chosenKm = kmLabel.text
            chosenCouleur = couleurLabel.text
            chosenAnnee = anneeLabel.text
            chosenPrix = prixLabel.text
            let defaults = UserDefaults.standard
            var idAutomobiliste = defaults.string(forKey: "IdAutomobiliste")
            //idAutomobiliste = "380466752766558"
            self.createAnnonce(Prix: chosenPrix!, idAutomobiliste: idAutomobiliste!, CodeVersion: "\(chosenVersionID)", Couleur: chosenCouleur!, Km: chosenKm!, Annee: chosenAnnee!, Carburant: chosenCarburant!, Description: "")
        //} else {
        //    print("not all filled")
        //}
    }
    
    func createAnnonce(Prix : String, idAutomobiliste: String, CodeVersion: String, Couleur: String, Km: String, Annee: String, Carburant: String, Description: String) {
        print("creating annonce")
        AnnonceService.sharedInstance.createAnnonce(photo: tokenImage.image!,Prix : Prix, idAutomobiliste: idAutomobiliste, CodeVersion: CodeVersion, Couleur: Couleur, Km: Km, Annee: Annee, Carburant: Carburant, Description: Description, onSuccess: { data in
            self.showSuccessAlert()
            DispatchQueue.main.async {
            }
        }, onFailure: { error in
            print(error)
        })
    }
    
    func showSuccessAlert() {
        let alertController = UIAlertController(title: "Annonce ajoutée", message: "Votre annonce a été ajoutée avec succès", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
}
