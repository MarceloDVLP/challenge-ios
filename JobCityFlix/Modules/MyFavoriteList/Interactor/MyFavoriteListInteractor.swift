import Foundation

protocol MyFavoriteListInteractorDelegate: AnyObject {
    func show(_ favorites: [FavoriteEntity])
}

protocol MyFavoriteListInteractorProtocol {
    func viewWillAppear()
}

final class MyFavoriteListInteractor: MyFavoriteListInteractorProtocol {
    
    var delegate: MyFavoriteListInteractorDelegate?
    
    var manager: FavoriteManager

    init(manager: FavoriteManager) {
        self.manager = manager
    }
    
    func viewWillAppear() {
        let items = manager.fetch()
        delegate?.show(items)
    }
}
