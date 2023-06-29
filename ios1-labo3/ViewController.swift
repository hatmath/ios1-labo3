//
//  ViewController.swift
//  labo3pokemon
//
//  Created by Simon Turcotte et Mathieu Hatin (Étudiants) on 2023-06-20.
//

import UIKit

let maxPokemons = 100

class ViewController: UIViewController {
    var counter = 0;
    
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var imageViewerBack: UIImageView!
    @IBOutlet weak var textViewer: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.click))
        tapGesture.numberOfTapsRequired = 1
        imageViewer.addGestureRecognizer(tapGesture)
        imageViewer.isUserInteractionEnabled = true
        
    }
    @objc func click() {
        PokemonDownloader.shared.downloadPokemonData(for: Int.random(in: 1...maxPokemons)) { pokemon in
            guard let pokemon = pokemon else {
                print("Error: Invalid data")
                return
            }
            //print(pokemon.imageURL)
            ImageDownloader.shared.downloadImage(URL(string: pokemon.imageURL)!) { image in
                DispatchQueue.main.async {
                    self.imageViewer.image = image
                    //self.imageViewerBack.image = image
                    self.textViewer.text = """
                        ID: \(pokemon.id)
                        Nom: \(pokemon.name)
                        Poids: \(pokemon.weight) dm
                        Taille: \(pokemon.height) hg
                        """
                }
            }
            
            ImageDownloader.shared.downloadImage(URL(string: pokemon.imageURLBack)!) { image in
                DispatchQueue.main.async {
                    self.imageViewerBack.image = image
                }
            }
        }
    }
}



