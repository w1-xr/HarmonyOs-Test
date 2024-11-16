import { addrc, Daily } from '../api/daily'
import { smallCCTitle, smallKQTitle, smallQJTitle, smallTitle } from '../constants'
import { addrcRequestClass, dailyCCListClass, dailyListClass, dailyRequestClass } from '../models'
import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { newrightTop } from './newrightTop'
import { promptAction } from '@kit.ArkUI'
import { textinputNavBar } from '../dialog/textinput'

@Styles  function borderr(){
  .border({
    width:1,
    color:"#c0c0c0"
  })
  .height(33)
}
@Extend(Text) function textGlobalClass(){
  .fontSize(14)
  .fontColor("#616161")
  .width(89)
  .height(50)
  .textAlign(TextAlign.Center)
}
@Component
struct dailyNavBar{
  @Prop curIndex:number
  @Prop newState:boolean
  @Prop curIndextwo:number
  @State textt:string=""
  @State dailyParperContent:string=""
  @State dialogTitle:string=""
  @State date:string=new Date().toLocaleDateString()
  @State dateP:string=""
  @State pageIndex:number=1;//当前的页数；
  @State pageCount:number=0;//总页数；
  pageSize:number=8;//一页显示多少条数据；
  smallTitle:string[]=smallTitle
  @State dailyData:dailyListClass[]=[]
  @StorageLink("userId") userId:number=-1
  @StorageLink("userRole") userRole:string=""
  @StorageLink("userName") userName:string=""

  @Builder bottomTip(){
    Column(){
      if(this.pageIndex<=this.pageCount){
        //加载的图标；
        LoadingIcon()
      }
      Text(this.pageIndex<=this.pageCount ? "加载中" : "没有更多了~~~~~")
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
  }
  //dialog
  private customDialogCon:CustomDialogController=new CustomDialogController({
    builder:MyDialog({
      title:this.dialogTitle,
      contentArea:()=>{this.curArea()},
      confirmFn:()=>{this.curConfirmFn()}
    }),
    cornerRadius:0,
    width:620,
    offset:{
      dx:100,
      dy:20
    }
  })
  @Builder curArea(){
    Column(){
      Row(){
        Row(){
          Text("姓名:")

            Text(this.userName)
              .margin({left:10})
        }
        .margin({right:50,top:15,left:70})
        .backgroundColor(Color.White)
        .width(170)
        .height(35)
        .alignItems(VerticalAlign.Center)


        Row(){
          textinputNavBar({
            rowTitle:"日期:",
            inputText:this.dateP,
            icon:"",
          })
          Image("/images/data.png")
            .width(20)
            .margin({left:-30,top:10})
            .onClick(()=>{
              DatePickerDialog.show({
                onDateAccept:(value)=>{
                  this.dateP=value.toLocaleDateString().split('/').map(date => date.padStart(2, '0')).join('-');
                }
              })
            })
        }

      }
      .margin({left:-80})
      Row(){
        Text("内容：")
        Row(){
          TextArea({
            text:$$this.dailyParperContent
          })
            .width(460)
            .height(45)
            .backgroundColor(Color.Transparent)
            .onChange((value:string)=>{
              this.dailyParperContent=value
              console.log(this.dailyParperContent)
            })
        }
        .margin({top:20})
        .border({
          width:1,
          color:"#b4b4b4"
        })

      }
    }
  }
  async curConfirmFn(){
      await this.addrc()
      promptAction.showToast({
        message:"添加成功"
      })

  }
  async showDaily(){
    //日常正文
    let dataset:dailyRequestClass={
      dailyParperUserName:this.userRole=="管理员"?this.textt:this.userName,
      pageSize:this.pageSize,
      pageIndex:this.pageIndex
    }
    let res= await Daily(dataset)
    this.pageCount=res.pageCount
    this.dailyData=this.dailyData.concat(res.dailyList)
    this.pageIndex++
  }
async addrc(){
    let dataset:dailyListClass={
      dailyParperDate:this.dateP,
      dailyParperContent:this.dailyParperContent,
      dailyParperUserName:this.userId
    }

  let res=await addrc(dataset)
  dataset.dailyParperUserName = this.userName
  this.dailyData.unshift(dataset)
}
  async aboutToAppear(): Promise<void> {
    await this.showDaily()
  }
  build() {
  Column(){
     //标题
    Stack({alignContent:Alignment.TopStart}){
      newrightTop({
        titleName:"日常"
      })
      Row(){
        TextInput({
          placeholder:"请输入姓名",
          text:$$this.textt
        })
          .width(150)
          .placeholderColor("#c0c0c0")
          .backgroundColor(Color.Transparent)
          .borderRadius(0)
          .borderr()
          .fontSize(13)
          .margin({left:20,right:10})
        Text("搜索")
          .backgroundColor("#0f6ab1")
          .fontColor(Color.White)
          .padding({left:15,right:15,top:5,bottom:5})
          .margin({left:15})
          .onClick(async ()=>{
            this.pageIndex=1
            this.dailyData=[]
            await this.showDaily()
          })
        Row(){
          Text(this.date.replaceAll("/","-"))
            .margin({left:290,right:15})
          Image("/images/data.png")
            .width(20)
            .onClick(()=>{
                DatePickerDialog.show({
                  selected:new Date(),
                  start:new Date("1979-1-1"),
                  end:new Date("2030-1-1"),
                  lunar:false,
                  onDateAccept:(value:Date)=>{
                    this.date=value.toLocaleDateString().replaceAll("/","-")

                  }
                })
            })
          if(this.newState){
            Text("写日报")
              .fontColor(Color.Blue)
              .margin({left:15})
              .onClick(async ()=>{
                this.dialogTitle="日报"
                this.customDialogCon.open()
              })
          }
        }
        .margin({left:30})
      }
      .position({left:60,top:15})//木4

    }

    //正文内容
    Column(){
      //xiao标题
      Row(){
          ForEach(this.smallTitle,(item:string)=>{
            Row(){
              Text(item)
                .fontWeight(600)
                .textAlign(TextAlign.Center)
            }
            .justifyContent(FlexAlign.Center)
            .width(89)

          })
      }
      .width("100%")
      .height("11%")
      .padding({top:15,bottom:15})
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      //接口内容
      List(){
        ListItem(){
          Column(){
           ForEach(this.dailyData,(item:dailyListClass)=>{
             Row(){
               Text(item.dailyParperUserName+"")
                 .textGlobalClass()
               Text(item.dailyParperContent)
                 .textGlobalClass()
               Text(item.dailyParperDate)
                 .textGlobalClass()
             }
             .height(50)
             .width("100%")
             .padding({bottom:20})
             .justifyContent(FlexAlign.SpaceBetween)
           })
          }
        }
        ListItem(){
          if (this.dailyData.length >= this.pageSize)
          Row(){
            this.bottomTip()
          }
          .width("100%")
        }

      }
      .edgeEffect(EdgeEffect.Fade)
      .height("calc(100% - 60vp)")
      .onReachEnd(async ()=>{//触底；
        if(this.pageIndex<=this.pageCount){
          setTimeout(async ()=>{
            await this.showDaily()
          },500)

        }
      })
      .listDirection(Axis.Vertical)
      .backgroundColor(Color.White)
      .width("100%")

    }
    .width("95%")
    .height("calc(100% - 80vp)")
    .backgroundColor(Color.White)
    .position({top:65,left:20})
    .padding({left:10,right:10})
  }
  .width("100%")
  .height("100%")
  .visibility(this.curIndex==1&&this.curIndextwo==-1 ?Visibility.Visible:Visibility.None)
  .backgroundColor("#f5f9fa")
  }
}
export {dailyNavBar}