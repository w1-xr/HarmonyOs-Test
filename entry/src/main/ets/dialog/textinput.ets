@Component
struct textinputNavBar{
  @Prop rowTitle:string=""
  @Link inputText:string|number
  @Prop icon:string=""
  @Prop ena:boolean=true
  @Prop wid:boolean=false
  init(){}
  textinputChange:()=>void=this.init

    build() {
      Row() {
        Row(){
          Text(this.rowTitle)
        }
        .width(100)
        .justifyContent(FlexAlign.End)
        .margin({right:15})
        Row() {
          TextInput({
            text:this.inputText+""
          })

            .onChange((value:string)=>{
                  this.inputText=value
            })
            .backgroundColor(Color.Transparent)
            .layoutWeight(1)
            .enabled(this.ena)
          Image(this.icon)
            .visibility(this.ena==true?Visibility.Visible:Visibility.None)
        }
        .border({
          width:this.ena==true?1:0,
          color: "#b4b4b4"
        })
        .padding({right:10})
        .width(170)
      }
      .margin({right:15,top:15})
      .backgroundColor(Color.White)
      .width(270)
      .height(35)
      .alignItems(VerticalAlign.Center)
    }
}
export {textinputNavBar}



