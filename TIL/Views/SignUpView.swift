//
//  SignUpView.swift
//  TIL
//
//  Created by Vincio on 9/7/21.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var sessionStore = SessionStore()
    @ObservedObject var usersViewModel = UsersViewModel()
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmEmail = ""
    @State private var confirmPassword = ""
    var body: some View {
        ZStack {
            Color(hex: colors[1])
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("TIL")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)

                Text("Create an account")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.bottom)


                VStack {
                    VStack {

                        TextField("Username", text: $username)

                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)
                            .preferredColorScheme(.light)

                    }.padding(.bottom, 20)

                    VStack {


                        TextField("Email", text: $email)

                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)
                            .preferredColorScheme(.light)

                    }
                    .padding(.bottom, 20)
                    VStack {


                        TextField("Confirm Email", text: $confirmEmail)

                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)
                            .preferredColorScheme(.light)

                    }
                    .padding(.bottom, 20)


                    VStack {


                        SecureField("Password", text: $password)


                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)
                            .preferredColorScheme(.light)
                    }
                    .padding(.bottom, 20)
                    VStack {


                        SecureField("Confirm Password", text: $confirmPassword, onCommit: signUp)
     
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)
                            .preferredColorScheme(.light)
                    }


                    if !username.isEmpty && !email.isEmpty && !password.isEmpty && !confirmEmail.isEmpty && !confirmPassword.isEmpty {
                    Button(action: signUp){

                        Text("Let's Go!")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.title3)


                    }
                    .alert(isPresented: $sessionStore.showAlert, content:  { Alert(title: Text("Error"), message: Text( sessionStore.alertMessage), dismissButton: .default(Text("OK")))})
                    .foregroundColor(Color.white)
                    .padding(30)
                    .animation(.default)
                    }



                }.padding(.bottom, 50)
                Spacer(minLength: 20)


            }.frame(width: rect.width - 30)
            .preferredColorScheme(.light)
        }

    }
    func signUp() {
        if usersViewModel.users.contains(where: {$0.username.lowercased() == self.username.lowercased()}) || self.email != self.confirmEmail ||  self.password != self.confirmPassword || self.username == "" {

            if usersViewModel.users.contains(where: {$0.username.lowercased() == self.username.lowercased()}) {
                sessionStore.alertMessage = "The username you entered already exists!"
            }
             if self.email != self.confirmEmail {
                sessionStore.alertMessage = "The email addresses you entered don't match."

            }
             if self.password != self.confirmPassword {
                sessionStore.alertMessage = "The passwords you entered don't match."
            }

              if self.username == "" {
                sessionStore.alertMessage = "Please enter your username."
            }
            sessionStore.showAlert = true


        } else {
            sessionStore.signUp(email: email, username: username, password: password)
        }



    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
