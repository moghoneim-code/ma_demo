import SwiftUI

struct ContentView: View {
    @State var isUpdatePictureSheetVisible: Bool = true
    @Environment(\.presentationMode) var presentationMode



    var body: some View {
        VStack {
            BottomSheetView(isOpen: $isUpdatePictureSheetVisible, maxHeight: 360,title:"") {
                HStack{
                    Text("Tickets:")
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.top)
                        .font(.headline)


                    Spacer()
                }
                VStack{
                    HStack(alignment:.top,spacing: 15){
                        Image("profile")
                            
                            .resizable()
                            .clipShape(Circle())
                            .padding(.leading,30)
                            .frame(width: 60, height: 60)
                            .scaledToFill()
                        
                        
                        VStack(alignment: .leading,spacing: 10){
                            Text("Marlin Bridges")
                                .foregroundColor(Color("textColor"))
                                .font(.headline)
                            
                            Text("012344555555")
                                .foregroundColor(.black)
                                .font(.body)
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                   
//                    .frame(width: .infinity, height: 100)
                    HStack{
                        HalfCircleShape()
                            .fill(.black)
                                    .frame(width: 25, height: 25)

                        LineShape()
                            .stroke(.black, style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .frame(height: 1)
                            .padding(.leading,-20)
                        MirroredHalfCircleShape()
                            .fill(.black)
                                    .frame(width: 25, height: 25)
                                    
                    }.padding(.trailing,-25)
                    HStack(alignment:.top,spacing: 15){
                       
                        
                        VStack(alignment: .leading,spacing: 10){
                            HStack{
                                Text("Ticket Type :")
                                    .foregroundColor(Color("textColor"))
                                    .font(.headline)

                                Text("Business Seat")
                                    .foregroundColor(.black)
                                    .font(.body)
                            }
                            HStack{
                                Text("Seat :")
                                    .foregroundColor(Color("textColor"))
                                    .font(.headline)
                                
                                Text("Black 12")
                                    .foregroundColor(.black)
                                    .font(.body)
                            }
                                
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    
                    
                }    .background(Color("bgColor"))
                
                

                .padding()
                .padding(.bottom)
               
            }.edgesIgnoringSafeArea(.all)
                .onTapGesture {
                            // Dismiss the bottom sheet when tapped outside
                            self.presentationMode.wrappedValue.dismiss()
                        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
fileprivate enum Constants {
      static let radius: CGFloat = 16
      static let indicatorHeight: CGFloat = 3
      static let indicatorWidth: CGFloat = 55
      static let snapRatio: CGFloat = 0.25
      static let minHeightRatio: CGFloat = 0.3
  }
struct BottomSheetView<Content: View>: View {
      @Binding var isOpen: Bool
      let maxHeight: CGFloat
      let minHeight: CGFloat
      let content: Content
      @State var animted  = false
      var titel: String

      @GestureState private var translation: CGFloat = 0

      private var offset: CGFloat {
          isOpen ? 0 : maxHeight - minHeight
      }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.gray)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
            ).onTapGesture {
                withAnimation(.linear) {
                    self.isOpen.toggle()
                }
            }
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat,title:String,@ViewBuilder content: () -> Content) {
          self.minHeight = maxHeight * Constants.minHeightRatio
          self.maxHeight = maxHeight
          self.titel = title
          self.content = content()
          self._isOpen = isOpen
         
      }

      var body: some View {
          GeometryReader {
              geometry in
              VStack(spacing: 0) {
                  //                  self.indicator.padding()
                  HStack{
                      HStack{
                          Spacer()
                          Divider()
                              .frame(width: 50,height: 3)
                              .background(.white)
                              .padding(.top,8)
                              .padding(.bottom,8)
                              .cornerRadius(12)
                          Spacer()

                      }
                  // Spacer()
                  Divider()
                      .padding()
                  }.frame(height: 40)
                      .background(.gray)
                      
                  self.content
                  
              }
              .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
              .background(Color.black)
              .cornerRadius(Constants.radius)
              .frame(height: geometry.size.height, alignment: .bottom)
              .offset(y:max(self.offset + self.translation, 0))
              .gesture(DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.height
                       }.onEnded { value in
                        let snapDistance = self.maxHeight * Constants.snapRatio
                        guard abs(value.translation.height) > snapDistance else { return}
                        self.isOpen = value.translation.height < 0
                       })
          }
      }
  }
struct HalfCircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Start at the center of the left edge
        let center = CGPoint(x: 0, y: rect.height / 2)
        path.move(to: center)

        // Add a semi-circle by adding an arc from -90 to 90 degrees
        path.addArc(center: center, radius: rect.height / 2, startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: false)

        return path
   
    }
}
struct MirroredHalfCircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = HalfCircleShape().path(in: rect)

        // Calculate the mirror transformation
        let mirror = CGAffineTransform(scaleX: -1, y: 1)
        
        // Apply the transformation to mirror the path horizontally
        path = path.applying(mirror)
        
        return path
    }
}
struct LineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
