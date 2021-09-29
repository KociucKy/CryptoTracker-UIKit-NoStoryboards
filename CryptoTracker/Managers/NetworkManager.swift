import Foundation

class NetworkManager{
    static let shared       = NetworkManager()
    private let cryptoURL   = "https://api.nomics.com/v1/currencies/ticker?key="
    
    private init(){}
    
    func valueForAPIKey(named keyname:String) -> String {
        let filePath = Bundle.main.path(forResource: "ApiKey", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyname) as! String
        return value
    }
    
    
    func getCurrencies(completed: @escaping (Result<[Crypto], CVError>) -> Void){
        let apiKey = valueForAPIKey(named: "API_CLIENT_ID")
        let endpoint = cryptoURL + "\(apiKey)&per-page=100&page=1&status=active&sort=rank"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let cryptos = try decoder.decode([Crypto].self, from: data)
                completed(.success(cryptos))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

