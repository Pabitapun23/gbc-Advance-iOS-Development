//
//  ActivityHelper.swift
//  Bored
//
//  Created by J Patel on 2024-03-07.
//

import Foundation

class ActivityHelper : ObservableObject{
    @Published var activity = Activity()
    
    private var baseURL = "https://www.boredapi.com/api/activity"
    
    func fetchActivity(withCompletion completion : @escaping (Activity?) -> Void){
        
        guard let apiURL = URL(string: baseURL) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: apiURL){ (data: Data?, response: URLResponse?, error: Error?) in
            
            if let err = error{
                print(#function, "Error while fetching activity \(err)")
                
            }else{
                if (data != nil){
                    DispatchQueue.global().async {
                        do{
                            
                            if let jsonData = data{
                                let decoder = JSONDecoder()
                                let decodedActivity = try decoder.decode(Activity.self, from: jsonData)
                                
                                DispatchQueue.main.async {
                                    self.activity = decodedActivity
                                    print(#function, decodedActivity.activityName)
                                    completion(decodedActivity)
                                }
                            }
                            
                        }catch let error{
                            print(#function, "Error while decoding data \(error)")
                        }
                    }
                }
            }
            
        }
        
        task.resume()
        
    }
}
