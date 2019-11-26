//
//  ContentView.swift
//  Friends
//
//  Created by Mihai Leonte on 25/11/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: SavedUsers.entity(), sortDescriptors: []) var savedUsers: FetchedResults<SavedUsers>
    
    @ObservedObject var userList = Users()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("savedUsers \(self.savedUsers.count)")
                Text("userList \(self.userList.users.count)")
                
                List {
                    ForEach(self.savedUsers, id:\.self) { user in
                        NavigationLink(destination: DetailView(user: user)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(user.name ?? "")
                                    Spacer()
                                    Text("Friends: \(user.friends?.count ?? 0)").font(.caption)
                                }
                                Text(user.address ?? "")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                    }
                }
                .navigationBarTitle(Text("Friends"))
            }
        }
        .onAppear {
            
            // Check SceneDelegate - I am deleting all Core Data on each launch
            if self.savedUsers.isEmpty {
                
                let url = URLRequest(url: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!)
                URLSession.shared.dataTask(with: url) { (data, resp, error) in
                    let decoder = JSONDecoder()
                    if let userData = data {
                        DispatchQueue.main.async {
                            do {
                                self.userList.users = try decoder.decode([User].self, from: userData)
                                
                                var counter = 0
                                
                                for user in self.userList.users {
                                    counter += 1
                                    let newUser = SavedUsers(context: self.moc)
                                    newUser.id = user.id
                                    newUser.name = user.name
                                    newUser.age = user.age
                                    newUser.address = user.address
                                    newUser.about = user.about
                                    for friend in user.friends {
                                        let newFriend = Friends(context: self.moc)
                                        newFriend.id = friend.id
                                        newFriend.name = friend.name
                                        newFriend.friendOf = newUser
                                    }
                                }
                                
                                if self.moc.hasChanges {
                                    try? self.moc.save()
                                    print("Core Data saved, \(counter)")
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }.resume()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
