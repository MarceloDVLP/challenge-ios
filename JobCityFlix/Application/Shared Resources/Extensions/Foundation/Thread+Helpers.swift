import Foundation

extension Thread {

    static func executeOnMain(_ block: @escaping (()->())) {
        
        guard !Thread.isMainThread else {
            block()
            return
        }
        
        DispatchQueue.main.async {
            block()
        }
    }
}
