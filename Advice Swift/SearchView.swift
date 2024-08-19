//
//  SearchView.swift
//  Advice Swift
//
//  Created by Tony Gultom on 19/08/24.
//

import SwiftUI

struct SearchView: View {
    
    @State private var loading: Bool = true
    @State private var adviceData: AdviceList?
    
    @State private var searchText: String = ""
    
    func getInitialData() {
        RequestData.getData(requestUrl: "https://api.adviceslip.com/advice/search/friends", onSuccess: {(decodedData: AdviceList) in self.adviceData = decodedData} , onFailed:   {Error in print("error in here \(Error)")}, onLoading: {self.loading = true}, onFinally: {self.loading = false}, requestMethod: RequestMethod.get)
    }
    
    func searchData() {
        if(searchText != "") {
            print("running")
            RequestData.getData(requestUrl: "https://api.adviceslip.com/advice/search/\(searchText)", onSuccess: {(decodedData: AdviceList) in self.adviceData = decodedData} , onFailed:   {Error in print("error in here \(Error)")}, onLoading: {self.loading = true}, onFinally: {self.loading = false}, requestMethod: RequestMethod.get)
        } else {
            getInitialData()
        }
        
    }
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.grayishBlue.edgesIgnoringSafeArea(.top)
                if(loading) {
                    ProgressView()
                } else {
                    if(adviceData != nil) {
                        
                        List(adviceData!.slips) {
                            slip in
                            NavigationLink(destination: AdviceDetail(id: slip.id) ) {
                                VStack {
                                    Text("Number: #\(String(slip.id))").multilineTextAlignment(.center).foregroundStyle(.white)
                                }.padding()
                            }.navigationTitle("Search Advice")
                                .listRowBackground(Color.lightCyan)
                            
                        }.scrollContentBackground(.hidden)
                            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode:.always))
                            .toolbarBackground(
                                Color.grayishBlue,
                                for: .navigationBar)
                            .toolbarBackground(.visible)
                            .toolbarColorScheme(.dark, for: .navigationBar)
                            .onSubmit(of: .search, searchData).textInputAutocapitalization(.never).foregroundStyle(.white).autocorrectionDisabled()
                        
                    } else {
                        Text("Something wrong, please try again!")
                    }
                }
            }
            
        }.onAppear(perform: getInitialData).onDisappear(perform: {
            searchText = ""
        })
    }
}

#Preview {
    SearchView()
}
