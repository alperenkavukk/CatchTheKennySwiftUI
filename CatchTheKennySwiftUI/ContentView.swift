//
//  ContentView.swift
//  CatchTheKennySwiftUI
//
//  Created by Alperen Kavuk on 11.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var score = 0
    @State var timeLeft = 10.0
    @State var chosenX = 185
    @State var chosenY = 280
    @State var showAlert = false
    
    let (x1,y1) = (185, 280)
    let (x2,y2) = (60, 280)
    let (x3,y3) = (310, 280)
    let (x4,y4) = (310, 140)
    let (x5,y5) = (60, 140)
    let (x6,y6) = (185, 140)
    let (x7,y7) = (185, 400)
    let (x8,y8) = (60, 400)
    let (x9,y9) = (310, 400)

    
    var counterTimer : Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            if self.timeLeft < 0.5 {
                self.showAlert = true
            }
            else{
                
                self.timeLeft -= 1

            }
        }
    }

    
    
    
    var timer : Timer
    {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
           
            let tupleArray = [(self.x1,self.y1),(self.x2,self.y2),(self.x3,self.y3),(self.x4,self.y4),(self.x5,self.y5),(self.x6,self.y6),(self.x7,self.y7),(self.x8,self.y8),(self.x9,self.y9)]
            
            var previousNumber : Int?
            
            func randomNumbweGenerattor() -> Int {
                var randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count - 1)))
                
                while previousNumber == randomNumber {
                    
                    randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count - 1)))
                }
                return randomNumber
            }
            
            self.chosenX = tupleArray[randomNumbweGenerattor()].0
            self.chosenY = tupleArray[randomNumbweGenerattor()].1

        }
    }
    
    
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: UIScreen.main.bounds.height * 0.1)
            Text("Catch The Kenny")
                .font(.largeTitle)
                .foregroundColor(.cyan)
            
            HStack{
                Text("Time Left: ")
                    .font(.title)
                Text(String(self.timeLeft))
                    .font(.title)
            }
            
            
            HStack{
                
                Text("Score : ")
                    .font(.title)
                Text(String(self.score))
                    .font(.title)
                
            }
            
            Spacer()
            
            Image("Kenny")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.4 )
                .position(x:CGFloat(self.chosenX), y: CGFloat(self.chosenY))
                .gesture(TapGesture(count: 1).onEnded({ Void in
                    self.score += 1
                }))
                .onAppear(perform: {
                    self.timer
                    self.counterTimer
                })
            
            Spacer()
        }.alert(isPresented: $showAlert, content: {
           
            return Alert(title: Text("Time Over"), message: Text("Want to Play Again?"), primaryButton: Alert.Button.default(Text("Ok"), action: {
                
                self.score = 0
                self.timeLeft = 10
            }), secondaryButton: Alert.Button.cancel())
        })
        
        
        .padding()
    }
}

#Preview {
    ContentView()
}
