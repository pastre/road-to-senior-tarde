import UIKit

enum PokemonListSceneModel {
    enum FetchPokemons {
        struct Request {}
        struct Response {
            let pokemons: [Pokemon]
        }
        struct ViewModel {
            struct Pokemon {
                let name: String
                let color: UIColor
            }
            let pokemons: [Pokemon]
        }
    }
}
