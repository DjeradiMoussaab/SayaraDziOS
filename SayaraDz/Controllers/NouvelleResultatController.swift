//
//  NouvelleResultatController.swift
//  SayaraDz
//
//  Created by Mac on 6/9/19.
//  Copyright © 2019 mossab. All rights reserved.
//

class ColorCell: UICollectionViewCell  {
    @IBOutlet weak var circleView: UIViewCircle!
}

class OptionCell: UITableViewCell {
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!
    
}

import UIKit

class NouvelleResultatController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var navBar: UIViewNavBar!
    
    @IBOutlet weak var modeleImage: UIImageView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var versionName: UILabel!
    @IBOutlet weak var versionPrice: UILabel!
    var versionJSON : Version?
    var ligneTarifJSON : LigneTarif?
    var modeleImageChemin : String?
    let modeleImageCache = NSCache<AnyObject, AnyObject>.init()
    var lastIndexPath : IndexPath?
    var marqueCode : Int?
    var codeCouleur : Int?


    @IBOutlet weak var optionView: UIViewGreyBorderRadius!
    @IBOutlet weak var optionTableView: UITableViewGreyBorderRadius!
    @IBOutlet weak var optionViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        self.colorsCollectionView.delegate = self
        self.colorsCollectionView.dataSource = self
        self.optionTableView.delegate = self
        self.optionTableView.dataSource = self
        self.colorsCollectionView.frame.size.width = 50*3
        setCarImage()

    }
    
    func initView() {
        self.versionName.text = "\(versionJSON?.modele.NomModele ?? "") \(versionJSON?.NomVersion ?? "")"
        self.versionPrice.text = "\(numberFromatterToCurrency(price: (versionJSON?.lignetarif.Prix)!))"
        navBar.menuButton.setBackgroundImage(UIImage(named: "back"), for: UIControlState.normal)
        navBar.title.text = "Nouvelle voiture"
        navBar.menuButton.addTarget(self, action: #selector(CommandeController.backButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func OnCommandeButtonClick(_ sender: Any) {
        let defaults = UserDefaults.standard
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let commandeController = storyBoard.instantiateViewController(withIdentifier: "Commande") as! CommandeController
        commandeController.pageInfos.clientName = defaults.string(forKey: "Nom")!
        commandeController.pageInfos.clientEmail = defaults.string(forKey: "Email")!
        commandeController.pageInfos.clientPhone = "07 77 77 77 77"
        commandeController.pageInfos.versionName = self.versionName.text!
        commandeController.pageInfos.versionCode = "\(self.versionJSON?.CodeVersion ?? 0)"
        commandeController.pageInfos.marqueCode = "\(self.marqueCode ?? 0)"
        commandeController.pageInfos.codeCouleur = "\(self.codeCouleur ?? 0)"
        commandeController.pageInfos.versionDescription = versionJSON!.modele.NomModele
        if self.modeleImage.image != nil {
            commandeController.pageInfos.versionImage = self.modeleImage.image!
        } else {
            commandeController.pageInfos.versionImageChemin = self.modeleImageChemin!
        }
        commandeController.pageInfos.versionPrice = versionPrice.text!
        self.navigationController?.pushViewController(commandeController, animated: true)
    }
    
    func setCarImage() {
        let urlString = URL(string: modeleImageChemin!)
        print(urlString!)
        if let imageFromCache = modeleImageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.modeleImage.image = imageFromCache
        } else {
            var savedData: Data?
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: urlString!) {
                    savedData = data
                }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: savedData!)
                    self.modeleImageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.modeleImage.image = UIImage(data: savedData!)
                }
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 50 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 0 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return versionJSON!.couleurs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
        cell.circleView.backgroundColor = UIColor(hexString:      versionJSON!.couleurs[indexPath.row].CodeHexa
            
)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        for c in self.colorsCollectionView.visibleCells {
            let newcell = c as! ColorCell
            newcell.circleView.changeToUnselected()
        }
        let cell = self.colorsCollectionView.cellForItem(at: indexPath) as! ColorCell
        cell.circleView.changeToSelected()
        self.codeCouleur = versionJSON!.couleurs[indexPath.row].CodeCouleur
        self.colorsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.versionJSON?.options.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionCell
        cell.optionName.text = self.versionJSON?.options[indexPath.row].NomOption
        cell.optionSwitch.isOn = true
        cell.optionSwitch.isHidden = true
        cell.optionSwitch.onTintColor = UIColor(red:1, green:0, blue:0.5, alpha:1.0)
        return cell
        
    }

    @IBAction func OnClickOptionViewButton(_ sender: Any) {
        if (self.optionView.frame.size.height <= 100) {
            self.optionViewButton.setImage(UIImage(named: "arrow_up.png"), for: UIControlState.normal)
            optionView.Open()
            optionTableView.Open()
        } else {
            self.optionViewButton.setImage(UIImage(named: "arrow_down.png"), for: UIControlState.normal)
            optionView.Close()
            optionTableView.Close()
        }
    }
    
}
