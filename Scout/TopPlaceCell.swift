//
//  TopPlaceCell.swift
//  Scout
//
//  Created by Akshay Pimprikar.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TopPlaceCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!

    var topPlace: TopPlace! {
        didSet {
            nameLabel.text = topPlace.name
            self.imageForLocation(topPlace.imageURL!) { cellImage in
                self.locationImageView.image = cellImage
            }
        }
    }
    
    func imageForLocation(imageURL:String, completion: (UIImage) -> Void) -> ()
    {
        Alamofire.request(.GET, imageURL)
            .responseImage { response in
                
                if let image = response.result.value {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(image)
                    }
                }
        }
    }

}
