//
//  ImagePickerAuxiliary.swift
//  SwiftUITodo
//
//  Created by Ethan Hess on 4/17/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    //typealias UIViewControllerType =
    
    //From Apple
    
//    Use a binding to create a two-way connection between a view and its underlying model. For example, you can create a binding between a Toggle and a Bool property of a State. Interacting with the toggle control changes the value of the Bool, and mutating the value of the Bool causes the toggle to update its presented state.
    
    @Binding var visible : Bool
    @Binding var chosenImage : Image?
    
    func updateUIViewController(_ uiViewController:  UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        //TODO imp.
    }
    
    //$ is the wrapper
    func makeCoordinator() -> ImagePickerHelper {
        return ImagePickerHelper(visible: $visible, chosenImage: $chosenImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
}

class ImagePickerHelper : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var visible : Bool
    @Binding var chosenImage : Image?
    
    init(visible : Binding<Bool>, chosenImage: Binding<Image?>) {
        _visible = visible
        _chosenImage = chosenImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        visible = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosen = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        chosenImage = Image(uiImage: chosen)
        visible = false
    }
}
