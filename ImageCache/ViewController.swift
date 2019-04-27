//
//  ViewController.swift
//  ImageCache
//
//  Created by Monica on 12/04/19.
//  Copyright © 2019 Monica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageStr = ["https://commondatastorage.googleapis.com/images.sb.a-cti.com/full_spectrum/a9e941df-d920-4992-bf6e-060d0bcebe57/transferredFiles/AEnB2Uqn4e_d_jXdB5o4_4v0M3ArJlqNZo-xyVHwDkjBWazEyDCdLmm4acvlOBpn3T2wBerPHJogREg17opgdE9SFB1Wv1BJjQ.dYauiOk4F4usMZP1", "https://lh3.googleusercontent.com/HZzyQRh58hxw2IoA8ihq0pTauCqL-L6J_R8rGFZ5XXbnTm1zOf8OQwB1Tk1sfJwRb5Lm96lvVGn3BQzB1cG09DQW5w96g5s"]
        
        ImageProcessor.shared.downloadImage(url: URL(string: imageStr[1])!, completion: { (image, err) in
            DispatchQueue.main.async {
                 self.imageView.image = image
            }
        })
    }


}

