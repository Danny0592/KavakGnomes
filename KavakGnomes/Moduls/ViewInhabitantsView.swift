//
//  ViewInhabitantsView.swift
//  KavakGnomes
//
//  Created by daniel ortiz millan on 17/05/24.
//

import SwiftUI


struct HabitantesView: View {
    @State private var gnomes: [Brastlewark] = []
    
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
}

#Preview {
    HabitantesView()
}




