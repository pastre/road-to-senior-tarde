import UIKit

protocol PokemonListViewProtocol {
    func reloadData()
}

final class PokemonListView: CodedView {
    // MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(PokemonTableViewCell.self)
        return view
    }()
    
    // MARK: - Initialization
    
    init(dataSource: UITableViewDataSource, delegate: UITableViewDelegate){
        super.init(frame: .zero)
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func addSubviews() {
        addSubview(tableView)
    }
    
    override func constraintSubviews() {
        tableView.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
    }
}

extension PokemonListView: PokemonListViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}
