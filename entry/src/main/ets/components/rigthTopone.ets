
@Component
struct rightTopone{
  @Prop className:string
  @Link vv:Visibility
  @Link title:string
  @Prop place:string
  @State textt:string=""
  @State start:string="开始时间"
  @State end:string="结束时间"
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
        TextInput({
          placeholder:this.place,
          text:$$this.textt
        })
          .width(150)
          .placeholderColor("#c0c0c0")
          .backgroundColor(Color.Transparent)
          .borderRadius(0)
          .borderr()
          .fontSize(13)
          .margin({left:20,right:10})
        Row(){
          Text(this.start)
            .fontSize(14)
            .fontColor("#c0c0c0")
          Image("/images/data.png")
            .width(18)
            .margin({left:23})
            .onClick(()=>{

            })
        }
        .borderr()
        .width(120)
        .padding({left:10})

        Row(){}
        .width(20)
        .height(2)
        .backgroundColor("#c0c0c0")
        .margin({left:10,right:10})
        Row(){
          Text(this.end)
            .fontSize(14)
            .fontColor("#c0c0c0")
          Image("/images/data.png")
            .width(18)
            .margin({left:23})
        }
        .borderr()
        .padding({left:10})
        .width(120)
        Text("搜索")
          .backgroundColor("#0f6ab1")
          .fontColor(Color.White)
          .padding({left:15,right:15,top:5,bottom:5})
          .margin({left:15})
          .onClick(()=>{
            AppStorage.setOrCreate("search",this.textt)
          })

      }
      .width("95%")
      .height(43)
      .padding({left:25,right:25,top:5,bottom:5})
      .margin({top:10})
      .backgroundColor(Color.White)
    }


  }
}
export {rightTopone}