//
//  Main.swift
//  PetGame
//
//  Created by user on 12/11/2019.
//  Copyright © 2019 00557052. All rights reserved.
//

import SwiftUI

struct Main: View {
    
    @State private var brightnessAmount: Double = 0
    @State private var selectDate = Date()
    @State private var showSecondPage = false
    let today = Date()
    let startDate = Calendar.current.date(byAdding: .year, value: -5, to: Date())!
    var year: Int {
        Calendar.current.component(.year, from: selectDate)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                PetImage(width: geometry.size.width, selectDate: self.selectDate, brightnessAmount: self.brightnessAmount)

                Form {
                    LightSlider(brightnessAmount: self.$brightnessAmount)
                    
                    DatePicker("時間", selection: self.$selectDate, in: self.startDate...self.today, displayedComponents: .date)
                    Button("Game") {
                    self.showSecondPage = true
                    }
                    .sheet(isPresented: self.$showSecondPage) {
                    Game()
                    }
                }
                
                
            }
 
            
            
        }
        
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

struct LightSlider: View {
    
    @Binding var brightnessAmount: Double
    
    var body: some View {
        HStack {
            Text("亮度")
            Slider(value: self.$brightnessAmount, in: 0...1, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small), maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)) {
                Text("")
            }
        }
    }
}

struct PetImage: View {
    
    let width: CGFloat
    let selectDate: Date
    let brightnessAmount: Double
    var year: Int {
        return Calendar.current.component(.year, from: selectDate)
    }
    
    var body: some View {
        Image("pet\(self.year)")
            .resizable()
            .scaledToFill()
            .frame(width: width, height: width / 4 * 3)
            .clipped()
            .brightness(self.brightnessAmount)
    }
}
