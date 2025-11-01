import Foundation
import WatchConnectivity
import CoreLocation
import Combine

final class WatchConnectivityManager: NSObject, ObservableObject {
    static let shared = WatchConnectivityManager()

    @Published var incomingRoute: [CLLocationCoordinate2D] = []

    private override init() {
        super.init()
        activateSessionIfSupported()
    }

    private func activateSessionIfSupported() {
        guard WCSession.isSupported() else { return }
        let session = WCSession.default
        session.delegate = self
        session.activate()
    }

    private func deserialize(points: [[String: Double]]) -> [CLLocationCoordinate2D] {
        points.compactMap { dict in
            if let lat = dict["lat"], let lon = dict["lon"] {
                return CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
            return nil
        }
    }

    private func handlePayload(_ payload: [String: Any]) {
        guard let type = payload["type"] as? String, type == "route" else { return }
        guard let points = payload["points"] as? [[String: Double]] else { return }
        let coords = deserialize(points: points)
        DispatchQueue.main.async {
            self.incomingRoute = coords
        }
    }
}

extension WatchConnectivityManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Watch WCSession activation failed: \(error)")
        } else {
            print("Watch WCSession activated: \(activationState.rawValue)")
        }
    }

    func sessionReachabilityDidChange(_ session: WCSession) {}

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {

        handlePayload(message)
        replyHandler(["response": "ok"])
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        handlePayload(userInfo)
    }
}
