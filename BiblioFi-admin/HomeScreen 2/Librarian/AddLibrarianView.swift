//
//  AddLibrarianView.swift
//  BiblioFi-admin
//
//  Created by Akshat Kamboj on 04/07/24.
//

import SwiftUI

struct AddLibrarianView: View {
    @Binding var librarianName: String
    @Binding var librarianEmail: String
    @Binding var librarianPhoneNumber: String
    @Binding var librarianAddress: String
    var onDone: () -> Void
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Librarian Registration")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            TextField("Librarian name", text: $librarianName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            TextField("Librarian's email address", text: $librarianEmail)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            TextField("Phone number", text: $librarianPhoneNumber)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .keyboardType(.phonePad)
            
            TextField("Address", text: $librarianAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            Button(
                action: {
                    if isValidForm() {
                        onDone()
                        librarianName = ""
                        librarianEmail = ""
                        librarianPhoneNumber = ""
                        librarianAddress = ""
                    }
                }
            ) {
                Text("Create")
                    .font(.custom("Avenir Next", size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "A0522D")) 
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .padding()
            
            Text("Credentials will be sent to librarian")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .frame(maxWidth: 500)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func isValidName(_ name: String) -> Bool {
        return !name.isEmpty && name.allSatisfy { $0.isLetter || $0.isWhitespace }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegEx = "^[0-9]{10,15}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: phoneNumber)
    }
    
    private func isValidAddress(_ address: String) -> Bool {
        return !address.isEmpty
    }
    
    private func isValidForm() -> Bool {
        if !isValidName(librarianName) {
            alertMessage = "Please enter a valid name."
            showAlert = true
            return false
        }
        
        if !isValidEmail(librarianEmail) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return false
        }
        
        if !isValidPhoneNumber(librarianPhoneNumber) {
            alertMessage = "Please enter a valid phone number."
            showAlert = true
            return false
        }
        
        if !isValidAddress(librarianAddress) {
            alertMessage = "Please enter a valid address."
            showAlert = true
            return false
        }
        
        return true
    }
}
