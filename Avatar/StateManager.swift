//
//  StateManager.swift
//  PreverificaAvatar
//
//  Created by popescu petrisor on 14/12/18.
//  Copyright © 2018 popescu petrisor. All rights reserved.
//

import Foundation
class StateManager{
    static var inf = "inf"
     static var jnf = "j"
     static var snf = "s"
    static var tnf = "t"
    static func saveState(i:Int,j:Int,s:Int,t:Int){
        let defaults = UserDefaults.standard
        defaults.set(i, forKey: inf)
        defaults.set(j, forKey: jnf)
        defaults.set(s, forKey: snf)
        defaults.set(t, forKey: tnf)
    }
    static func recuperaDati(key:String)->Any?{
        let defaults = UserDefaults.standard
        return defaults.value(forKey:key)
    }
    static func clearState(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: inf)
        defaults.removeObject(forKey: jnf)
        defaults.removeObject(forKey: snf)
        defaults.removeObject(forKey: tnf)
        
    }
    

}



