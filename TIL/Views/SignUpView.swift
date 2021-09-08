//
//  SignUpView.swift
//  TIL
//
//  Created by Vincio on 9/7/21.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var sessionStore = SessionStore()
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmEmail = ""
    @State private var confirmPassword = ""
    var body: some View {
        ZStack {
            Color(hex: color[1])
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("TIL")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: rect.width - 300, height: rect.height - 700, alignment: .center)

                Text("Create an account")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.bottom)


                VStack {
                    VStack {

                        TextField("Username", text: $username)
                        .foregroundColor(Color(hex: "222F3E"))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)

                    }.padding(.bottom, 20)

                    VStack {


                        TextField("Email", text: $email)
                        .foregroundColor(Color(hex: "222F3E"))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)

                    }
                    .padding(.bottom, 20)
                    VStack {


                        TextField("Confirm Email", text: $confirmEmail)
                        .foregroundColor(Color(hex: "222F3E"))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)

                    }
                    .padding(.bottom, 20)


                    VStack {


                        SecureField("Password", text: $password)

                        .foregroundColor(Color(hex: "222F3E"))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)
                    }
                    .padding(.bottom, 20)
                    VStack {


                        SecureField("Confirm Password", text: $confirmPassword)
                        .foregroundColor(Color(hex: "222F3E"))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .frame( height: 50)
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



                }
                Spacer(minLength: 210)


            }.frame(width: rect.width - 30)
        }

    }
    func signUp() {
        if self.email == self.confirmEmail && self.password == self.confirmPassword && self.username != "" {
            sessionStore.signUp(email: email, username: username, password: password)


        }
        else {
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

        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
