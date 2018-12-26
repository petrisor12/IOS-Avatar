//
//  ViewController.swift
//  PreverificaAvatar
//
//  Created by popescu petrisor on 12/12/18.
//  Copyright © 2018 popescu petrisor. All rights reserved.
//

import UIKit
// aggiungo il suporto al protocolo pass 1
class ViewController: UIViewController,AvatarProtocol {
    
    
    var dati = Avatar()
    var modelAvatar = ModelAvatar()
    var tmp: String = "http://www.willyx.it/esercizio/"
   
    var i = 0
    var t = 0
    var j = 0
    var s = 0

    override func viewDidLoad() {
        super.viewDidLoad()
         recuperaDatiStateManager()
        // aggiungo il suporto al protocolo pass 3
        modelAvatar.delegate = self
        //dati=modelAvatar.getDati()
       // modelAvatar.getDatiEsteno()
        modelAvatar.getDatiLocali()
        
        
        
       //StateManager.clearState()
        
      
        
    }
    @IBOutlet weak var corpo: UIImageView!
     @IBOutlet weak var bocca: UIImageView!
    @IBOutlet weak var occhi: UIImageView!
    @IBOutlet weak var testa: UIImageView!
    
    @IBAction func btnTesta(_ sender: UIButton) {
      
        if i<dati.testa.count-1{
            i=i+1
        }
        else {
            i = 0
        }
        //testa.image=UIImage(named: dati.testa[i])
        let url : URL = URL(string: tmp+"\(dati.testa[i])")!
        testa.load(url: url)
        StateManager.saveState(i: i, j: j, s: s, t: t)
    }
    
    
    
    
    @IBAction func btnOcchi(_ sender: UIButton) {
     //slideOut()
        
        
        
        
        if j<dati.occhi.count-1{
            j=j+1
        }
        else {
            j = 0
            }
       // occhi.image=UIImage(named: dati.occhi[j])
        let url : URL = URL(string: tmp+"\(dati.occhi[j])")!
        occhi.load(url: url)
        StateManager.saveState(i: i, j: j, s: s, t: t)
       slideIn()
        
    }
    
   
    @IBAction func btnBocca(_ sender: UIButton) {
        if s<dati.bocca.count-1{
            s=s+1
        }
        else {
            s = 0
        }
       // bocca.image=UIImage(named: dati.bocca[s])
       
       
        let url : URL = URL(string: tmp+"\(dati.bocca[s])")!
       bocca.load(url: url)
     StateManager.saveState(i: i, j: j, s: s, t: t)
       
    }
    
    @IBOutlet weak var leadingOcchiConstant: NSLayoutConstraint!
    @IBOutlet weak var tralingOcchiConstant: NSLayoutConstraint!
    @IBAction func btnCorpo(_ sender: UIButton) {
        if t<dati.corpo.count-1{
            t=t+1
        }
        else {
            t = 0
        }
       // corpo.image=UIImage(named: dati.corpo[t])
        let url : URL = URL(string: tmp+"\(dati.corpo[t])")!
        corpo.load(url: url)
        StateManager.saveState(i: i, j: j, s: s, t: t)
    }
    @IBAction func Shuffle(_ sender: UIButton) {
       
       
       s = Int.random(in: 0..<dati.bocca.count-1)
      j = Int.random(in: 0..<dati.occhi.count-1)
        t = Int.random(in: 0..<dati.corpo.count-1)
       inizilizaDati()
    }
    
    // aggiungo il suporto al protocolo pass 2
    func recuperaDati(dati: Avatar) {
        print ("I dati sono stati recuperati")
        self.dati = dati
        inizilizaDati()
    }
    func inizilizaDati(){
        corpo.image = UIImage(named: dati.corpo[t])
        bocca.image=UIImage(named: dati.bocca[s])
        testa.image=UIImage(named: dati.testa[i])
        occhi.image=UIImage(named: dati.occhi[j])
    }
    func recuperaDatiStateManager(){
      
    
        let tmp = StateManager.recuperaDati(key: StateManager.inf) as? Int
        if(tmp != nil){
        i=tmp!
        j = StateManager.recuperaDati(key: StateManager.jnf) as! Int
        s = StateManager.recuperaDati(key: StateManager.snf) as! Int
        t = StateManager.recuperaDati(key: StateManager.tnf) as! Int
       
        
        }
        
    }
    func slideIn(){
        //set the starting state
        leadingOcchiConstant.constant = 1000
        tralingOcchiConstant.constant = -1000
        view.layoutIfNeeded()
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.leadingOcchiConstant.constant = 0
            self.tralingOcchiConstant.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    func slideOut(){
        //set the starting state
        leadingOcchiConstant.constant = 0
        tralingOcchiConstant.constant = 0
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn, animations: {
            self.leadingOcchiConstant.constant = -1000
            self.tralingOcchiConstant.constant = 1000
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

