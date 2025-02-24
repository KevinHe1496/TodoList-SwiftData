//
//  CategoryRowView.swift
//  ToDoList
//
//  Created by Kevin Heredia on 23/2/25.
//

import SwiftUI

struct CategoryRowView: View {
    let name: String
    let icon: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(.white)
                .padding()
                .background(.lightBackground)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.lightBackground)
                )
            
            Text(name)
                .font(.headline)
        }
    }
}

#Preview {
    CategoryRowView(name: "Shop", icon: "house")
}
