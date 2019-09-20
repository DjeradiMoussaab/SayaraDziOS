//
//  UtiliseeController.swift
//  SayaraDz
//
//  Created by Mac on 7/5/19.
//  Copyright © 2019 mossab. All rights reserved.
//

class AnnonceCell: UITableViewCell  {
    @IBOutlet weak var annonceImage: UIImageView!
    @IBOutlet weak var annonceDetails: UIButton!
    @IBOutlet weak var annonceTitle: UILabel!
    @IBOutlet weak var annoncePrice: UILabel!
    @IBOutlet weak var annonceKm: UILabel!
    @IBOutlet weak var annonceEnergy: UILabel!
    
    @IBOutlet weak var annonceYear: UILabel!
    @IBOutlet weak var addOffer: UIButtonBorderRadiusPurple!
    @IBOutlet weak var callSeller: UIButtonBorderRadiusGrey!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.annonceImage?.image = nil
    }
}

import UIKit
import SideMenu

class UtiliseeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBar: UIViewNavBar!
    @IBOutlet weak var AnnoncesTableView: UITableView!
    var annoncesJSON: Array<Annonce>?
    let annonceImagesCache = NSCache<AnyObject, AnyObject>.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.AnnoncesTableView.delegate = self
        self.AnnoncesTableView.dataSource = self
        self.getAllAnnonces()
    }
    
    func initView() {
        navBar.menuButton.setBackgroundImage(UIImage(named: "menu"), for: UIControlState.normal)
        navBar.menuButton.addTarget(self, action: #selector(UtiliseeController.ShowMenu(_:)), for: .touchUpInside)
        navBar.title.text = "Voiture utilisée"
    }
    
    @objc func ShowMenu(_ sender: UIButton) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenu") as! UISideMenuNavigationController
        menu.sideMenuManager!.menuPresentMode = .menuSlideIn
        menu.leftSide = true
        menu.menuWidth = UIScreen.main.bounds.width * 0.8
        menu.sideMenuManager.menuFadeStatusBar = false
        present(menu, animated: true, completion: nil)
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
                var savedData: Data?
                DispatchQueue.global(qos: .background).async {
                    if let data = try? Data(contentsOf: urlString!) {
                        savedData = data
                        let imageToCache = UIImage(data: data)
                        self.annonceImagesCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    }
                    DispatchQueue.main.async {
                        cell.annonceImage.image = UIImage(data: savedData!)
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
    
    
    
    func getAllAnnonces() {
        let defaults = UserDefaults.standard
        let idAutomobiliste = defaults.string(forKey: "IdAutomobiliste")
        AnnonceService.sharedInstance.getAllAnnonces(idAutomobiliste: idAutomobiliste!, onSuccess: { data in
            let decoder = JSONDecoder()
            self.annoncesJSON = try? decoder.decode(Array<Annonce>.self, from: data)
            DispatchQueue.main.async {
                self.AnnoncesTableView.reloadData()
            }
        }, onFailure: { error in
            print(error)
            
        })
    }
    
    @IBAction func OnRechercheAvanceeButtonClick(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let utiliseeAvanceeController = storyBoard.instantiateViewController(withIdentifier: "UtiliseeAvancee") as! UtiliseeAvanceeController
        self.navigationController?.pushViewController(utiliseeAvanceeController, animated: true)

    }
    

}
