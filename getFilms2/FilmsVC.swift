//
//  FilmsVC.swift
//  getFilms2
//
//  Created by J on 7/16/2018.
//  Copyright © 2018 Jman. All rights reserved.
//

import UIKit

class FilmsVC: UITableViewController {

    var films: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("========== IN FILMS VC ===========")
        getFilms(from: "https://swapi.co/api/films/")
    }
    
    func getFilms(from url:String) {
    
        let url = URL(string: url)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {
            data, response, error in
            print("in FILMS CALLBACK =======")
            print(data ?? "no data")
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                    if let newFilms = jsonResult["results"] as? [NSDictionary] {
                        print(newFilms)
                        print("--------- films ----------")
                        for film in newFilms {
                            if let movie = film["title"] as? String {
                                print(movie)
                                self.films.append(movie)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
        
//                    if let nextUrl = jsonResult["next"] as? String {
//                        print(nextUrl)
////                        self.getFilms(from: nextUrl)
//                    }
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    
    }
    
    // table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath)
        cell.textLabel?.text = films[indexPath.row] as! String
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
