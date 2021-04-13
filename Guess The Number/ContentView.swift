//
//  ContentView.swift
//  Guess The Number
//
//  Created by Martin Spusta on 2/14/21.
//

import SwiftUI


struct ContentView: View {
    
    @State var isMainScreenDisplayed = false
    @State var displayName : String = ""
    @State var isRotated = false
    
    @State var isLoading = true
    
    
    var body: some View {
        
        NavigationView(){
            VStack() {
                
                if isLoading {
                    // loading spinner
                    Group{
                        ProgressView()
                    }
                }else{
                    // main view
                    Group{
                        NavigationLink(
                            destination: MainView(playerName: displayName), isActive: $isMainScreenDisplayed){ EmptyView()}
                        
                        HStack{
                            Spacer()
                        }
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
                            .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                            .animation(.easeOut)
                            .onAppear(){
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    isRotated.toggle()
                                }
                            }
                        
                        //                LottieView(filename: "questionmark", loopMode: .repeat(3))
                        //                    .frame(width: 150, height: 150)
                        
                        
                        
                        
                        TextField("Enter Your Name", text: $displayName)
                            .font(.title)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .keyboardType(.alphabet)
                            .autocapitalization(.words)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .padding(.top, 50)
                        
                        Button(action: {
                            // trigger navigation to Main Screen
                            isMainScreenDisplayed = true
                        }){
                            HStack{
                                Spacer()
                                Text("Start")
                                    .padding()
                                Spacer()
                            }
                            .background(Color(.systemBlue))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                        }
                        .padding(.bottom, 50)
                        .disabled(displayName.isEmpty)
                        .opacity(displayName.isEmpty ? 0.5 : 1)
                        
                        Spacer()
                    }
                }
                
            }
            .onAppear(){
                // some long running task
                isLoading = false
            }
            .background(Color(.systemTeal))
            .edgesIgnoringSafeArea(.all)
            
            .navigationTitle("Player Name")
            .navigationBarHidden(true)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 12 Pro")
        }
    }
}

