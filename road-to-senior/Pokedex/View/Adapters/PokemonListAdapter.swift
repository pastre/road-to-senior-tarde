import UIKit

protocol PokemonListManaging {
    func configure(using pokemons: [Pokemon])
}

typealias PokemonListAdapting = UITableViewDataSource &
                                UITableViewDelegate &
                                PokemonListManaging

final class PokemonListAdapter: NSObject, PokemonListAdapting {
    
    private var pokemons: [Pokemon] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(PokemonTableViewCell.self, at: indexPath)
        let pokemon = pokemons[indexPath.row]
        cell.configure(using: .init(
            pokemonName: pokemon.name))
        return cell
    }
    
    func configure(using pokemons: [Pokemon]) {
        self.pokemons = pokemons
    }
}
