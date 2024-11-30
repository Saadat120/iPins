//
//  SideView.swift
//  iPins
//
//  Created by Saadat Abbas on 11/29/24.
//

import SwiftUI

struct SideView: View {
   @Binding var isShowing: Bool
   @Binding var selectedTab: Int
   @State private var selectedOption: SideViewModel?
   
    var body: some View {
       ZStack{
          if isShowing{
             Rectangle()
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture { isShowing.toggle() }
             
             HStack{
                VStack(alignment: .leading, spacing: 32){
                   SideHeaderView()
                   ForEach(SideViewModel.allCases){ option in
                      Button(action: {
                         selectedOption = option
                         selectedTab =  option.rawValue
                         isShowing = false
                      }, label: { SideRowView(option: option, selectedOption: $selectedOption) })
                   }//end ForEach

                   Spacer()
                }//end VStack
                .padding()
                .frame(width: 270, alignment: .leading)
                .background(.white)
                
                Spacer()
             } //end HStack
             .transition(.move(edge: .leading))
          } //end if statement
       } //end ZStack
       .animation(.easeInOut, value: isShowing)
    } //end body
} //end struct

struct SideHeaderView: View {
   var body: some View {
      HStack{
         Image(systemName: "map")
            .imageScale(.large)
            .foregroundStyle(.white)
            .frame(width: 48, height: 48)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.vertical)
         
         Text("iPins")
            .font(.largeTitle)
      } //end Hstack
   } //end body
} //end struct

struct SideRowView: View {
   let option: SideViewModel
   @Binding var selectedOption: SideViewModel?
   
   private var isSelected: Bool{
      return selectedOption == option
   }
   var body: some View {
      VStack{
         HStack{
            Image(systemName: option.systemImageName)
               .imageScale(.large)
               .foregroundStyle(.white)
               .frame(width: 40, height: 40)
               .background(.blue)
               .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(option.title)
            Spacer()
            Image(systemName: "chevron.right")
               .padding()
         }
      } //end VStack
      .padding(.leading)
      .foregroundStyle(isSelected ? .blue : .primary)
      .frame(width: 230, height: 64)
      .background(isSelected ? .blue.opacity(0.1) : .clear)
      .clipShape(RoundedRectangle(cornerRadius: 10))
   } //end body
} //end struct

#Preview {
   SideView(isShowing: .constant(true), selectedTab: .constant(0))
}
