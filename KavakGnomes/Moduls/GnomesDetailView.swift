//
//  GnomesDetailView.swift
//  KavakGnomes
//
//  Created by daniel ortiz millan on 20/05/24.
//

import SwiftUI

struct GnomeDetailView: View {
    let gnome: Brastlewark
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: gnome.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                Text("Name: \(gnome.name)")
                    .font(.largeTitle)
                Text("Age: \(gnome.age)")
                Text("Weight: \(gnome.weight, specifier: "%.2f") kg")
                Text("Height: \(gnome.height, specifier: "%.2f") cm")
                Text("Hair Color: \(gnome.hairColor)")
                Text("Professions: \(gnome.professions.joined(separator: ", "))")
                Text("Friends: \(gnome.friends.joined(separator: ", "))")
                Spacer()
            }
            .padding()
            .navigationTitle("Gnome Details")
        }
    }
}


#Preview {
    HabitantesView()
}
