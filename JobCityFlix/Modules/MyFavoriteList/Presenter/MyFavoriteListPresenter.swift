import Foundation

protocol MyFavoriteListPresenterDelegate: AnyObject {
    
    func show(_ favorites: [FavoriteEntity])
}

protocol MyFavoriteListPresenterProtocol: AnyObject {
    func show(_ favorites: [FavoriteEntity])
}

final class MyFavoriteListPresenter: MyFavoriteListPresenterProtocol, MyFavoriteListInteractorDelegate {
    
    weak var viewController: MyFavoriteListPresenterDelegate?
    
    func show(_ favorites: [FavoriteEntity]) {
        viewController?.show(favorites)
    }
}

