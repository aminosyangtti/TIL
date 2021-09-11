//
//  SignInView.swift
//  SignInView
//
//  Created by Vincio on 8/31/21.
//

import SwiftUI

struct SignInView: View {

    @ObservedObject var sessionStore = SessionStore()
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var usersViewModel: UsersViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: colors[0])
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    Image("TIL")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(50)
                        .padding(.horizontal, 80)


                    Text("Sign in to continue")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.bottom)


                    VStack {


                        TextField("Email/Username", text: $email)

                            .padding()
                            .background(Color.white)
                            .cornerRadius(20.0)
                            .frame( height: 50)
                            .padding(.bottom, 20)
                            .preferredColorScheme(.light)




                        SecureField("Password", text: $password, onCommit: signIn)

                            .padding()
                            .background(Color.white)
                            .cornerRadius(20.0)
                            .frame( height: 50)
                            .preferredColorScheme(.light)

                        NavigationLink(destination:  SignUpView().preferredColorScheme(.light))  { Text("Don't have an account?")
                            .font(.footnote)
                            .foregroundColor(.black.opacity(0.8))

                        }

                        if !email.isEmpty && !password.isEmpty {
                        Button(action: signIn){

                            Text("Let's Go!")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title3)
                        }
                        .alert(isPresented: $sessionStore.showAlert, content:  { Alert(title: Text("Error"), message: Text(sessionStore.alertMessage), dismissButton: .default(Text("OK")))})

                        .foregroundColor(Color.white)
                        .padding(30)
                        .animation(.default)
                        }



                    }
                    Spacer()
                    Spacer()
                    Spacer()

                }.frame(width: rect.width - 30)

            }.preferredColorScheme(.light)
        }

    }
    func signIn() {
        sessionStore.signIn(usersViewModel: usersViewModel, email: email, password: password)

    }

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(usersViewModel: UsersViewModel())
    }
}
