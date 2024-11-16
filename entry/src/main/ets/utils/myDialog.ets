@Extend(Button) function globalButton(){
  .fontColor(Color.White)
  .backgroundColor("#0f6ab1")
  .height(30)
  .margin({right:25})
  .borderRadius(5)
}
@CustomDialog
struct  MyDialog{
  clazzId:number=-1
  clazzName:string=""
  startTime:string=""
  endTime:string=""
  customDialogCon:CustomDialogController//1
  title:string="默认标题";
  cancleWord:string="取消"//3确定和取消按钮
  confirmWord:string="确认"
  @BuilderParam contentArea:()=>void = this.init //4.文本内容
  cancleFn:()=>void=this.defautCancleFn
  confirmFn:()=>void=this.defautConfirmFn

  @Builder
  init() {

  }

  defautConfirmFn(){
    console.log("点击了默认确定函数")
  }
  defautCancleFn(){
    console.log("点击了默认取消函数")
  }

  build() {
    Column(){
      //1.标题区
      Row(){
        Text(this.title)
          .fontColor(Color.White)
          .fontSize(15)
          .fontWeight(900)
          .textAlign(TextAlign.Center)
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)
      .height(50)
      .backgroundColor("#0f6ab1")
      //内容区
     Column(){
        this.contentArea()
     }
     .width(620)
     .padding({top:30,bottom:30,right:20})
     //3.按钮区
      Row(){
        Button(this.confirmWord, {type: ButtonType.Normal})
          .globalButton()
          .onClick(()=>{
            this.customDialogCon.close()
            this.confirmFn()
          })
        Button(this.cancleWord, {type: ButtonType.Normal})
          .globalButton()
          .onClick(()=>{
            this.customDialogCon.close()
            this.cancleFn()
          })
      }
      .margin({bottom:50})
      .width(620)
      .justifyContent(FlexAlign.Center)



    }
    .width(620)

  }
}
export {MyDialog}