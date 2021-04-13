//
//  TestView.swift
//  Guess The Number
//
//  Created by Martin Spusta on 3/8/21.
//

import SwiftUI
import Network


struct User {
    var name: String
    var jobTitle: String
    var emailAddress: String
}

struct EmailAddress: View {
    var address: String

    var body: some View {
        HStack {
            Image(systemName: "envelope")
            Text(address)
        }
    }
}

struct UserDetails: View {
    var user: User

    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.largeTitle)
                .foregroundColor(.primary)
//            Text(user.jobTitle)
//                .foregroundColor(.secondary)
            EmailAddress(address: user.emailAddress)
        }
    }
}


//let user = User(name: "Martin Spusta", jobTitle: "Instructor of Xcode", emailAddress: "martin.spusta@lauruscollege.edu")

struct TestView: View {
    @State var isConnected = false
    var body: some View {
        
        
        VStack{
            
            Button(action: {
                // post API
                // 1. define json object
                let jsonObject = [
                    "someDataField" : "Test123"
                ]
                // 2. specify POST api url
                let url = URL(string: "https://postman-echo.com/post")!
                var request = URLRequest(url: url)
                // 3. set method to POST
                request.httpMethod = "POST"
                // 4. add json object to httpBody
                request.httpBody = try? JSONEncoder().encode(jsonObject)
                // 5. specify MIME type
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                URLSession.shared.dataTask(with: request){ data, response, error in
                    if data != nil {
                        print (data!) // 6. API finished successfully
                    }else{
                        print("POST API failed \(error?.localizedDescription ?? "Uknown error")")
                    }
                }.resume() // 7. execute the API
            }){
                Text("Call POST API")
            }
            
        }.onAppear(){
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    isConnected = true
                } else {
                    isConnected = false
                }
            }
            let queue = DispatchQueue(label: "Monitor")
            monitor.start(queue: queue)
        }
        
//        VStack{
//
//            Text("Main Menu")
//                .modifier(ScreenTitle())
//            Spacer()
//        }
        
        //UserDetails(user: user)
    }
}

struct ScreenTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .previewDevice("iPhone 12 Pro")
    }
}



