import Foundation
import UIKit

// 實機
// let common_url = "http://192.168.0.101:8080/EcoParty/"
// 模擬器
let common_url = "http://127.0.0.1:8080/EcoParty/"

func executeTask(_ url_server: URL, _ requestParam: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    // requestParam值為Any就必須使用JSONSerialization.data()，而非JSONEncoder.encode()
    let jsonData = try! JSONSerialization.data(withJSONObject: requestParam)
    var request = URLRequest(url: url_server)
    request.httpMethod = "POST"
    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
    request.httpBody = jsonData
    let sessionData = URLSession.shared
    let task = sessionData.dataTask(with: request, completionHandler: completionHandler)
    task.resume()
}

func showSimpleAlert(message: String, viewController: UIViewController) {
    let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(cancel)
    /* 呼叫present()才會跳出Alert Controller */
    viewController.present(alertController, animated: true, completion:nil)
}

func saveUser(_ user: UserLogin) {
    if let jsonData = try? PropertyListEncoder().encode(user) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(jsonData, forKey: "user")
    }
}

func clearUser() {
    let userDefaults = UserDefaults.standard
    userDefaults.set(0, forKey: "user")
}

func loadUser() -> UserLogin? {
    let userDefaults = UserDefaults.standard
    if let jsonData = userDefaults.data(forKey: "user") {
        if let user = try? PropertyListDecoder().decode(UserLogin.self, from: jsonData) {
            print("nba \(user)")
            return user
        }
    }
    return nil
}

func saveDemoUser(id: Int ) {
    UserDefaults.standard.set(id, forKey: "user")
}

func readDemoUser() -> Int? {
    if let id = UserDefaults.standard.object(forKey: "user") as? Int {
        return id

    } else {
        return 0
    }
    
}

