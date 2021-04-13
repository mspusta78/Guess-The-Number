//
//  HighScoreView.swift
//  Guess The Number
//
//  Created by Martin Spusta on 3/13/21.
//

import SwiftUI

struct HighScoreView: View {
    @State private var results = [ResultHighScore()]
    
    var body: some View {
        VStack{
            Text("Top 10 Results")
            Divider()
            List(results, id: \.id) { item in
                HStack{
                    Text(item.displayname)
                    Spacer()
                    Text(String(item.score))
                }
            }
            
        }
        .padding()
        .navigationTitle("High Score")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            LoadData()
        }
    }
    func LoadData(){
        // call HighScore API
        let url = URL(string: "https://guessthenumber123.web.app/api/highscore")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if data != nil {
                if let decodedResponse = try? JSONDecoder().decode(ResponseHighScore.self, from: data!) {
                    DispatchQueue.main.async {
                        // update our UI
                        results = decodedResponse.results
                        print ("API returned \(results.count) records ")
                    }
                    return
            
                }else{
                    // error occured during decoding
                    print("Decoding failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }else{
                print("Getting data from API failed \(error?.localizedDescription ?? "Uknown error")")
            }
        }.resume()
    }
}

struct ResponseHighScore: Codable {
    var results: [ResultHighScore]
}

struct ResultHighScore: Codable {
    let id = UUID()
    var displayname: String = ""
    var score: Int = 0
}


struct HighScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoreView()
            .previewDevice("iPhone 12 Pro")
    }
}
