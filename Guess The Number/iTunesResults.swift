//
//  iTunesResults.swift
//  Guess The Number
//
//  Created by Martin Spusta on 3/10/21.
//

//        }


import SwiftUI
import URLImage

struct iTunesResults: View {
    
    @State private var results = [Result]()
       
    var body: some View {
        
        VStack{
            Text("iTunes Music Results:")
            Divider()
            
            List(results, id: \.id) { item in
                VStack(){
                    HStack{
                        URLImage(url: URL(string: item.artworkUrl100)!) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 75)
                                .aspectRatio(contentMode: .fit)
                        }
                        VStack(alignment: .leading){
                            Text(item.trackName).lineLimit(1)
                            Text(item.artistName).lineLimit(2)
                        }
                    }
                    
                }
            }

        }
        .onAppear(){
            LoadData()
        }
    }
    
    func LoadData(){
        // this function will call iTunes Search API
        // step 1. - define URL
        let url = URL(string: "https://itunes.apple.com/search?term=elvis+presley&entity=musicVideo")!
        // step 2. - create URL Request
        let request = URLRequest(url: url)
        // Step 3 - create network task
        URLSession.shared.dataTask(with: request) { data, response, error in
            // step 4
            if data != nil {
                print ("Data was retrieved from API")
                print(data!)
            }else{
                // error occured
                print("Getting API failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    let id = UUID()
    var artistName: String
    var trackName: String
    var artworkUrl100: String
}

struct iTunesResults_Previews: PreviewProvider {
    static var previews: some View {
        iTunesResults()
    }
}


//// check if data is nil - has no value
//if data != nil {
//    print ("Data was retrieved from API")
//    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data!) {
//        DispatchQueue.main.async {
//            // update our UI
//            results = decodedResponse.results
//            print ("API returned \(results.count) records ")
//        }
//        return
//
//    }else{
//        // error occured during decoding
//        print("Decoding failed: \(error?.localizedDescription ?? "Unknown error")")
//    }
//}else{
//    // error occured
//    print("Getting API failed: \(error?.localizedDescription ?? "Unknown error")")
//}
