//
//  ContentView.swift
//  QuickTask
//
//  Created by Harshil Patel on 29/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 20){
            Text("QuickTask")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("No tasks yet.")
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
