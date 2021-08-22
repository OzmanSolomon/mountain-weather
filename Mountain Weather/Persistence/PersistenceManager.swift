//
//  PersistenceManager.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 21/08/2021.
//

import Foundation
import RealmSwift
class PersistenceManager {
    
    func presistence(model:[Object])throws {
        do {    
            let realm = try Realm()
            realm.beginWrite()
            for item in model
            {
                realm.add(item)
            }
            try! realm.commitWrite()
        } catch{
            throw error
        }
    }
    
    func unpresistence<T:Object>(model:T.Type)throws -> Results<T>{
        do {
            let realm = try Realm()
            return realm.objects(model.self)
        } catch{
            throw error
        }
    }
  
    func cleanPresistenced<T:Object>(model:T.Type)throws {
      
       do{let realm = try Realm()
       print("Delete Data")
       realm.objects(model.self).forEach({ item in
           try! realm.write {
               realm.delete(item)
           }
       })
       }catch{
           throw error
       }
       
   }

}

