//
//  ViewController.swift
//  Internet
//
//  Created by UNAM on 26/09/25.
//

import UIKit
import Network

class ViewController: UIViewController {

    var imagen : UIImageView!
    var actI : UIActivityIndicatorView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // crear un objeto UIImage y centrarlo en la vista
        imagen = UIImageView(frame:view.bounds) // bounds se refiere al frame de la vista, considerando la orientación
        imagen.contentMode = .scaleAspectFit
        imagen.image = UIImage(systemName: "apple.logo")
        self.view.addSubview(imagen)
        actI = UIActivityIndicatorView()
        actI.center = view.center
        self.view.addSubview(actI)
        actI.hidesWhenStopped = true
        actI.style = .large
        actI.tintColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
                    // si hay conexión a Internet
        if InternetMonitor.shared.hayConexion{
            if InternetMonitor.shared.tipoConexion == "cell" {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title:"atención!", message:"La conexión a Internet es por datos celulares. Desea continuar?", preferredStyle:.alert)
                    let btnAceptar = UIAlertAction(title:"SI", style:.default) {
                        action in
                        // procedo a descargar los datos
                        self.descargaImagen()
                    }
                    alert.addAction(btnAceptar)
                    let btnCancelar = UIAlertAction(title:"NO", style:.cancel, handler:nil)
                    alert.addAction(btnCancelar)
                    self.present(alert, animated:true, completion:nil)
                }
            }else{
                descargaImagen()
            }
        }else {
                    // no hay conexion, notificar al usuario
                    // si este código se está ejecutando en background, hay que regresar al hilo principal
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title:"atención!", message:"No hay conexión a Internet", preferredStyle:.alert)
                        let btnAceptar = UIAlertAction(title:"ok", style:.default, handler:nil)
                        alert.addAction(btnAceptar)
                        self.present(alert, animated:true, completion:nil)
                    }
                }
            }
        
        func descargaImagen(){
            if let url = URL(string: "https://apod.nasa.gov/apod/image/2406/abell2744_jwst1024.png") {
                actI.startAnimating()
                
                //Esto no se hace
                
                /*do{
                    let datos = try Data(contentsOf: url)
                    imagen.image = UIImage(data: datos)
                }catch{
                    print("No se pudo descargar la imagen")
                }*/
                
                let configuracion = URLSessionConfiguration.ephemeral
                let session = URLSession(configuration: configuracion)
                let request = URLRequest(url: url)
                let tarea = session.dataTask(with: request){ datos, respuesta, error in
                    if datos != nil && error == nil{
                        DispatchQueue.main.async {
                            self.actI.stopAnimating()
                            self.imagen.image = UIImage(data: datos!)
                        }
                        
                    }else{
                        self.imagen.image = UIImage(named: "wifi.exclamationamrk")
                    }
                }
                tarea.resume()
            }
        }
        
    }

