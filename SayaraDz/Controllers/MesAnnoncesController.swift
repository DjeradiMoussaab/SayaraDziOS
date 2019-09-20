//
//  MesAnnoncesController.swift
//  SayaraDz
//
//  Created by Mac on 8/25/19.
//  Copyright © 2019 mossab. All rights reserved.

class MesAnnonceCell: UITableViewCell  {
    @IBOutlet weak var annonceImage: UIImageView!
    @IBOutlet weak var annonceModifier: UIButton!
    @IBOutlet weak var annonceTitle: UILabel!
    @IBOutlet weak var annoncePrice: UILabel!
    @IBOutlet weak var Apercu: UIButtonBorderRadiusPurple!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.annonceImage?.image = nil
    }
}

import UIKit
import SideMenu

class MesAnnoncesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var navBar: UIViewNavBar!
    @IBOutlet weak var MesAnnoncesTableView: UITableView!
    var MesAnnoncesJSON: Array<Annonce3n>?
    let MesAnnonceImagesCache = NSCache<AnyObject, AnyObject>.init()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var indication: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.MesAnnoncesTableView.delegate = self
        self.MesAnnoncesTableView.dataSource = self
        self.MesAnnoncesTableView.isHidden = true
        self.indicator.startAnimating()
        self.indication.isHidden = true
        self.getMesAnnonces()

    }
    
    func initView() {
        navBar.menuButton.setBackgroundImage(UIImage(named: "menu"), for: UIControlState.normal)
        navBar.menuButton.addTarget(self, action: #selector(MesAnnoncesController.ShowMenu(_:)), for: .touchUpInside)
        navBar.title.text = "Mes annonces"
    }
    
    @objc func ShowMenu(_ sender: UIButton) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenu") as! UISideMenuNavigationController
        menu.sideMenuManager!.menuPresentMode = .menuSlideIn
        menu.leftSide = true
        menu.menuWidth = UIScreen.main.bounds.width * 0.8
        menu.sideMenuManager.menuFadeStatusBar = false
        present(menu, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( self.MesAnnoncesJSON != nil ) {
            return MesAnnoncesJSON!.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MesAnnonceCell", for: indexPath) as! MesAnnonceCell
        let currentAnnonce = MesAnnoncesJSON?[indexPath.row]
        if (currentAnnonce!.images.count != 0 ) {
            let urlString = URL(string: (currentAnnonce!.images[0].CheminImage))
            if let imageFromCache = MesAnnonceImagesCache.object(forKey: urlString as AnyObject) as? UIImage {
                cell.annonceImage.image = imageFromCache
            } else {
                DispatchQueue.global(qos: .background).async {
                    if let data = try? Data(contentsOf: urlString!) {
                        let imageToCache = UIImage(data: data)
                        self.MesAnnonceImagesCache.setObject(imageToCache!, forKey: urlString as AnyObject)
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
        cell.Apercu.tag = indexPath.row
        cell.Apercu.addTarget(self, action: #selector(MesAnnoncesController.VoirOffre(_:)), for: .touchUpInside)
        return cell
    }

    @objc func VoirOffre(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gestionOffresController = storyBoard.instantiateViewController(withIdentifier: "GestionOffres") as! GestionOffresController
        gestionOffresController.idAnnonce = "\(self.MesAnnoncesJSON?[sender.tag].idAnnonce ?? 0)"
        gestionOffresController.carNameText = "\(self.MesAnnoncesJSON?[sender.tag].version.NomMarque ?? "") \(self.MesAnnoncesJSON?[sender.tag].version.NomModele ?? "") \(self.MesAnnoncesJSON?[sender.tag].version.NomVersion ?? "")"
        gestionOffresController.votrePrixText = "\(self.MesAnnoncesJSON?[sender.tag].Prix ?? "") DZD"
        self.navigationController?.pushViewController(gestionOffresController, animated: true)

    }

    func getMesAnnonces() {
        let defaults = UserDefaults.standard
        var idAutomobiliste = defaults.string(forKey: "IdAutomobiliste")
       // idAutomobiliste = "380466752766558"
        AnnonceService.sharedInstance.getMesAnnonces(idAutomobiliste: idAutomobiliste!, onSuccess: { data in
            let decoder = JSONDecoder()
            self.MesAnnoncesJSON = try? decoder.decode(Array<Annonce3n>.self, from: data)
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                if (self.MesAnnoncesJSON?.count != 0) {
                    self.MesAnnoncesTableView.isHidden = false
                    self.MesAnnoncesTableView.reloadData()
                } else {
                    self.indication.isHidden = false
                }
            }
        }, onFailure: { error in
            print(error)
            
        })
    }
    
    @IBAction func AddAnnonce(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ajouterAnnonceController = storyBoard.instantiateViewController(withIdentifier: "AjouterAnnonce") as! AjouterAnnonceController
        self.navigationController?.pushViewController(ajouterAnnonceController, animated: true)
    }
    
}
