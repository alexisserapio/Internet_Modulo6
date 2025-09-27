//
//  InternetMonitor.swift
//  Internet
//
//  Created by UNAM on 26/09/25.
//
import Foundation
import Network

class InternetMonitor: NSObject{
    static let shared = InternetMonitor()
    private let monitor = NWPathMonitor()
    
    var hayConexion = false
    var tipoConexion = "no"
    
    private override init(){
        super.init()
        monitor.pathUpdateHandler = { ruta in
            if ruta.status == .satisfied {
                //si hay conexion
                self.hayConexion = true
                self.tipoConexion = ruta.usesInterfaceType(.cellular) ? "cell" : "wifi"
            }
        }
        
        monitor.start(queue: DispatchQueue.global(qos: .background))
        
    }
}
