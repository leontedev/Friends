//
//  ContentView.swift
//  Friends
//
//  Created by Mihai Leonte on 25/11/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var userList = Users()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userList.users, id:\.self) { user in
                    NavigationLink(destination: DetailView(user: user, userList: self.userList)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(user.name)
                                Spacer()
                                Text("Friends: \(user.friends.count)")
                                    .font(.caption)
                            }
                            Text(user.address)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
            }
            .navigationBarTitle(Text("Friends"))
        }
        .onAppear {
            let url = URLRequest(url: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!)
            URLSession.shared.dataTask(with: url) { (data, resp, error) in
                let decoder = JSONDecoder()
                if let userData = data {
                    DispatchQueue.main.async {
                        do {
                            self.userList.users = try decoder.decode([User].self, from: userData)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }.resume()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
