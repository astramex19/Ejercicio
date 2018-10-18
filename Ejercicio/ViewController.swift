//
//  ViewController.swift
//  Ejercicio
//
//  Created by Fabian Romero Sotelo on 10/18/18.
//  Copyright © 2018 Fabian Romero Sotelo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var textfieldBuscar: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var productos = [[String: Any]]()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
                cell.titulo.text =  (newArr.firstObject as! String)
            }else{
                cell.titulo.text = "Sin descripcion"
            }
        }
        
        if let dictionnary : NSDictionary = attributes as NSDictionary? {
            if let newArr : NSArray = dictionnary.object(forKey: "sku.list_Price") as? NSArray {
                cell.precio.text = "Precio $" + (newArr.firstObject as! String)
            }else{
                cell.titulo.text = "Sin precio"
            }
                
        }
        
        if let dictionnary : NSDictionary = attributes as NSDictionary? {
            if let newArr : NSArray = dictionnary.object(forKey: "department") as? NSArray {
                cell.ubicacion.text = "Departamento " + (newArr.firstObject as! String)
            }else{
                cell.titulo.text = "Sin departamento"
            }
                
        }
        
        if let dictionnary : NSDictionary = attributes as NSDictionary? {
            if let newArr : NSArray = dictionnary.object(forKey: "sku.thumbnailImage") as? NSArray {
                let imageView = cell.viewWithTag(1) as! UIImageView                
                imageView.sd_setImage(with: URL(string: (newArr.firstObject as! String)))
                
            }
        }
        return cell
        
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        
        guard let text = textfieldBuscar.text, !text.isEmpty else {
            return false
        }
        productos.removeAll()
        buscar(value: textfieldBuscar.text!)
        
        return false
    }
    
    @IBAction func botonBuscar(_ sender: Any) {
        
        guard let text = textfieldBuscar.text, !text.isEmpty else {
            return
        }
        productos.removeAll()
        buscar(value: textfieldBuscar.text!)
    }
    
    
    func buscar(value:String){
        
        Alamofire.request("https://www.liverpool.com.mx/tienda/?s=\(value)&d3106047a194921c01969dfdec083925=json").responseJSON { (response) in
            
            
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
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    
                }
                
            }
            
            if self.productos.count > 0{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else {
                let alert = UIAlertController(title: nil, message: "No se encontraron productos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
            
            }
            
        }
        
    }
    
}




