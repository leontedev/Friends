//
//  DetailView.swift
//  Friends
//
//  Created by Mihai Leonte on 25/11/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var user: User
    var userList: Users
    
    var body: some View {
        VStack {
            Text(user.name)
                .font(.title)
                .padding()
            
            Divider()
            
            Text("Age: \(user.age)")
                .padding()
            
            Spacer()
            
            Text(user.about)
                .font(.caption)
                .padding()
            
            Divider()
            
            List {
                ForEach(user.friends, id:\.self) { friend in
                    
                    HStack {
                         
                        Text(friend.name)
                        
                        Spacer()
                        
                        if self.userList.users.first(where: { $0.id == friend.id }) != nil {
                            NavigationLink(destination: DetailView(user: self.userList.users.first(where: { $0.id == friend.id })!, userList: self.userList)) {
                                Text("Friends: \(self.userList.users.first(where: { $0.id == friend.id })?.friends.count ?? 0)")
                                    .font(.caption)
                            }
                        }

                    }
                }
            }.frame(minHeight: 400)
            
            Spacer()
            
        }
        .padding()
        
        
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
