import UIKit
// Metatype (.Type, .self, Self) | Generics <T, U, X, Salve>
extension UITableView {
    func register<CellType>(_ cellType: CellType.Type) where CellType: UITableViewCell {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueReusableCell<CellType>(_ cellType: CellType.Type, at indexPath: IndexPath) -> CellType where CellType: UITableViewCell {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellType.reuseIdentifier,
            for: indexPath) as? CellType
        else { fatalError("No cell of type \(String(describing: CellType.self)) registered for tableView \(self)") }
        return cell
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
}
