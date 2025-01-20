//
//  ContentView.swift
//  NavigationStackEtisha
//
//  Created by MANAS VIJAYWARGIYA on 20/01/25.
//

import SwiftUI

struct Series: Identifiable, Hashable {
  let id = UUID()
  var name: String
  var rating: Double
}

struct Movie: Identifiable, Hashable {
  let id = UUID()
  var name: String
}

struct ContentView: View {
  var tvSeries: [Series] = [
    Series(name: "Squid Game", rating: 5.0),
    Series(name: "Game of Thrones", rating: 4.8),
    Series(name: "The Flash", rating: 4.5),
    Series(name: "StartUp", rating: 4.4),
    Series(name: "Silicon Valley", rating: 4.4)
  ]
  
  var movies: [Movie] = [
    Movie(name: "DDLJ"),
    Movie(name: "Kuch Kuch Hota Hai"),
    Movie(name: "Main Hoon Na"),
    Movie(name: "The Avengers"),
    Movie(name: "Pathaan"),
    Movie(name: "Jawan"),
    Movie(name: "Iron Man")
  ]
  
  @State private var path = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $path) {
      List {
        Section("Series") {
          ForEach(tvSeries) { series in
            NavigationLink(series.name, value: series)
          }
        }
        
        Section("Movies") {
          ForEach(movies) { movie in
            NavigationLink(movie.name, value: movie)
          }
        }
      }
      .navigationDestination(for: Series.self) { series in
        VStack(spacing: 20) {
          Text("\(series.name) - Rating: \(series.rating, specifier: "%.1f")")
          
          Button("Add a Movie") {
            path.append(Movie(name: "Jumanji"))
          }
          Button("Go Back") {
            path.removeLast()
          }
          Button("Go to Home") {
            path = NavigationPath()
          }
        }
      }
      .navigationDestination(for: Movie.self) { movie in
        VStack {
          Text(movie.name)
          ForEach(tvSeries) { series in
            NavigationLink(series.name, value: series)
          }
        }
      }
      .navigationTitle("Entertainment")
    }
    Text("Number of views in the stack: \(path.count)")
  }
}

#Preview {
  ContentView()
}
