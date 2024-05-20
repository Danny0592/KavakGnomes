//
//  ViewInhabitantsView.swift
//  KavakGnomes
//
//  Created by daniel ortiz millan on 17/05/24.
//

import SwiftUI

struct HabitantesView: View {
    @State private var gnomes: [Brastlewark] = []
    @State private var searchText: String = ""
    
    var filteredGnomes: [Brastlewark] {
        if searchText.isEmpty {
            return gnomes
        } else {
            return gnomes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Search...", text: $searchText)
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 8)
                                }
                            )
                            .padding(.horizontal, 10)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                        }
                    }
                    .animation(.default)
                    
                    List(filteredGnomes, id: \.id) { gnome in
                        GnomeRow(gnome: gnome)
                    }
                    .onAppear {
                        fetchGnomes()
                    }
                    .navigationTitle("Habitantes")
                }
                .padding()
            }
        }
    
    func fetchGnomes() {
        GnomesApiClient().getGnomes { result in
            switch result {
            case .success(let gnomesModel):
                DispatchQueue.main.async {
                    self.gnomes = gnomesModel.brastlewark
                }
            case .failure(let error):
                print("Error fetching gnomes: \(error)")
            }
        }
    }
}

struct GnomeRow: View {
    let gnome: Brastlewark
    
    var body: some View {
        NavigationLink(destination: GnomeDetailView(gnome: gnome)) {
            HStack {
                AsyncImage(url: URL(string: gnome.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 80)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                Text("Name: \(gnome.name)")
                    .font(.headline)
                Spacer()
            }
            .padding()
        }
    }
}





/*import SwiftUI

struct HabitantesView: View {
    @State private var gnomes: [Brastlewark] = []
    @State private var searchText: String = ""
    
    var filteredGnomes: [Brastlewark] {
            if searchText.isEmpty {
                return gnomes
            } else {
                return gnomes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
    
    var body: some View {
        NavigationView {
            List(gnomes, id: \.id) { gnome in
                GnomeRow(gnome: gnome)
            }
            .onAppear {
                fetchGnomes()
            }
            .navigationTitle("Gnomes")
        }
    }
    
    func fetchGnomes() {
        GnomesApiClient().getGnomes { result in
            switch result {
            case .success(let gnomesModel):
                DispatchQueue.main.async {
                    self.gnomes = gnomesModel.brastlewark
                }
            case .failure(let error):
                print("Error fetching gnomes: \(error)")
            }
        }
    }
}

struct GnomeRow: View {
    let gnome: Brastlewark
    var body: some View {
        NavigationLink(destination: GnomeDetailView(gnome: gnome)) {
            HStack {
                AsyncImage(url: URL(string: gnome.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                Text("Name: \(gnome.name)")
                    .font(.headline)
                Spacer()
            }
            .padding()
        }
    }
}*/

#Preview {
    HabitantesView()
}




