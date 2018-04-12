//
//  GetAPIData.swift
//  CarRepairFinder
//
//  Created by Luana on 05/03/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit
import Alamofire

class GetAPIData {
    

    func fetchChannels(completionHandler: @escaping ([Channel]) -> ()) {
        
        var channelsArray = [Channel]()

        let url = URL(string: "http://api.tvmaze.com/shows")
        
        Alamofire.request(url!).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                channelsArray = self.updateResult(response.data)

            } else {
                print("Error with request: \(String(describing: response.result.error))")
                let alerta = UIAlertController(title: "Alerta", message: "Erro ao receber dados, por favor reporte o problema. :(", preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alerta.addAction(actionOk)
                UIApplication.shared.keyWindow?.rootViewController?.present(alerta, animated: true, completion: nil)
            }
            completionHandler(channelsArray)
        }
    }
    
    func updateResult(_ data: Data?) -> [Channel]{
        var channelsArray = [Channel]()

        do {
            let decoder = JSONDecoder()
            if let data = data {
                channelsArray = try decoder.decode([Channel].self, from: data)
            } else { print("no data retrieved") }
        } catch {
            print("Error while parsing json: \(error)")
        }
        
        return channelsArray
    }
    
    //    func getShopImage(photoReference: Photo, completionHandler: (UIImage) -> ()) {
    //        let image = UIImage()
    //        let imageURL = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(String(describing: photoReference))&key=\(AppDelegate.GOOGLE_PLACES_KEY)")
    //
    //        Alamofire.request(imageURL!).responseData { (response) in
    //
    //            guard UIImage(data: response.data!) != nil else {return}
    //        }
    //        completionHandler(image)
    //    }

}
