//
//  Game.swift
//  PetGame
//
//  Created by user on 12/11/2019.
//  Copyright © 2019 00557052. All rights reserved.
//

import SwiftUI

struct Game: View {
    
     @State private var petname = ""
    @State private var rotateDegree: Double = 0
    @State private var showAlert = false
    @State private var guessNumber = 0
    @State private var answer = Int.random(in: 0...10)
    
    var body: some View {
        
        VStack{
            Button("旋轉吧 ，貓貓") {
                self.rotateDegree += 360
            }
            .font(.title)
            HStack {
               Image("petpet")
                .resizable()
                .scaledToFill()
                .frame(width: 50,
                height: 50)
                .rotationEffect(Angle(degrees: rotateDegree))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            }
            Image("pet2016")
            .resizable()
            .scaledToFill()
            .frame(width: 200,
                   height: 200)
            TextField("寵物的名字", text: $petname, onEditingChanged: { (editing) in
               print("onEditingChanged", editing)
            })
                {
                   print(self.petname)
                }
        .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.orange, lineWidth: 5))
        .padding()
               Text("輸入1-10來測試貓咪🐱對你的愛 ")
            TextField("猜一猜貓咪有多愛你", value: $guessNumber, formatter: NumberFormatter()) {
                       self.showAlert = true
                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                 .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 5))
                .padding()
            HStack{
               Button("貓咪愛吃的食物") {
                self.guessNumber = 10
                self.answer = 10
                }
             .padding()
             .background(Color.purple)
             .foregroundColor(.white)
            .cornerRadius(40)
                Button("貓咪討厭的東西") {
                 self.guessNumber = 0
                 self.answer = 0
                 }
                  .padding()
                  .background(Color.purple)
                  .foregroundColor(.white)
                 .cornerRadius(40)
            }
            Button("重來"){
                self.answer = Int.random(in: 0...10)
           }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
           .cornerRadius(40)
                
            .alert(isPresented: $showAlert) { () -> Alert in
            let result: String
                if self.guessNumber == 10 && self.answer == 10 {
               result = self.petname+"十分愛你😘"
                }else if self.guessNumber == 0 && self.answer == 0{
                    result = self.petname+"很討厭你"
                }
                else if self.answer == self.guessNumber {
                   result = self.petname+"🐱愛你"
                }
                else if self.answer > self.guessNumber {
               result = self.petname+"🐱很愛你的"
            } else {
               result = self.petname+"🐱不是很愛你的"
            }
            return Alert(title: Text(result))
            
            
                }
        }
            
    }
    }


struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
