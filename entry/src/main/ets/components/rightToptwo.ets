
@Component
struct rightToptwo{
  @Prop detail:string=""
  @Prop className:string

  @Styles borderr(){
    .border({
      width:1,
      color:"#c0c0c0"
    })
    .height(33)
  }
  build() {
    Column(){
      Row(){
        Text(this.className)
          .padding({left:10,right:10})
          .border({
            width:{left:3},
            color:"#0f6ab0"
          })
        Text(this.detail)
        // TextInput({
        //   placeholder:this.place,
        //   text:this.textt
        // })
        //   .width(150)
        //   .placeholderColor("#c0c0c0")
        //   .backgroundColor(Color.Transparent)
        //   .borderRadius(0)
        //   .borderr()
        //   .fontSize(13)
        //   .margin({left:20,right:10})

        // Text("搜索")
        //   .backgroundColor("#0f6ab1")
        //   .fontColor(Color.White)
        //   .padding({left:15,right:15,top:5,bottom:5})
        //   .margin({left:15})
        // Image("/images/add.png")
        //   .width(20)
        //   .margin({left:80})
      }
      .width("95%")
      .height(43)
      .padding({left:25,right:25,top:5,bottom:5})
      .margin({top:10})
      .backgroundColor(Color.White)
    }


  }
}
export {rightToptwo}