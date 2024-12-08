//
//  LoginView.swift
//  iPins
//
//  Created by Saadat Abbas on 12/7/24.
//

import SwiftUI

struct LoginView: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var userSessionModel: UserSessionModel
  
  @State private var username: String = ""
  @State private var password: String = ""
  @State private var visible: Bool = false
  
  var body: some View {
    NavigationView{
      VStack(alignment: .center, spacing: 20){
        
        Spacer()
        Text("Login")
          .font(.title)
          .fontWeight(.bold)
          .padding(.top, 35)
        
        TextField("Enter Username", text: $username)
          .autocapitalization(.none)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 4)
              .stroke(lineWidth: 2)
          )
          .foregroundColor(.black)
          .padding(.horizontal, 25)
        
        HStack(spacing: 15){
          VStack{
            if visible{
              TextField("Enter Password", text: $password)
            }
            else{
              SecureField("Enter Password", text: $password)
            }
          }
          
          //make password visible or not with eye button
          Button(action: { self.visible.toggle() },
                 label:{ Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
          })//end Button
        } //end HStack
        .autocapitalization(.none)
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 4)
            .stroke(lineWidth: 2)
        )
        .foregroundColor(.black)
        .padding(.horizontal, 25)
        
        Button(
          action: {
            userSessionModel.login(username: username, password: password)
            if userSessionModel.loggedIn{ dismiss() } // Close the sheet on successful login
          },
          label: {
            Text("Login")
              .foregroundColor(.white)
              .padding(.vertical)
              .frame(width: UIScreen.main.bounds.width/3)
          })
        .background(Color(.blue))
        .cornerRadius(10)
        .padding(.top, 10)
        
        
        if userSessionModel.alert {
          Text(userSessionModel.error)
            .foregroundColor(.red)
            .padding()
        }
        Spacer()
        NavigationLink(
          destination: RegisterView(userSessionModel: userSessionModel)){
          Text("Don't Have An Account? Register Here.")
            .foregroundColor(.blue)
            .padding()
        }
      } //end Vstack
      .padding()
    }
  } //end body
} //end struct

#Preview {
  LoginView()
    .environmentObject(UserSessionModel())
}
