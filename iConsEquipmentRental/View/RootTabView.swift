//
//  ContentView.swift
//  iCons
//
//  Created by William Little on 2022-02-21.
//

import SwiftUI

struct RootTabView: View {
    
    @StateObject var rootVM = RootViewModel()
    @StateObject var onboardingVM = OnboardingViewModel()
    @StateObject var studentHomeVM = StudentHomeViewModel()
    @StateObject var profileVM = ProfileViewModel()
    @StateObject var iConVM = iConViewModel()

    
    var body: some View {
        VStack {
            if onboardingVM.loading || rootVM.loading {
                ProgressView()
            } else if onboardingVM.signedIn == false {
                OnboardingView()
            } else {
                if onboardingVM.student {
                    
                    // STUDENT USER INTERFACE
                    NavigationView {
                        
                        ZStack(alignment: .top) {
                            
                            // VIEW DEPENDENT ON SELECTED TAB
                            switch rootVM.selectedTab {
                                case 0:
                                    StudentHomeView()
                                case 1:
                                    StudentSearchView()
                                case 2:
                                    StudentProfileView()
                                default:
                                    StudentHomeView()
                            }
                            
                            BottomTabView()
                        }
                        .onAppear(perform: {
                            rootVM.retrieveUserInfo()
                        })
                    }
                    
                } else {
                    
                    // ICON USER INTERFACE
                    NavigationView {
                        
                        ZStack(alignment: .top) {
                            
                            // VIEW DEPENDENT ON SELECTED TAB
                            switch rootVM.selectedTab {
                            case 0:
                                iConHomeView()
                            case 1:
                                iConAddView()
                            case 2:
                                iConProfileView()
                            default:
                                iConHomeView()
                            }
                            
                            BottomTabView()
                        }
                    }
                    .onAppear(perform: {
                        rootVM.retreieveiConInfo()
                    })
                }
            }
        }
            .environmentObject(studentHomeVM)
            .environmentObject(onboardingVM)
            .environmentObject(rootVM)
            .environmentObject(profileVM)
            .environmentObject(iConVM)
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
