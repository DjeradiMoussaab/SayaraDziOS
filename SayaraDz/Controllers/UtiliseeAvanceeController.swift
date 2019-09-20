//
//  UtiliseeAvanceeController.swift
//  SayaraDz
//
//  Created by Mac on 7/6/19.
//  Copyright © 2019 mossab. All rights reserved.
//

class EnergieCell: UICollectionViewCell  {
    @IBOutlet weak var energieImage: UIImageView!
    @IBOutlet weak var energieTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.energieImage?.image = nil
    }
}

import UIKit
import SwiftRangeSlider

class UtiliseeAvanceeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var EnergieTitles = ["Essence Normale", "Essence Super", "Essence sans plomb", "Diesel", "GPL"]
    @IBOutlet weak var navBar: UIViewNavBar!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var marqueView: UIViewGreyBorderRadius!
    @IBOutlet weak var marqueViewButton: UIButton!
    @IBOutlet weak var marqueViewLabel: UILabel!
    @IBOutlet weak var marqueViewTableView: UITableViewGreyBorderRadius!
    @IBOutlet weak var chosenMarque: UIViewChosenLabel!
    
    @IBOutlet weak var modeleView: UIViewGreyBorderRadius!
    @IBOutlet weak var modeleViewButton: UIButton!
    @IBOutlet weak var modeleViewLabel: UILabel!
    @IBOutlet weak var modeleViewTableView: UITableViewGreyBorderRadius!
    @IBOutlet weak var chosenModel: UIViewChosenLabel!
    
    @IBOutlet weak var versionView: UIViewGreyBorderRadius!
    @IBOutlet weak var versionViewButton: UIButton!
    @IBOutlet weak var versionViewLabel: UILabel!
    @IBOutlet weak var versionViewTableView: UITableViewGreyBorderRadius!
    @IBOutlet weak var chosenVersion: UIViewChosenLabel!
    
    @IBOutlet weak var minAnnee: UITextField!
    @IBOutlet weak var maxAnnee: UITextField!
    @IBOutlet weak var energieCollectionView: UICollectionView!
    @IBOutlet weak var minPrix: UITextField!
    
    @IBOutlet weak var maxPrix: UITextField!
    
    @IBOutlet weak var maxKm: UITextField!
    @IBOutlet weak var minKm: UITextField!
    @IBOutlet weak var searchButton: UIButtonBorderRadius!

    
    var versionIndexPath: Int = -1
    var modeleIndexPath: Int = -1
    var marqueIndexPath: Int = -1
    var marquesJSON: Array<Marque>?
    var chosenMarqueID: Int = -1
    var modelesJSON: Array<Modele>?
    var chosenModeleID: Int = -1
    var versionsJSON: Array<Version>?
    var chosenVersionID: Int = -1
    let marqueImagesCache = NSCache<AnyObject, AnyObject>.init()
    var originalHeight: Int = 0
    var containerHeight: NSLayoutConstraint?
    var chosenCarburant: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.originalHeight = Int(self.container.layer.frame.height)
        for constraint in self.container.constraints {
            if constraint.identifier == "height" {
                self.containerHeight = constraint
            }
        }
        self.marqueViewTableView.delegate = self
        self.marqueViewTableView.dataSource = self
        self.modeleViewTableView.delegate = self
        self.modeleViewTableView.dataSource = self
        self.versionViewTableView.delegate = self
        self.versionViewTableView.dataSource = self
        self.energieCollectionView.delegate = self
        self.energieCollectionView.dataSource = self

        self.initView()
    }
    

    func initView() {
        navBar.menuButton.setBackgroundImage(UIImage(named: "back"), for: UIControlState.normal)
        navBar.title.text = "Voiture utilisée - Avancée"
        navBar.menuButton.addTarget(self, action: #selector(UtiliseeAvanceeController.backButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func OnClickMarqueViewButton(_ sender: Any) {
        if (self.marqueView.frame.size.height <= 100) {
            self.marqueViewButton.setImage(UIImage(named: "arrow_up.png"), for: UIControlState.normal)
            self.getAllMarques()
            if (self.marquesJSON == nil) {
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    //self.marqueActivityIndicator.alpha = 1
                    //self.marqueActivityIndicator.startAnimating()
                })
            }
            chosenMarque.close()
            marqueView.Open()
            marqueViewTableView.Open()
            modeleView.Close()
            versionView.Close()
            modeleViewTableView.Close()
            versionViewTableView.Close()
        } else {
            if ( chosenMarqueID != -1 ) {
                chosenMarque.show()
            }
            self.marqueViewButton.setImage(UIImage(named: "arrow_down.png"), for: UIControlState.normal)
            //self.marqueActivityIndicator.isHidden = true
            //self.marqueActivityIndicator.stopAnimating()
            marqueView.Close()
            marqueViewTableView.Close()
        }
    }
    
    @IBAction func OnClickModeleViewButton(_ sender: Any) {
        if (self.modeleView.frame.size.height <= 100) {
            self.modeleViewButton.setImage(UIImage(named: "arrow_up.png"), for: UIControlState.normal)
            self.getAllModeles()
            let bottom = self.modeleView.layer.frame.origin.y + 300
            if (Int(bottom) > self.originalHeight) {
                //  self.containerHeight?.constant = bottom + 30
            }
            chosenModel.close()
            modeleView.Open()
            modeleViewTableView.Open()
            marqueView.Close()
            versionView.Close()
            marqueViewTableView.Close()
            versionViewTableView.Close()
        } else {
            if ( chosenModeleID != -1 ) {
                chosenModel.show()
            }
            self.modeleViewButton.setImage(UIImage(named: "arrow_down.png"), for: UIControlState.normal)
            modeleView.Close()
            modeleViewTableView.Close()
            self.containerHeight?.constant = CGFloat(self.container.layer.frame.height)
        }
    }
    @IBAction func OnClickVersionViewButton(_ sender: Any) {
        if (self.versionView.frame.size.height <= 100) {
            self.versionViewButton.setImage(UIImage(named: "arrow_up.png"), for: UIControlState.normal)
            self.getAllVersions()
            let bottom = self.versionView.layer.frame.origin.y + 300
            if (Int(bottom) > self.originalHeight) {
                // self.containerHeight?.constant = bottom + 30
            }
            chosenVersion.close()
            versionView.Open()
            versionViewTableView.Open()
            marqueView.Close()
            modeleView.Close()
            modeleViewTableView.Close()
            marqueViewTableView.Close()
        } else {
            if ( chosenVersionID != -1 ) {
                chosenVersion.show()
            }
            self.versionViewButton.setImage(UIImage(named: "arrow_down.png"), for: UIControlState.normal)
            versionView.Close()
            versionViewTableView.Close()
            self.containerHeight?.constant = CGFloat(self.container.layer.frame.height)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( tableView.tag == 0 ) {
            if (self.marquesJSON != nil ) {
                return marquesJSON!.count
            }
        }
        if ( tableView.tag == 1 ) {
            if (self.modelesJSON != nil ) {
                return modelesJSON!.count
            }
        }
        if (tableView.tag == 2) {
            if (self.versionsJSON != nil ){
                return versionsJSON!.count
            }
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView.tag == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarqueCell", for: indexPath) as! MarqueCell
            cell.marqueName.text = marquesJSON?[indexPath.row].NomMarque
            if (marquesJSON?[indexPath.row].images.count != 0 ) {
                let urlString = URL(string: (marquesJSON?[indexPath.row].images[0].CheminImage)!)
                if let imageFromCache = marqueImagesCache.object(forKey: urlString as AnyObject) as? UIImage {
                    cell.marqueImage.image = imageFromCache
                } else {
                    DispatchQueue.global(qos: .background).async {
                        if let data = try? Data(contentsOf: urlString!) {
                            let imageToCache = UIImage(data: data)
                            self.marqueImagesCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                            cell.marqueImage.image = UIImage(data: data)
                        }
                        DispatchQueue.main.async {
                            //print("when done")
                        }
                    }
                }
            }
            return cell
        } else if (tableView.tag == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModeleCell", for: indexPath) as! ModeleCell
            cell.modeleName.text = modelesJSON?[indexPath.row].NomModele
            cell.modeleFavorite.image = UIImage(named: "5")
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VersionCell", for: indexPath) as! VersionCell
            cell.versionName.text = versionsJSON?[indexPath.row].NomVersion
            cell.versionFavorite.image = UIImage(named: "5")
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ( tableView.tag == 0 ) {
            marqueViewButton.setImage(UIImage(named: "arrow_down.png"), for: UIControlState.normal)
            chosenMarque.Label.text = marquesJSON?[indexPath.row].NomMarque
            chosenMarque.show()
            chosenMarque.updateFrame()
            marqueView.setChosenTrue()
            marqueView.Close()
            marqueViewTableView.Close()
            chosenMarqueID = (marquesJSON?[indexPath.row].CodeMarque)!
            chosenModeleID = -1
            chosenModel.close()
            modelesJSON = nil
            modeleViewTableView.reloadData()
            chosenVersionID = -1
            chosenVersion.close()
            versionsJSON = nil
            versionViewTableView.reloadData()
            //pageControl.currentPage = 1
            searchButton.isEnabled = false
            searchButton.alpha = 0.5
            marqueIndexPath = indexPath.row
        } else if ( tableView.tag == 1 ) {
            modeleViewButton.setImage(UIImage(named: "arrow_down.png"), for: UIControlState.normal)
            chosenModel.Label.text = modelesJSON?[indexPath.row].NomModele
            chosenModel.show()
            chosenModel.updateFrame()
            modeleView.setChosenTrue()
            modeleView.Close()
            modeleViewTableView.Close()
            chosenModeleID = (modelesJSON?[indexPath.row].CodeModele)!
            //pageControl.currentPage = 2
            chosenVersionID = -1
            chosenVersion.close()
            versionsJSON = nil
            versionViewTableView.reloadData()
            searchButton.isEnabled = false
            searchButton.alpha = 0.5
            modeleIndexPath = indexPath.row
        } else if ( tableView.tag == 2 ) {
            versionViewButton.setImage(UIImage(named: "arrow_down.png"), for: UIControlState.normal)
            chosenVersion.Label.text = versionsJSON?[indexPath.row].NomVersion
            chosenVersion.show()
            chosenVersion.updateFrame()
            versionView.setChosenTrue()
            versionView.Close()
            versionViewTableView.Close()
            chosenVersionID = (versionsJSON?[indexPath.row].CodeVersion)!
            //pageControl.currentPage = 3
            searchButton.isEnabled = true
            searchButton.alpha = 1
            versionIndexPath = indexPath.row
        } else {
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnergieCell", for: indexPath) as! EnergieCell
        cell.energieImage.image = UIImage(named: "gpl")
        cell.energieTitle.text = EnergieTitles[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        for c in self.energieCollectionView.visibleCells {
            let newcell = c as! EnergieCell
            newcell.energieTitle.textColor = UIColor.darkGray
        }
        let cell = self.energieCollectionView.cellForItem(at: indexPath) as! EnergieCell
        cell.energieTitle.textColor = UIColor(red:0.35, green:0.00, blue:0.63, alpha:1.0)
        let chosenCarburant = cell.energieTitle.text
    }
    
    
    func getAllMarques() {
        if (self.marquesJSON == nil) {
            MarqueService.sharedInstance.getAllMarques(onSuccess: { data in
                let decoder = JSONDecoder()
                self.marquesJSON = try? decoder.decode(Array<Marque>.self, from: data)
                DispatchQueue.main.async {
                    self.marqueViewTableView.reloadData()
                    //self.marqueActivityIndicator.isHidden = true
                    //self.marqueActivityIndicator.stopAnimating()
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
                        self.modeleViewTableView.reloadData()
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
                        self.versionViewTableView.reloadData()
                    }
                }, onFailure: { error in
                    print(error)
                })
            }
        }
    }
    
    
    @IBAction func OnClickSearch(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let utiliseeAvanceeResultatController = storyBoard.instantiateViewController(withIdentifier: "UtiliseeAvanceeResultat") as! UtiliseeAvanceeResultatController
        utiliseeAvanceeResultatController.codeVersion = "\(chosenVersionID)"
        utiliseeAvanceeResultatController.minAnnee = "\(minAnnee.text ?? "")"
        utiliseeAvanceeResultatController.maxAnnee = "\(maxAnnee.text ?? "")"
        utiliseeAvanceeResultatController.carburant = "\(chosenCarburant)"
        utiliseeAvanceeResultatController.minPrix = "\(minPrix.text ?? "")"
        utiliseeAvanceeResultatController.maxPrix = "\(maxPrix.text ?? "")"
        utiliseeAvanceeResultatController.minKm = "\(minKm.text ?? "")"
        utiliseeAvanceeResultatController.maxKm = "\(maxKm.text ?? "")"

        self.navigationController?.pushViewController(utiliseeAvanceeResultatController, animated: true)
        // self.navigationController?.isNavigationBarHidden = true
    }
    

    
    

}
