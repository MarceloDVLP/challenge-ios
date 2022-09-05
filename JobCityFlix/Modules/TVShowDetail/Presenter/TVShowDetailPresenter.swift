import Foundation

final class TVShowDetailPresenter: TVShowDetailPresenterProtocol {

    weak var viewController: TVShowDetailViewControllerProtocol?
    
    func willStartFetch() {
        viewController?.showLoadig()
    }

    func show(_ tvShow: TVShowModel, _ isFavorited: Bool) {
        Thread.executeOnMain { [weak self] in
            self?.viewController?.removeLoading()
            self?.viewController?.show(tvShow, isFavorited)
        }
    }

    func showError(_ error: Error) {
        viewController?.showError(error)
    }
    
    func show(_ episodes: [Episode]) {
        Thread.executeOnMain {  [weak self] in
            guard let self = self else { return }
            let episodes = self.groupBySeason(episodes)
            let seasons = self.formatedSeasons(episodes.count)
            self.viewController?.removeLoading()
            self.viewController?.show(episodes, seasons)
        }
    }
    
    func groupBySeason(_ episodes: [Episode]) -> [[Episode]] {
        var result = [[Episode]]()
        
        let seasons: Set<Int> = Set(episodes.compactMap({ return $0.season ?? 0 }))
        
        for seasonNumber in seasons.sorted(by: { $0 < $1 } ) {
            let seasonEpisodes = episodes.filter({ $0.season == seasonNumber })
            result.append(seasonEpisodes)
        }
        
        return result
    }
    
    func formatedSeasons(_ count: Int) -> [String] {
        var result: [String] = []
        
        guard count > 0 else { return [] }
        
        for season in 1...count {
            result.append("Season \(season)")
        }
        
        return result
    }
}
