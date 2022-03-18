//
//  FlowerView.swift
//  Flower-iOS
//
//  Created by GoEun Jeong on 2022/03/16.
//

import SwiftUI
import Kingfisher

struct FlowerPhotoView: View {
    @ObservedObject var viewModel = FlowerPhotoViewModel()
    
    @State private var isShowSheet = false
    @State private var isShowPhotoLibrary = false
    @State private var isShowCamera = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                HStack {
                    SearchBar(text: $viewModel.search, placeholder: "꽃명을 입력해주세요.")
                    
                    Image(systemName: "camera")
                        .onTapGesture {
                            self.isShowSheet = true
                        }
                }
                
                ScrollView {
                    ForEach(viewModel.flowers, id: \.no) { flower in
                        NavigationLink(destination: LazyView(FlowerDetailView(no: flower.no))) {
                            FlowerRow(flower: flower)
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            .navigationTitle("꽃 검색")
            .actionSheet(isPresented: $isShowSheet) {
                ActionSheet(
                    title: Text("사진을 가져올 곳을 골라주세요."),
                    buttons: [
                        .default(Text("앨범")) {
                            self.isShowPhotoLibrary = true
                        },
                        .default(Text("카메라")) {
                            self.isShowCamera = true
                        }
                    ]
                )
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
            }
            .sheet(isPresented: $isShowCamera) {
                ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct FlowerPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerPhotoView()
    }
}

struct FlowerRow: View {
    let flower: Flower
    
    var body: some View {
        HStack(alignment: .top) {
            KFImage(URL(string: flower.imageUrls.first!))
                .resizable()
                .frame(width: UIFrame.width / 4.75, height: UIFrame.width / 4.75)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(flower.name)
                    .padding(.vertical, 10)
                    .foregroundColor(Color("Black"))
                
                Text("꽃말: \(flower.flowerLanguage)")
                    .padding(.vertical, 2.5)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }.padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}
