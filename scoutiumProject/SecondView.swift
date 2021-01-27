//
//  secondView.swift
//  scoutiumProject
//
//  Created by emre can duygulu on 23.01.2021.
//  Copyright © 2021 emre can duygulu. All rights reserved.
//

import Foundation
import Alamofire
import SDWebImage

class secondView: UIViewController, UITableViewDataSource {

    var datasource: [Item] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List"
        
        fetchData()
        
        tableView.dataSource = self
        self.tableView.rowHeight = 200.0

    }
    
    private func fetchData() {
        AF.request(
            "https://storage.googleapis.com/anvato-sample-dataset-nl-au-s1/life-1/data.json",
            method: .get,
            encoding: URLEncoding.queryString,
            headers: nil
        )
            .validate()
            .responseJSON { response in
                switch (response.result) {
                case .success( _):
                    do {
                        let json = try JSONDecoder().decode(Response.self, from: response.data!)
                        self.datasource = json.items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        for i in json.items {
                            print(i.title)
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ItemCell
        let url = datasource[indexPath.row].url
        let title = datasource[indexPath.row].title
        cell.present(url: url, title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
}
