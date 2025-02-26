//
//  ReusableView.swift
//  Me-cognize
//
//  Created by Hailey on 2023/07/09.
//

import Foundation
import UIKit

protocol ReusableView {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension ReusableView where Self: UIViewController {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

//MARK: - NibLoadableView
protocol NibLoadableView {}

extension NibLoadableView where Self: UIView {
    static var NibName: String {
        return String(describing: self)
    }
}
//MARK: - UITableView
extension UITableView {
    // tableView.register(HistoryCell.self)
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib = UINib(nibName: T.NibName, bundle: Bundle.main)
        register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func scrollToBottom(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections - 1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections - 1))
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
}


//MARK: - UICollectionView
extension UICollectionView {
    // collectionView.register(FoodTableViewCell)
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib = UINib(nibName: T.NibName, bundle: Bundle.main)
        register(Nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}


extension UIViewController: ReusableView { }

extension UITableViewCell: ReusableView { }

class MeTableViewCell: UITableViewCell, NibLoadableView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.selectionStyle = .none
    }
}
class MeCollectionViewCell: UICollectionViewCell, NibLoadableView { }
