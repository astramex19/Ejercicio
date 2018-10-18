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
                                                    
                                                    self.productos.append(json6[0])
                                                   
                                                    
                                                   
                                                }
                                                
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
    
    // MARK: - delegados de la tabla
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(productos.count)
       return productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableViewCell
        let dato = productos[indexPath.row]
        let attributes = dato["attributes"] as? [String:Any]

        if let dictionnary : NSDictionary = attributes as NSDictionary? {
            if let newArr : NSArray = dictionnary.object(forKey: "product.description") as? NSArray {
                cell.titulo.text = (newArr.firstObject as! String)
            }
        }
        
        if let dictionnary : NSDictionary = attributes as NSDictionary? {
            if let newArr : NSArray = dictionnary.object(forKey: "sku.list_Price") as? NSArray {
                cell.precio.text = (newArr.firstObject as! String)
            }
        }
        
        if let dictionnary : NSDictionary = attributes as NSDictionary? {
            if let newArr : NSArray = dictionnary.object(forKey: "department") as? NSArray {
                cell.ubicacion.text = (newArr.firstObject as! String)
            }
        }
        
        if let dictionnary : NSDictionary = attributes as NSDictionary? {
            if let newArr : NSArray = dictionnary.object(forKey: "sku.thumbnailImage") as? NSArray {
                cell.imagen.downloaded(from: (newArr.firstObject as! String))
            }
        }
        
        
        
       
        return cell
        
    }

}



extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
