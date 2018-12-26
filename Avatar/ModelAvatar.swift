//
//  ModelAvatar.swift
//  PreverificaAvatar
//
//  Created by popescu petrisor on 12/12/18.
//  Copyright © 2018 popescu petrisor. All rights reserved.
//

import Foundation
// dichiaro un protocolo
protocol AvatarProtocol {
    func recuperaDati(dati:Avatar)
}
class ModelAvatar{
    // dichiaro una variabile di tipo di protocolo 
    var delegate:AvatarProtocol?
    
    var avatar=Avatar()
    func getDatiLocali()
        {
            //get a path to the json file in our app bundle
            let path=Bundle.main.path(forResource: "DatiLocali", ofType: ".json")
            guard (path != nil)else{
                print("Can't find the json file")
                return
            }
            // create a url object from that string path
            let url=URL(fileURLWithPath: path!)
            do {
                // get the data from that URL
                let data = try Data(contentsOf: url)
                // decode the json data
                let decoder = JSONDecoder()
                let array = try decoder.decode(Avatar.self, from: data)
                //Return the questions structs to the view controler
                delegate?.recuperaDati(dati: array)
            }
            catch{
                print("couldn't create Data object from file")
            }
            
        
    }
    func getDatiEsteno(){
        // get a url object from a string
        let stringUrl="http://www.willyx.it/esercizio/AvatarData.json"
        let url = URL (string: stringUrl)
        guard url != nil else {
            print ("couldn't get a url object")
            return
        }
        // get a url session object
        let session = URLSession.shared
        // get a DataTask object
        let dataTask = session.dataTask(with: url!){
            (data,response,error) in
            if error == nil && data != nil {
                //create a json decoder
                let decoder = JSONDecoder()
                do {
                    // try to parse the data
                    let array = try decoder.decode(Avatar.self, from: data!)
                    //notify the view controler with results by passing the data back to the main thead
                    
                    DispatchQueue.main.async {
                        // when it comes back, call the recuperaDati method of the delegate
                        self.delegate?.recuperaDati(dati: array)
                        
                    }
                    
                }
                catch{
                    print ("couldn't parse the json")
                }
            }
        }
        //call resume on the dataTask object
        dataTask.resume()
        
    }
    func getDati()->Avatar{
        for i in 0...4{
            avatar.occhi.append("occhi\(i)")
        }
        for i in 0...4{
            avatar.bocca.append("bocca\(i)")
        }
        for i in 0...1{
            avatar.corpo.append("corpo\(i)")
        }
       
            avatar.testa.append("testa0")
        
        return avatar
        }
    
    
    
}

