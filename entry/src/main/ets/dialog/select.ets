@Component
struct selectNavBar{
@Prop rowTitle:string
@Prop selectArr:SelectOption[]
  @Link valuee:string
  @Link selected:number
@Prop ena:boolean=true
  build() {
    Row() {
      Row(){
        Text(this.rowTitle)
      }
      .width(100)
      .justifyContent(FlexAlign.End)
      .margin({right:15})
      Row() {
        Row(){
          Select(this.selectArr)
            .value(this.selectArr[this.selected] ? this.selectArr[this.selected].value : '')
            .selected(this.selected)
            .backgroundColor(Color.Transparent)
            .layoutWeight(1)
            .height(35)
            .onSelect((index:number,value:string)=>{
              this.selected = index;
            })
            .enabled(this.ena)
        }
        .layoutWeight(1)
      }

      .padding({right:10})
      .width(170)
      .border({
        width:this.ena==true?1:0,
        color: "#b4b4b4"
      })
    }
    .margin({right:15,top:15,})
    .backgroundColor(Color.White)
    .width(270)
    .height(35)
    .alignItems(VerticalAlign.Center)
  }


}
export {selectNavBar}



