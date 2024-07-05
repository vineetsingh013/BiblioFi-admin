import SwiftUI

struct LibrarianCreationView: View {
    @StateObject private var controller = LibrarianController()
    @State private var showModal = false
    @State private var librarianName = ""
    @State private var librarianEmail = ""
    @State private var librarianPhoneNumber = ""
    @State private var librarianAddress = ""
    
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
            
            if let librarian = controller.librarians.first {
                LibrarianInfoView(
                    librarian: librarian,
                    onSave: { updatedLibrarian in
                        if let index = controller.librarians.firstIndex(where: { $0.id == updatedLibrarian.id }) {
                            controller.librarians[index] = updatedLibrarian
                        }
                    },
                    onDelete: {
                        if let index = controller.librarians.firstIndex(where: { $0.id == librarian.id }) {
                            controller.deleteLibrarian(at: index)
                        }
                    }
                )
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
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 220, height: 60)
                            .cornerRadius(15.0)
                            .background(Color(.systemPink).opacity(0.2))
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
        .background(Color(.systemGray6))
        .sheet(isPresented: $showModal) {
            AddLibrarianView(
                librarianName: $librarianName,
                librarianEmail: $librarianEmail,
                librarianPhoneNumber: $librarianPhoneNumber,
                librarianAddress: $librarianAddress,
                onDone: {
                    controller.addLibrarian(name: librarianName, email: librarianEmail, phoneNumber: librarianPhoneNumber, address: librarianAddress)
                    showModal = false
                }
            )
        }
    }
}

struct LibrarianInfoView: View {
    @State private var isEditing = false
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
                if isEditing {
                    TextField("Name", text: $librarianName)
                        .padding()
                        .background(Color(.systemGray3))
                        .cornerRadius(5.0)
                        .padding(.bottom, 10)
                } else {
                    Text(librarianName)
                        .font(.title2)
                        .padding(.bottom, 10)
                }
                
                Text("Email")
                    .font(.title2)
                    .padding(.bottom, 2)
                if isEditing {
                    TextField("Email", text: $librarianEmail)
                        .padding()
                        .background(Color(.systemGray3))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                } else {
                    Text(librarianEmail)
                        .font(.title2)
                        .padding(.bottom, 20)
                }
                
                Text("Phone Number")
                    .font(.title2)
                    .padding(.bottom, 2)
                if isEditing {
                    TextField("Phone Number", text: $librarianPhoneNumber)
                        .padding()
                        .background(Color(.systemGray3))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                } else {
                    Text(librarianPhoneNumber)
                        .font(.title2)
                        .padding(.bottom, 20)
                }
                
                Text("Address")
                    .font(.title2)
                    .padding(.bottom, 2)
                if isEditing {
                    TextField("Address", text: $librarianAddress)
                        .padding()
                        .background(Color(.systemGray3))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                } else {
                    Text(librarianAddress)
                        .font(.title2)
                        .padding(.bottom, 20)
                }
            }
            
            HStack {
                Button(action: {
                    if isEditing {
                        let updatedLibrarian = Librarian(id: librarian.id, name: librarianName, email: librarianEmail, phoneNumber: librarianPhoneNumber, address: librarianAddress)
                        onSave(updatedLibrarian)
                    }
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Save" : "Edit")
                        .font(.title2)
                        .padding()
                        .background(Color(.systemPink).opacity(0.2))
                        .cornerRadius(10)
                }
                Spacer()
                Button(action: onDelete) {
                    Text("Delete")
                        .font(.title2)
                        .padding()
                        .background(Color(.systemPink).opacity(0.2))
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
    LibrarianCreationView()
}
