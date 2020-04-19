//
//  MainContainer.swift
//  SwiftUITodo
//
//  Created by Ethan Hess on 4/13/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

struct MainContainer: View {
    //properties (OO is for more comples properties that will be shared between multiple views)
    @ObservedObject var choreDB = ChoreDatabase()
    
    //State, local simpler properties
    @State var newChore : String = ""
    @State var alertPresented = false
    
    @State private var imagePickerPopped = false
    @State private var chosenImage : Image? = nil
    
    
    //UI
    var textFieldHeader : some View {
        HStack {
            TextField("Enter in a new task", text: self.$newChore).padding().background(Color.white).cornerRadius(5).border(Color.black, width: 1)
            Button(action: self.addChore, label: {
                Text("Submit").padding().background(Color.black).foregroundColor(.white)
                }).cornerRadius(5)
            Button(action: self.toggleImagePicker, label: {
                Text("Image").padding().background(Color.black).foregroundColor(.blue)
                }).cornerRadius(5).sheet(isPresented: self.$imagePickerPopped){
                    ChosenImageDisplayView(isShowingImagePicker: self.$imagePickerPopped, displayedImage: self.$chosenImage)
                }
        }
    }

    var chosenImageContainer : some View {
        HStack {
            chosenImage?.resizable().aspectRatio(contentMode: .fit)
        }
    }
    
    //Main body
    var body: some View {
        NavigationView {
            VStack {
                textFieldHeader.padding()
                chosenImageContainer.padding()
                //animationContainer.padding()
                List {
                    ForEach(self.choreDB.chores) { chore in
                        Text(chore.choreBody)
                    }.onMove(perform: self.move)
                        .onDelete(perform: self.delete)
                }.navigationBarTitle("TODO")
                .navigationBarItems(trailing: EditButton())
            }.alert(isPresented: $alertPresented) { () -> Alert in
                return Alert(title: Text("Please enter text"), message: Text(""), dismissButton: .default(Text("Roger that")))
            }
        }
    }
    
    //List functions
    
    func move(from source : IndexSet, to destination : Int) {
        choreDB.chores.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets : IndexSet) {
        choreDB.chores.remove(atOffsets: offsets)
    }

    //TODO check TF
    func addChore() {
        if self.newChore == "" {
            self.alertPresented = true
            return
        }
        let randomUID = UUID().uuidString
        let theID = String(randomUID)
        let toAppend = Chore(id: theID, choreBody: self.newChore, imageData: nil)
        choreDB.chores.append(toAppend)
        self.newChore = ""
    }
    
    func toggleImagePicker() {
        self.imagePickerPopped = true
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainer()
    }
}


//TODO move to own file once we add more subviews
struct ChosenImageDisplayView: View {
    
    @Binding var isShowingImagePicker : Bool
    @Binding var displayedImage : Image?
    
    var body: some View {
        ImagePicker(visible: $isShowingImagePicker, chosenImage: $displayedImage)
    }
}

struct ChosenImageDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ChosenImageDisplayView(isShowingImagePicker: .constant(false), displayedImage: .constant(Image("")))
    }
}
