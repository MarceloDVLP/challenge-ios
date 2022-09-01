import Foundation

extension Thread {

    static func executeOnMain(_ block: @escaping (()->())) {
        
        guard !Thread.isMainThread else {
            return
        }
        
        DispatchQueue.main.async {
            block()
        }
    }
}
