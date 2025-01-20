//
//  ContentView.swift
//  NavigationStackSeanAllen
//
//  Created by MANAS VIJAYWARGIYA on 20/01/25.
//

import SwiftUI

struct Platform: Hashable {
  let name: String
  let imageName: String
  let color: Color
}

struct Game: Hashable {
  let name: String
  let rating: String
}

struct ContentView: View {
  var platforms: [Platform] = [.init(name: "Xbox", imageName: "xbox.logo", color: .green),
                               .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
                               .init(name: "PC", imageName: "pc", color: .pink),
                               .init(name: "Mobile", imageName: "iphone", color: .mint)]
  
  var games: [Game] = [.init(name: "Age of Empires", rating: "99"),
                       .init(name: "Call of Duty", rating: "99"),
                       .init(name: "Grand Theft Auto V", rating: "98"),
                       .init(name: "Assassin's Creed", rating: "88")]
  
  // @State private var path: [Game] = []
  @State private var path = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $path) {
      List {
        Section("Platforms") {
          ForEach(platforms, id: \.name) { platform in
            NavigationLink(value: platform) {
              Label(platform.name, systemImage: platform.imageName).foregroundStyle(platform.color)
            }
          }
        }
        
        Section("Games") {
          ForEach(games, id: \.name) { game in
            NavigationLink(value: game) {
              Text(game.name)
            }
          }
          // Button("Add Games") {
            // path.append(games.first!)
            // path = games
          // }
        }
      }
      .navigationTitle("Gaming")
      .navigationBarTitleDisplayMode(.inline)
      .navigationDestination(for: Platform.self) { platform in
        ZStack {
          platform.color.ignoresSafeArea()
          VStack {
            Label(platform.name, systemImage: platform.imageName).font(.largeTitle).bold()
            List {
              ForEach(games, id: \.name) { game in
                NavigationLink(value: game) {
                  Text(game.name)
                }
              }
            }
          }
        }
      }
      .navigationDestination(for: Game.self) { game in
        VStack(spacing: 20) {
          Text("\(game.name) - \(game.rating)").font(.largeTitle).bold()
         
          Button("Recommend Game") {
            path.append(games.randomElement()!)
          }
          
          Button("Go to another platform") {
            path.append(platforms.randomElement()!)
          }
          
          Button("Go Home") {
            // path.removeLast()
            // path.removeLast(4)
            path.removeLast(path.count)
            // path = NavigationPath()
          }
        }
      }
    }
    Text("Number of views in the stack: \(path.count)")
  }
}

#Preview {
  ContentView()
}
