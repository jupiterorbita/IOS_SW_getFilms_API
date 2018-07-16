//
//  ViewController.swift
//  getFilms2
//
//  Created by J on 7/16/2018.
//  Copyright © 2018 Jman. All rights reserved.
//

import UIKit

class PeopleVC: UITableViewController {

        var people: [NSDictionary] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print("loaded PeopleVC")
            getData(from: "http://swapi.co/api/people/")
        }
        
        func getData(from url:String) {
            
            let url = URL(string: url)
            let session = URLSession.shared
            let task = session.dataTask(with: url!) {
                data, response, error in
                print("in here")
                print(data ?? "no data")
                
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                        let newPeople = jsonResult["results"] as! [NSDictionary]
                        self.people.append(contentsOf: newPeople)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        if let nextUrl = jsonResult["next"] as? String {
                            print(nextUrl)
                            self.getData(from: nextUrl)
                        }
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
        

        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return people.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
            cell.textLabel?.text = people[indexPath.row]["name"] as! String
            return cell
        }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


