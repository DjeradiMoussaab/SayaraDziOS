//
//  GestionOffresController.swift
//  SayaraDz
//
//  Created by Mac on 8/26/19.
//  Copyright © 2019 mossab. All rights reserved.
//

class OffreCell: UITableViewCell  {
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var contacterButton: UIButton!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var prenom: UILabel!
    @IBOutlet weak var numTel: UILabel!
    @IBOutlet weak var prix: UILabel!
    @IBOutlet weak var accepterButton: UIButtonBorderRadiusPurple!
    
}

import UIKit

class GestionOffresController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var navBar: UIViewNavBar!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var votrePrix: UILabel!
    @IBOutlet weak var OffresTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var indication: UILabel!
    
    var OffresJSON : Array<Offre>?
    var idAnnonce: String?
    var carNameText: String?
    var votrePrixText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.OffresTableView.delegate = self
        self.OffresTableView.dataSource = self
        self.OffresTableView.isHidden = true
        self.indicator.startAnimating()
        self.indication.isHidden = true
        self.initView()
        self.getAllOffre()

    }
    
    func initView() {
        navBar.menuButton.setBackgroundImage(UIImage(named: "back"), for: UIControlState.normal)
        navBar.title.text = "Gérer les offres"
        navBar.menuButton.addTarget(self, action: #selector(GestionOffresController.backButtonClicked(_:)), for: .touchUpInside)
        carName.text = carNameText
        votrePrix.text = votrePrixText
    }
    
    @objc func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( self.OffresJSON != nil ) {
            return OffresJSON!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffreCell", for: indexPath) as! OffreCell
        let currentCell = OffresJSON![indexPath.row]
        cell.fullName.text = "\(currentCell.automobiliste.Nom) \(currentCell.automobiliste.Prenom)"
        cell.nom.text = "Nom : \(currentCell.automobiliste.Nom)"
        cell.prenom.text = "Prénom : \(currentCell.automobiliste.Prenom)"
        cell.numTel.text = "Numéro Tel : \(currentCell.automobiliste.NumTel ?? "pas mentionné")"
        cell.prix.text = "\(currentCell.Montant) DZD"
        
        return cell
    }
    
    
    
    func getAllOffre() {
        OffreService.sharedInstance.getAllOffres(idAnnonce: idAnnonce!, onSuccess: { data in
            let decoder = JSONDecoder()
            self.OffresJSON = try? decoder.decode(Array<Offre>.self, from: data)
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                if (self.OffresJSON?.count != 0) {
                    self.OffresTableView.isHidden = false
                    self.OffresTableView.reloadData()
                } else {
                    self.indication.isHidden = false
                }
            }
        }, onFailure: { error in
            print(error)
            
        })
    }
    


}
