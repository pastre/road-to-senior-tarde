import UIKit
protocol PokemonListPresentationLogic {
    func presentPokemons(_ response: PokemonListSceneModel.FetchPokemons.Response)
}

final class PokemonListPresentater: PokemonListPresentationLogic {
    weak var viewController: PokemonListDisplayLogic?
    
    func presentPokemons(_ response: PokemonListSceneModel.FetchPokemons.Response) {
        viewController?.displayPokemons(.init(pokemons: response.pokemons.map {
            .init(
                name: String($0.name.reversed()),
                color: randomColor())
        }))
    }
    
    private func randomColor() -> UIColor {
        .init(red: .random(in: 0...1),
              green: .random(in: 0...1),
              blue: .random(in: 0...1),
              alpha: 1)
    }
}
