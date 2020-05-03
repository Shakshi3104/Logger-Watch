//
//  ContentView.swift
//  Logger Watch WatchKit Extension
//
//  Created by MacBook Pro on 2020/05/03.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var logStarting = false
    @State private var accXLabel = "X"
    @State private var accYLabel = "Y"
    @State private var accZLabel = "Z"
    @State private var gyrXLabel = "X"
    @State private var gyrYLabel = "Y"
    @State private var gyrZLabel = "Z"
    
    @ObservedObject var sensorLogger = SensorLogger()
    
    var body: some View {
        VStack {
            Button(action: {
                self.logStarting.toggle()
                
                if self.logStarting {
                    self.sensorLogger.startUpdate(50.0)
                    self.accXLabel = String(format:  "%.1f", self.sensorLogger.accX)
                    self.accYLabel = String(format: "%.1f", self.sensorLogger.accY)
                    self.accZLabel = String(format: "%.1f", self.sensorLogger.accZ)
                }
                else {
                    
                    self.accXLabel = "X"
                    self.accYLabel = "Y"
                    self.accZLabel = "Z"
                }
            }) {
                if self.logStarting {
                    Image(systemName: "pause.circle")
                }
                else {
                    Image(systemName: "play.circle")
                }
            }
            VStack {
                
                
                
                HStack {
                    Text("Acc").font(.headline)
                    Spacer()
                    Text("\(accXLabel)")
                    Spacer()
                    Text("\(accYLabel)")
                    Spacer()
                    Text("\(accZLabel)")
                }.padding(.horizontal)
                
                HStack {
                    Text("Gyr").font(.headline)
                    Spacer()
                    Text("\(gyrXLabel)")
                    Spacer()
                    Text("\(gyrYLabel)")
                    Spacer()
                    Text("\(gyrZLabel)")
                }.padding(.horizontal)
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
