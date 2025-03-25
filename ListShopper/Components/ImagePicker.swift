//
//  ProfileImagePicker.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage
            }
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary  
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


#Preview {
    ImagePicker(image: .constant(UIImage()))
}
