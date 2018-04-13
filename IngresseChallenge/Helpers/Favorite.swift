//
//  Favorite.swift
//  IngresseChallenge
//
//  Created by Luana on 13/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import Foundation

class Favorite {

    let key = "favorite"
    var item = [Int]()

    func saveFavorite(id: Int){
        self.item = recoverFavorite()
        self.item.append(id)
        UserDefaults.standard.set(self.item, forKey: self.key)
    }

    func removeFavorite(index: Int) {
        self.item = recoverFavorite()
        self.item.remove(at: index)
        UserDefaults.standard.set(self.item, forKey: self.key)
    }

    func recoverFavorite() -> Array<Int> {
        let data = UserDefaults.standard.object(forKey: self.key)
        if data != nil {
            return data as! Array<Int>
        } else {
            return []
        }
    }
}
