//
//  SignInView.swift
//  SignInView
//
//  Created by Vincio on 8/31/21.
//

import SwiftUI

struct SignInView: View {
    @State private var show = false
    @State private var move = false
    @State private var isAFocused: Bool? = true
    @State private var isBFocused: Bool? = false
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack{
                GeometryReader { geometry in
                    if show {
                        Circle()
                                .overlay(VStack {
                                    Text("Password")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .font(.largeTitle)


                                    CustomTextField(text: $password, nextResponder: .constant(nil), isResponder: $isBFocused, isSecured: true, keyboard: .default)

                                        .foregroundColor(Color(hex: "222F3E"))
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(20.0)
                                        .frame(width: 350, height: 50, alignment: .center)


                                }.opacity(move ? 1 : 0)
                                            .padding()
                                            .scaleEffect(isBFocused! ? 0.9 : 0.5))

                            .onTapGesture {
                                self.isBFocused = true
                                self.isAFocused = false
                            }

                            .padding()
                            .foregroundColor(Color(hex: color[3]))
                            .transition(.asymmetric(insertion: .opacity, removal: .offset(x: 0, y: 600)))
                            .offset(x: 0, y: !move ? 0 : geometry.size.height * 0.25)
                            .scaleEffect(isBFocused! ? 0.8 : 0.6)
                    Circle()
                            .overlay(VStack {
                                Text("Email")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .font(.largeTitle)



                                CustomTextField(text: $email, nextResponder: $isBFocused, isResponder: $isAFocused, keyboard: .default)
                                    .foregroundColor(Color(hex: "222F3E"))
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(20.0)
                                    .frame(width: 350, height: 50, alignment: .center)


                            }
                                        .opacity(move ? 1 : 0)
                                        .padding()
                                        .scaleEffect(isAFocused! ? 0.9 : 0.5))

                            .onTapGesture {
                                self.isAFocused = true
                                self.isBFocused = false
                            }

                        .padding()
                        .foregroundColor(Color(hex: color[0]))
                        .transition(.asymmetric(insertion: .opacity, removal: .offset(x: 0, y: -600)))
                        .offset(x: 0, y: !move ? 0 : -geometry.size.height * 0.25)
                        .scaleEffect(isAFocused! ? 0.8 : 0.6)
                        


                    }

                }.overlay(
                    VStack {
                        if email.isEmpty && password.isEmpty {
                        Button(action: {}){

                            Text("Let's Go!")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title3)


                        }
                        .foregroundColor(Color(hex: "222F3E"))
                        .padding(30)
                        }
                    },
                    alignment: .bottom)

                .animation(.spring(response: 0.8, dampingFraction: 1, blendDuration: 0.1))


        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                show.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                move.toggle()

            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                show.toggle()
//            }
        }
        .background(Color(hex: "F3F4F6").ignoresSafeArea())

    }

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
