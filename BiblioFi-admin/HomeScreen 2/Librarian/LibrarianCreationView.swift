import SwiftUI

struct LibrarianCreationView: View {
    @StateObject private var controller = LibrarianController()
    @State var refresh: Bool = false
    @State private var showModal = false
    @State private var librarianName = ""
    @State private var librarianEmail = ""
    @State private var librarianPhoneNumber = ""
    @State private var librarianAddress = ""
    @State private var librarianPassword = ""

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Library Name")
                    .font(.largeTitle)
                    .padding(.leading, 20)

                Spacer()
            }
            .padding(.top, 20)

            Divider()
                .padding(.horizontal, 20)
            
            if let librarian = controller.librarian {
                LibrarianInfoView(librarian: librarian, onSave: { updatedLibrarian in
                                    // Update the librarian details
                }, onDelete: {
                    // Handle librarian deletion
                    let librarianUid = UserDefaults.standard.string(forKey: "LibrarianID")
                    guard let libId = librarianUid else { return }
                    LibrarianManager.shared.deleteLibrarian(id: libId) { result in
                        switch result {
                        case .success():
                            UserDefaults.standard.removeObject(forKey: "LibrarianID")
                            refresh.toggle()
                            print("Librarian deleted")
                        case .failure(let error):
                            print("Error at deleting \(error)")
                        }
                    }
                })
            } else {
                VStack {
                    Text("No librarian is currently available.\nClick the 'Add' button to add a librarian.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)

                    Button(action: {
                        showModal = true
                    }) {
                        Text("Create")
                            .font(.custom("Avenir Next", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "A0522D")) // Button Color
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                        

                    }
                    .padding(.top, 20)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "FDF5E6"))
        .onAppear(perform: {
            let librarianUid = UserDefaults.standard.string(forKey: "LibrarianID")
            print(librarianUid)
            guard let libId = librarianUid else { return }
            controller.fetchLibrarian(withId: libId)
        })
        .sheet(isPresented: $showModal) {
            AddLibrarianView(
                librarianName: $librarianName,
                librarianEmail: $librarianEmail,
                librarianPhoneNumber: $librarianPhoneNumber,
                librarianAddress: $librarianAddress,
                librarianPassword: $librarianPassword,
                onDone: {
                    controller.addLibrarian(name: librarianName, email: librarianEmail, phoneNumber: librarianPhoneNumber, address: librarianAddress, password: librarianPassword) { result in
                        
                        switch result {
                        case .success:
                            sendEmailToLibrarian()
                            let librarianUid = UserDefaults.standard.string(forKey: "LibrarianID")
                            print(librarianUid!)
                            guard let libId = librarianUid else { return }
                            controller.fetchLibrarian(withId: libId)
                            refresh.toggle()
                            showModal = false
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            )
        }
    }
}

func sendEmailToLibrarian() {
    
}

struct LibrarianInfoView: View {
    @State private var librarianName: String
    @State private var librarianEmail: String
    @State private var librarianPhoneNumber: String
    @State private var librarianAddress: String
    var librarian: Librarian
    let onSave: (Librarian) -> Void
    let onDelete: () -> Void

    init(librarian: Librarian, onSave: @escaping (Librarian) -> Void, onDelete: @escaping () -> Void) {
        self.librarian = librarian
        self.onSave = onSave
        self.onDelete = onDelete
        _librarianName = State(initialValue: librarian.name)
        _librarianEmail = State(initialValue: librarian.email)
        _librarianPhoneNumber = State(initialValue: librarian.phoneNumber)
        _librarianAddress = State(initialValue: librarian.address)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Librarian Information")
                .font(.title)
                .padding(.bottom, 10)

            Group {
                Text("Name")
                    .font(.title2)
                    .padding(.bottom, 2)
            
                    Text(librarianName)
                        .font(.title2)
                        .padding(.bottom, 10)
                

                Text("Email")
                    .font(.title2)
                    .padding(.bottom, 2)
                
                    Text(librarianEmail)
                        .font(.title2)
                        .padding(.bottom, 20)
                
                Text("Phone Number")
                    .font(.title2)
                    .padding(.bottom, 2)
                
                    Text(librarianPhoneNumber)
                        .font(.title2)
                        .padding(.bottom, 20)

                Text("Address")
                    .font(.title2)
                    .padding(.bottom, 2)
               
                    Text(librarianAddress)
                        .font(.title2)
                        .padding(.bottom, 20)
                
            }

            HStack {
                Spacer()
                Button(action: onDelete) {
                    Text("Delete")
                        .font(.title2)
                        .padding()
                        .background(Color(hex: "5D4037"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 8)
        .frame(minWidth: 300)
        .frame(height: 600)
    }
}

#Preview {
    LibrarianInfoView(
        librarian: Librarian(id: "1", name: "John Doe", email: "john.doe@example.com", phoneNumber: "1234567890", address: "123 Main St"),
        onSave: { _ in },
        onDelete: {}
    )
}


#Preview {
    LibrarianCreationView()
}
