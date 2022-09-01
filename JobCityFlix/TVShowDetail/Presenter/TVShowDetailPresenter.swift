import Foundation

final class TVShowDetailPresenter: TVShowDetailPresenterProtocol {

    weak var viewController: TVShowDetailViewControllerProtocol?
    
    func willStartFetch() {
        viewController?.showLoadig()
    }

    func show(_ tvShow: TVShowCodable) {
        viewController?.removeLoading()
        viewController?.show(tvShow)
    }

    func showError(_ error: Error) {
        viewController?.showError(error)
    }
    
    func show(_ episodes: [Episode]) {
        let episodes = groupBySeason(episodes)
        let seasons = formatedSeasons(episodes.count)
        viewController?.removeLoading()
        viewController?.show(episodes, seasons)
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
            result.append("\(season)ª Temporada")
        }
        
        return result
    }
}
