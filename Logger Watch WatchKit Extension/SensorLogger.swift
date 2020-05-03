//
//  SensorLogger.swift
//  Logger Watch WatchKit Extension
//
//  Created by MacBook Pro on 2020/05/03.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation
import CoreMotion
import Combine

class SensorLogger: NSObject, ObservableObject {
    let willChange = PassthroughSubject<Void, Never>()
    
    var motionManager: CMMotionManager?
    
    @Published var accX = 0.0
    @Published var accY = 0.0
    @Published var accZ = 0.0
    
    override init() {
        super.init()
        motionManager = CMMotionManager()
    }
    
    func startUpdate(_ freq: Double) {
        // Accelerometer
        if motionManager!.isAccelerometerAvailable {
            motionManager?.accelerometerUpdateInterval = 1 / freq
            motionManager?.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data, error) in
                let x = data?.acceleration.x
                let y = data?.acceleration.y
                let z = data?.acceleration.z
                
                self.accX = x!
                self.accY = y!
                self.accZ = z!
                self.willChange.send()
            })
        }
        else {
            self.accX = Double.nan
            self.accY = Double.nan
            self.accZ = Double.nan
        }
    }
    
    func stopUpdate() {
        if motionManager!.isAccelerometerActive {
            motionManager?.stopAccelerometerUpdates()
        }
    }
    
}
