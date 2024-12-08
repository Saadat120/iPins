//
//  RegisterView.swift
//  iPins
//
//  Created by Saadat Abbas on 12/7/24.
//

import SwiftUI

struct RegisterView: View {
  @ObservedObject var userSessionModel: UserSessionModel
  
  @State private var username: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  
  @State var visible = false
  @State var confirmVisible = false
  
  var body: some View {
    VStack(alignment: .center, spacing: 20){
      Text("Register")
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
      
      //Password
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
      
      //Password Confirmation
      HStack(spacing: 15){
        VStack{
          if confirmVisible{
            TextField("Confirm Password", text: $confirmPassword)
          }
          else{
            SecureField("Confirm Password", text: $confirmPassword)
          }
        }
        
        //make password visible or not with eye button
        Button(action: { self.confirmVisible.toggle() },
               label:{ Image(systemName: self.confirmVisible ? "eye.slash.fill" : "eye.fill")
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
          userSessionModel.register(username: username, password: password, confirmPassword: confirmPassword)
        },
        label: {
          Text("Register")
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
    } //end Vstack
    .padding()
    
  }
}

#Preview {
  RegisterView(userSessionModel: UserSessionModel())
}
