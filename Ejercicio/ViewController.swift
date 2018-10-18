//
//  ViewController.swift
//  Ejercicio
//
//  Created by Fabian Romero Sotelo on 10/18/18.
//  Copyright © 2018 Fabian Romero Sotelo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var productos = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("https://www.liverpool.com.mx/tienda/?s=zoo&d3106047a194921c01969dfdec083925=json").responseJSON { (response) in
           
            
            if let json = response.result.value as! [String: Any]? {
                
                if let json2 = json["contents"] as! [[String: Any]]? {
                    
                    for val in json2 {
                        
                        if let json3 = val["mainContent"] as! [[String: Any]]? {
                            
                            for val2 in json3 {
                                
                                if let json4 = val2["contents"] as! [[String: Any]]? {
                                
                                    for val3 in json4 {
                                        
                                        if let json5 = val3["records"] as! [[String: Any]]? {
                                          
                                            for val4 in json5 {
                                                if let json6 = val4["records"] as! [[String: Any]]? {
                                                    
                                                    self.productos = json6
                                                }
                                                DispatchQueue.main.async {
                                                    self.tableView.reloadData()
                                                }
                                            }
                                        }
                                    }
                                }

                            }
                        }
                    }

                }
                
            }
            
        }
    }
    
    // MARK: - delegados de la tabla
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dato = productos[indexPath.row]
        let attributes = dato["attributes"]
        print(attributes)
        return cell
        
    }

}

