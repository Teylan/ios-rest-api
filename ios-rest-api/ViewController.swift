//
//  ViewController.swift
//  ios-rest-api
//
//  Created by Brian Bansenauer on 9/25/19.
//  Copyright © 2019 Cascadia College. All rights reserved.
//

import UIKit

    let DomainURL = "https://www.orangevalleycaa.org/api/"

  
    
class Music : Codable{
        
    var id : String?
    var music_url : String?
    var name : String?
    var description : String?
    
    static func fetch(withId id: Int, completionHandler: @escaping (Music)->Void){
            let URLstring = DomainURL + "music/\(id)"
            if let url = URL.init(string: URLstring){
                let task = URLSession.shared.dataTask(with: url, completionHandler:{(data, response, error) in
                    print(String.init(data: data!, encoding: .ascii) ?? "no data")
                    if let newUser = try? JSONDecoder().decode(Music.self, from: data!){
                        print(newUser.music_url ?? "null")
                        completionHandler(newUser)
                        }
                    })
                task.resume()
            }
        }
    }

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Music.fetch(withId: 1) { (newUser) in
            print(newUser.name ?? "no name")
            if let userData = try? JSONEncoder().encode(newUser){
                print(userData)
            }
        }
    }


}

