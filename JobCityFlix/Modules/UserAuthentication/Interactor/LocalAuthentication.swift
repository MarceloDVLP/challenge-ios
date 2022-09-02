import LocalAuthentication

final class LocalAuthentication {
    
    private var context = LAContext()
    
    func tryLocalAuthentication(_ completion: ((Result<Bool, Error>) -> ())?) {
        let reason = "Log in with FaceID"
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
            if success {
                completion?(.success(success))
            } else {
                completion?(.failure(error!))
            }
        }
    }
    
    func isFaceIDEnabled() -> Bool {
        return context.biometryType == .faceID
    }
    
    func isTouchIDEnabled() -> Bool {
        return context.biometryType == .touchID
    }
    
    func isLocalAuthenticationPermitted() -> Bool {
        var error: NSError?
        let result = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        return result
    }
}
