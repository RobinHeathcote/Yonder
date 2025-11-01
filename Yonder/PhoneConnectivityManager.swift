import Foundation
import WatchConnectivity
import CoreLocation

final class PhoneConnectivityManager: NSObject, ObservableObject {
    static let shared = PhoneConnectivityManager()

    private override init() {
        super.init()
        activateSessionIfSupported()
    }

    private var session: WCSession? {
        WCSession.isSupported() ? WCSession.default : nil
    }

    private func activateSessionIfSupported() {
        guard WCSession.isSupported() else { return }
        let session = WCSession.default
        session.delegate = self
        session.activate()
    }

    // Serialize coordinates to an array of dictionaries for WatchConnectivity
    private func serialize(coordinates: [CLLocationCoordinate2D]) -> [[String: Double]] {
        coordinates.map { [
            "lat": $0.latitude,
            "lon": $0.longitude
        ] }
    }

    // Public API to send a route to the watch
    func sendRoute(coordinates: [CLLocationCoordinate2D], reply: ((Result<Void, Error>) -> Void)? = nil) {
        let payload: [String: Any] = [
            "type": "route",
            "points": serialize(coordinates: coordinates)
        ]

        guard let session = session, session.isPaired, session.isWatchAppInstalled else {
            reply?(.failure(NSError(domain: "PhoneConnectivityManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Watch not available or app not installed."])) )
            return
        }

        // Prefer sendMessage if reachable, otherwise queue as userInfo
        if session.isReachable {
            session.sendMessage(payload, replyHandler: { _ in
                reply?(.success(()))
            }, errorHandler: { error in
                reply?(.failure(error))
            })
        } else {
            session.transferUserInfo(payload)
            reply?(.success(()))
        }
    }
}

extension PhoneConnectivityManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation failed: \(error)")
        } else {
            print("WCSession activated: \(activationState.rawValue)")
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }

    // Handle any incoming messages from the watch if needed
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // No-op for now
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        // No-op for now
    }
}
