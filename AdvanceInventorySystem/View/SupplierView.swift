//
//  SupplierView.swift
//  AdvanceInventorySystem
//
//  Created by Karlina Dwi Septiani on 18/12/24.
//

import SwiftUI

struct SupplierView: View {
    
//    @State private var suppliers: [Supplier] = [
//        Supplier(id: 1, name: "macbook", alamat: "M1", kontak: "098123456789", lat: -6.2088, long: 106.8456)
//    ]

    @EnvironmentObject var viewModel: SupplierViewModel

    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.suppliers.isEmpty {
                    
                    List(viewModel.suppliers) { supplier in
                        NavigationLink(destination: SupplierDetailView(supplier: supplier)) {
                            VStack(alignment: .leading) {
                                Text(supplier.name)
                                    .font(.headline)
                                Text(supplier.address)
                                    .font(.subheadline)
                                Text("Contact: \(supplier.contact)")
                                    .font(.footnote)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                } else {
                    
                    Spacer()
                    
                    Text("Belum ada supplier tersimpan")
                    
                    Spacer()
                }
                
                NavigationLink(destination: AddSupplierView()) {
                    Text("Tambah Supplier")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
            }
            .showTabBar()
            .navigationTitle("Daftar Supplier")
            .onAppear{
                Task {
                    await viewModel.fetchSuppliers()
                }
            }
        }
    }
}

#Preview {
    SupplierView()
}
