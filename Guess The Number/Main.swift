//
//  ContentView.swift
//  Guess The Number
//
//  Created by Martin Spusta on 2/14/21.
//

import SwiftUI


struct MainView: View {
    @State var level = 1
    
    @State var isHighScoreScreenDisplayed = false
    @State var isGameScreenDisplayed = false

    
    
    var playerName : String
    var body: some View {
    
//        NavigationView{
            VStack() {
                NavigationLink(
                    destination: HighScoreView(), isActive: $isHighScoreScreenDisplayed){ EmptyView()}
                NavigationLink(
                    destination: GameView(level: level), isActive: $isGameScreenDisplayed){ EmptyView()}
                
                Spacer()
                
                HStack()
                {
                    Image(systemName: "star.fill")
                    Text("Guess The Number")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image(systemName: "star.fill")
                }.foregroundColor(.white)
                Image("dice")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .background(Color(.white))
                    .clipShape(Circle())
                    .padding()
                
                
                
                
                if playerName != "" {
                    Text("Welcome").font(.headline)
                    Text(playerName).font(.title)
                }
                
                
                Spacer()

                // Levels
                Group{
                    Text("Select the Level of Difficulty")
                 
                    HStack(alignment: .center){
                        Spacer()
                        
                        Button(action: {
                            // some code for Level 1
                            level = 1
                        }, label: {
                            VStack(alignment: .center){
                                Text("Level 1").fontWeight(.bold)
                                Text("1 - 20").fontWeight(.bold)
                            }.modifier(Levels(selected: level == 1 ? true : false))
                            
                        })
                        
                        Button(action: {
                            // some code for Level 1
                            level = 2
                        }){
                            VStack(alignment: .center){
                                Text("Level 2")
                                Text("1 - 50")
                            }
                            .modifier(Levels(selected: level == 2 ? true : false))
                        }
                        
                        Button(action: {
                            // some code for Level 1
                            level = 3
                        }){
                            VStack(alignment: .center){
                                Text("Level 3")
                                Text("1 - 99")
                            }
                            .modifier(Levels(selected: level == 3 ? true : false))
                        }
                        
                        Spacer()
                    }
                }
                
                      
                
                
                // start button and high score button
                Group{
                    Button(action: {
                        // trigger navigation to Game Screen
                        isGameScreenDisplayed = true
                    }){
                        HStack{
                            Spacer()
                            Text("Start Game")
                             .padding()
                            Spacer()
                        }
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                    }
                    .padding(.top, 50)
                    
                    Button(action: {
                        // trigger navigation to High Score Screen
                        isHighScoreScreenDisplayed = true
                    }){
                        HStack{
                            Spacer()
                            Text("High Score")
                             .padding()
                            Spacer()
                        }
                        .background(Color(.black))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                    }
                    .padding(.bottom, 50)
                }
                
                
                

            }
            .background(Color(.systemTeal))
            .edgesIgnoringSafeArea(.bottom)            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Main Menu")
//            .navigationBarHidden(true)
                        
//        }
      
        

    }
}

struct Levels : ViewModifier {
    var selected : Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: selected ? 10 : 0)
            .padding(.horizontal, 5)
            .padding(.vertical)
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(playerName: "")
                .previewDevice("iPhone 12 Pro")
        }
    }
}

