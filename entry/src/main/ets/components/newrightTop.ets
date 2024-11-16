@Component
struct newrightTop{
@Prop titleName:string
  build() {

      Row(){
        Text(this.titleName)
          .padding({left:10,right:10})
          .border({

            width:{left:3},
            color:"#0f6ab0"
          })
      }
      .width("95%")
      .height(43)
      .padding({left:25,right:25,top:5,bottom:5})
      .margin({top:10})
      .backgroundColor(Color.White)

  }
}
export {newrightTop}