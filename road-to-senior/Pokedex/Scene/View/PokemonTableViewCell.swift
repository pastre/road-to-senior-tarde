import UIKit
// Wrapper | Adapter
final class PokemonTableViewCell: CodedTableViewCell {
    // MARK: - UI Components
    
    private let pokemonView = PokemonView()
    
    // MARK: - View lifecycle
    
    override func addSubviews() {
        contentView.addSubview(pokemonView)
    }
    
    override func constraintSubviews() {
        pokemonView.layout {
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 10)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        }
    }
    
    func configure(using model: PokemonView.Model) {
        pokemonView.configure(using: model)
    }
}


final class PokemonView: CodedView {
    // MARK: - Inner types
    
    struct Model {
        let pokemonName: String
        let textColor: UIColor
    }
    
    // MARK: - UI Components
    
    private lazy var pokemonNameLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    // MARK: - View lifecycle
    
    override func addSubviews() {
        addSubview(pokemonNameLabel)
    }
    
    override func constraintSubviews() {
        pokemonNameLabel.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
    }
    
    func configure(using model: Model) {
        pokemonNameLabel.text = model.pokemonName
        pokemonNameLabel.textColor = model.textColor
    }
}
