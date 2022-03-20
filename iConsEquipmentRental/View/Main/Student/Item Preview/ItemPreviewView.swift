//
//  ItemPreviewView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct ItemPreviewView: View {
    
    @EnvironmentObject var studentHomeVM: StudentHomeViewModel
    @EnvironmentObject var rootVM: RootViewModel
    @StateObject var rentalVM = RentalViewModel()
    
    
    let item: Item
    
    // USED FOR CUSTOM BACK BUTTON
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // BACK BUTTON VIEW USED IN BODY
    var btnBack: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()}) {
            Image("backArrow")
                .resizable()
                .frame(width: 20, height: 20)
                .aspectRatio(contentMode: .fit)
        }
    }
    
    var body: some View {
        ZStack {
            
            // CUSTOM BACKGROUND
            Image("StudentItemPreviewBackground")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.title)
                    .foregroundColor(Color("ItemPreviewTitle"))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                // RETURN DATE TEXT
                HStack  {
                    Text("Return to the iCons")
                        .foregroundColor(Color("TextGray"))
                    Text("ILC Location by 11pm")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ItemPreviewTitle"))
                }
                
                    .padding()
                
                // ITEM IMAGE
                item.image
                    .resizable()
                    .frame(width: 180, height: 180)
                    .offset(x: 100)
                
                Spacer()
                
                Toggle(isOn: $rentalVM.showDelivery, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Delivery Option")
                })
                .padding(.horizontal, 25)
                .padding(.vertical, 20)
                .toggleStyle(SwitchToggleStyle(tint: Color("ButtonBlue")))
                
                // DELIVERY OPTION
                if rentalVM.showDelivery {
                    Text("Deliver Intructions (ILC Only)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ItemPreviewTitle"))
                        .padding(.horizontal, 25)
                        .padding(.vertical, 20)
                    TextField("Room 235...", text: $rentalVM.deliveryLocation)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color("ButtonGray"), lineWidth: 2)
                                .frame(width: UIScreen.main.bounds.maxX - 40, height: 50, alignment: .center)
                        )
                        .padding(.horizontal, 40)
                }
                
                // QUANTITY OPTION
                HStack {
                    Text("Quantity:")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ItemPreviewTitle"))
                    Group {
                        Button(action: {
                            rentalVM.quantity -= 1
                        }, label: {
                            Image(systemName: "minus")
                                .resizable()
                                .frame(width: 20, height: 2.5)
                        })
                            .padding(.horizontal)
                        Text(String(rentalVM.quantity))
                            .overlay(
                                Circle()
                                    .stroke(Color("TextGray"))
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 30)
                            )
                        Button(action: {
                            rentalVM.quantity += 1
                        }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                        })
                            .padding(.horizontal)
                    }
                    .offset(x: 40)
                }
                .padding(.vertical, 40)
                .padding(.horizontal, 25)
                
                HStack {
                    Text("I here by consent to the ")
                        .font(.caption)
                        .foregroundColor(Color("TextGray")) +
                    Text("Terms and Conditions")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("ItemPreviewTitle")) +
                    Text("\nof the Integrated Constables")
                        .font(.caption)
                        .foregroundColor(Color("TextGray"))
                    Button(action: {
                        rentalVM.toggleCheckbox()
                    }, label: {
                        if rentalVM.checkbox {
                            Image("emptyCheckmark")
                                .resizable()
                                .frame(width: 25, height: 25)
                        } else {
                            Image("filledCheckmark")
                                .resizable() 
                                .frame(width: 25, height: 25)
                        }
                    })
                        .offset(x: 35)
                }
                    .padding(.horizontal, 25)
                
                // RENT BUTTON
                RentalButtonView(item: item)
                    .onTapGesture(perform: {
                        presentationMode.wrappedValue.dismiss()
                    })
                
            }
        }
        .environmentObject(rentalVM)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}


struct Loader: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
    
}



