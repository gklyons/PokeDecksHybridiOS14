//
//  PokemonSearchViewController.swift
//  PokedexHybridiOS14
//
//  Created by Garrett Lyons on 8/29/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    // MARK: - Properties
    
    var pokemon: DVMPokemon? {
        didSet{
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        
        DVMPokemonController.fetchPokemon(forSearchTerm: searchTerm) { (pokemon) in
            DispatchQueue.main.async {
                
                self.pokemon = pokemon
            }
            
        }
    }
    
    
    
    
    func updateViews() {
        DispatchQueue.main.async {
            if let pokemon = self.pokemon {
                self.nameLabel.text = "Pokemon \(pokemon.name)"
                self.idLabel.text = "\(pokemon.idenifier)"
                self.abilityLabel.text = "\(pokemon.abilities.joined(separator: ", "))"
            } else {
                print("Can't display labels")
            }
        }
    }
}



