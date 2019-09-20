//
//  UtiliseeAvanceeResultatController.swift
//  SayaraDz
//
//  Created by Mac on 9/15/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit

class UtiliseeAvanceeResultatController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var navBar: UIViewNavBar!
    @IBOutlet weak var AnnoncesTableView: UITableView!
    var annoncesJSON: Array<Annonce>?
    let annonceImagesCache = NSCache<AnyObject, AnyObject>.init()
    
    var codeVersion: String = ""
    var carburant: String = ""
    var minAnnee: String = ""
    var maxAnnee: String = ""
    var minPrix: String = ""
    var maxPrix: String = ""
    var minKm: String = ""
    var maxKm: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.AnnoncesTableView.delegate = self
        self.AnnoncesTableView.dataSource = self
        let defaults = UserDefaults.standard
        let idAutomobiliste = defaults.string(forKey: "IdAutomobiliste")
        self.getAllAnnoncesAvancee(idAutomobiliste: idAutomobiliste!, CodeVersion: codeVersion, Carburant: carburant, minAnnee: minAnnee, maxAnnee: maxAnnee, minPrix: minPrix, maxPrix: maxPrix, maxKm: maxKm)
    }
    
    
    func initView() {
        navBar.menuButton.setBackgroundImage(UIImage(named: "back"), for: UIControlState.normal)
        navBar.title.text = "Voiture utilisée - Avancée"
        navBar.menuButton.addTarget(self, action: #selector(UtiliseeAvanceeResultatController.backButtonClicked(_:)), for: .touchUpInside)

    }
    
    @objc func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.00
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( self.annoncesJSON != nil ) {
            return annoncesJSON!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnonceCell", for: indexPath) as! AnnonceCell
        let currentAnnonce = annoncesJSON?[indexPath.row]
        if (currentAnnonce!.images.count != 0 ) {
            let urlString = URL(string: (currentAnnonce!.images[0].CheminImage))
            if let imageFromCache = annonceImagesCache.object(forKey: urlString as AnyObject) as? UIImage {
                cell.annonceImage.image = imageFromCache
            } else {
                DispatchQueue.global(qos: .background).async {
                    if let data = try? Data(contentsOf: urlString!) {
                        let imageToCache = UIImage(data: data)
                        self.annonceImagesCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        cell.annonceImage.image = UIImage(data: data)
                    }
                    DispatchQueue.main.async {
                        print("when done")
                    }
                }
                
            }
            cell.annonceImage.clipsToBounds = true
            cell.annonceImage.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        }
        cell.annonceTitle.text = "\(currentAnnonce!.version.NomMarque) \(currentAnnonce!.version.NomModele) \(currentAnnonce!.version.NomVersion)"
        cell.annoncePrice.text = "\(currentAnnonce!.Prix) DZD"
        cell.annonceKm.text = currentAnnonce!.Km
        cell.annonceEnergy.text = currentAnnonce!.Carburant
        cell.annonceYear.text = "\(currentAnnonce!.Annee)"
        return cell
    }
    

    func getAllAnnoncesAvancee(idAutomobiliste : String, CodeVersion: String, Carburant: String, minAnnee: String, maxAnnee: String, minPrix: String, maxPrix: String, maxKm: String) {
        print("getting annonces")
        let defaults = UserDefaults.standard
        let idAutomobiliste = defaults.string(forKey: "IdAutomobiliste")
        AnnonceService.sharedInstance.getAllAnnoncesAvancee(idAutomobiliste : idAutomobiliste!, CodeVersion: CodeVersion, Carburant: Carburant, minAnnee: minAnnee, maxAnnee: maxAnnee, minPrix: minPrix, maxPrix: maxPrix, maxKm: maxKm, onSuccess: { data in
            let decoder = JSONDecoder()
            self.annoncesJSON = try? decoder.decode(Array<Annonce>.self, from: data)
            DispatchQueue.main.async {
                self.AnnoncesTableView.reloadData()
                print(self.annoncesJSON?.count)
            }
        }, onFailure: { error in
            print(error)
            
        })
    }

}
