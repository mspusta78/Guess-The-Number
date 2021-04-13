//
//  GameView.swift
//  Guess The Number
//
//  Created by Martin Spusta on 3/13/21.
//

import SwiftUI
import Network

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var level : Int
    @State var maxNumber : Int = 0
    @State var userEntered : String = ""
    @State var randomNumber : Int = 0
    @State var feedback : String = ""
    @State var numberOfTries : Int = 3
    @State var score : Int = 0
    @State var userEnteredHistory : String = ""
    
    @State var showingAlert = false
    @State var showingYouWonOverlay = false
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 0){
                
                
                HStack{
                    Button(action: {
                        // quit game
                        endGame()
                    }){
                    Text("End Game")
                        .foregroundColor(.red)
                    }
                    
                    Spacer()
                    Text("Score: \(score)")
                }
                .padding(.top, 50)
                .padding(.bottom, 20)
                .padding(.horizontal)
                .background(Color(.systemGray3))
                
                Text("Guess The Number")
                    .font(.title3)
                    .padding()
                
                Spacer()
                
                Group{
                    Text("Choose number between ") + Text("1").fontWeight(.bold) + Text(" and ") + Text(String(maxNumber)).fontWeight(.bold)
                }.padding(.bottom, 10)
                
                
                
                Text(userEntered == "" ? " " : userEntered)
                    .font(.system(size: 50, weight: .medium, design: .default))
                    .frame(width: 200, alignment: .center)
                    .background(Color(.systemGray6))
                
                if userEnteredHistory != "" {
                    Text("You entered # \(userEnteredHistory), but it is: ")
                        +
                    Text(feedback).fontWeight(.bold)
                        .foregroundColor(feedback == "You Won" ? .green : .red)
                }
                
                
                Button(action: {
                    // get the user input
                    if (Int(userEntered)!) > randomNumber {
                        feedback = "Too High"
                        numberOfTries = numberOfTries - 1
                    }else if (Int(userEntered)!) < randomNumber {
                        feedback = "Too Low"
                        numberOfTries = numberOfTries - 1
                    }else{
                        feedback = "You Won"
                        score = score + 1
                        // show you won zstack overlay
                        showingYouWonOverlay = true
                    }
                    userEnteredHistory = userEntered
                    userEntered = ""
                    
                    if numberOfTries == 0 {
                        showingAlert = true
                    }
                    
                    
                }){
                    HStack{
                        Text("Guess The Number")
                            .padding(20)
                    }
                    .background(Color(.systemGreen))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding()
                }
                .alert(isPresented:$showingAlert) {
                    Alert(
                       title: Text("Game Over"),
                       message: Text("Would you like to play again?"),
                       primaryButton: .destructive(Text("Quit")) {
                           // end game and return to main menu
                            endGame()
                       },
                        secondaryButton: .cancel(Text("Play Again")){
                            playAgain()
                        }
                            
                    )
                }
                
                Text("Number of tries left: ") + Text(String(numberOfTries)).fontWeight(.bold)
                
                
                
                Spacer()
                
                
                VStack(spacing: 30){
                    
                    Group{
                        HStack{
                            NumberPad(text: "1")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "1")
                                }
                            NumberPad(text: "2")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "2")
                                }
                            NumberPad(text: "3")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "3")
                                }
                        }
                    }
                    
                    
                    Group{
                        HStack{
                            NumberPad(text: "4")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "4")
                                }
                            NumberPad(text: "5")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "5")
                                }
                            NumberPad(text: "6")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "6")
                                }
                        }
                    }
                    
                    Group{
                        HStack{
                            NumberPad(text: "7")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "7")
                                }
                            NumberPad(text: "8")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "8")
                                }
                            NumberPad(text: "9")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "9")
                                }
                        }
                    }
                    
                    
                    
                    Group{
                        HStack{
                            Circle()
                                .strokeBorder(Color.gray, lineWidth: 3)
                                .background(Circle().fill(Color.yellow))
                                .shadow(radius: 20)
                                .overlay(Text("clear").font(.title3).foregroundColor(.white))
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "")
                                }
                            
                            NumberPad(text: "0")
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "0")
                                }
                            
                            Circle()
                                .strokeBorder(Color.gray, lineWidth: 3)
                                .background(Circle().fill(Color.red))
                                .shadow(radius: 20)
                                .overlay(Text("DEL").font(.title3).foregroundColor(.white))
                                .onTapGesture {
                                    displayUserEnteredNumber(digit: "-1")
                                }
                        }
                    }
                    
                }
                .frame(height: 300)
                .padding()
                
            }
            .padding(.bottom, 20)
            .opacity(showingYouWonOverlay ? 0.2 : 1)
            
            
            if showingYouWonOverlay{
                VStack{
                    LottieView(filename: "winner", loopMode: .repeat(3))
                        .frame(width: 150, height: 150)
                    HStack{
                        Spacer()
                        Text("Congratulations").font(.title)
                        Spacer()
                    }
                    Text("You Guessed The Number!")
                    Divider()
                    Text("Would you like to play again?")
                    HStack{
                        Button(action: {
                            // play again
                            playAgain()
                        }){
                            HStack{
                                Text("Play Again")
                                    .padding(20)
                            }
                            .background(Color(.systemGreen))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .padding()
                        }
                        Button(action: {
                            // quit
                            endGame()
                        }){
                            HStack{
                                Text("End Game")
                                    .padding(20)
                            }
                            .background(Color(.systemRed))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .padding()
                        }
                    }
                    .padding()

                    
                }
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 3)
                            .background(Color.white))
                .padding()
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear(){
            if level == 1 {
                maxNumber = 20
            }else if level == 2 {
                maxNumber = 50
            }else if level == 3 {
                maxNumber = 99
            }
            randomNumber =  Int.random(in: 1..<maxNumber)
            print (randomNumber)
        }
        

    }
    
    func displayUserEnteredNumber(digit: String){
        if digit == "" {
            // clear out everything
            userEntered = ""
        }
        else if digit == "-1" {
            // remove last digit if there is at least 1 digit
            userEntered = String(userEntered.dropLast())
            if userEntered.count == 0 {
                userEntered = ""
            }
        }
        else if userEntered.count <= 2 {
            // display/append the digit
            userEntered = userEntered + digit
        }
    }
    
    func endGame() {
        self.presentationMode.wrappedValue.dismiss()
    }

    func playAgain(){
        randomNumber =  Int.random(in: 1..<maxNumber)
        print (randomNumber)
        numberOfTries = 3
        userEnteredHistory = ""
        showingYouWonOverlay = false
    }
    
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(level: 1)            
            .previewDevice("iPhone 12 Pro")
    }
}

struct NumberPad : View {
    var text: String
    var body : some View {
        Circle()
            .strokeBorder(Color.gray, lineWidth: 3)
            .background(Circle().fill(Color.blue))
            .shadow(radius: 20)
            .overlay(Text(text).font(.title).foregroundColor(.white))
    }
}
