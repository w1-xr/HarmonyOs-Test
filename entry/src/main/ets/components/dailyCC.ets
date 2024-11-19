import { addcc, Daily, DailyCC } from '../api/daily'
import { smallCCTitle, smallKQTitle, smallQJTitle, smallTitle } from '../constants'
import { dailyCCListClass, dailyCCRequestClass, dailyListClass, dailyRequestClass } from '../models'
import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { newrightTop } from './newrightTop'
import { promptAction } from '@kit.ArkUI'
import { textinputNavBar } from '../dialog/textinput'
import { DateUtils } from '../utils/padStart'

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
struct dailyCCNavBar{
  @Prop curIndex:number
  @State dialogTitle:string=""
  @Prop newState:boolean=true
  @Prop curIndextwo:number
  @State textt:number=1
  @State date:string=new Date().toLocaleDateString()
  @State pageIndex:number=1;//当前的页数；
  @State pageCount:number=0;//总页数；
  pageSize:number=8;//一页显示多少条数据；
  smallCCTitle:string[]=smallCCTitle
  @State dailyCCData:dailyCCListClass[]=[]
  @State ccName:string=""
  @State businessDate:string=""
  @State address:string=""
  @State businessDateEnd:string=""
  @State tool:string=""
  @State duration:number | string=""
  @StorageLink("userId") userId:number|string=-1
  @StorageLink("userName") userName:string=""
  @StorageLink("userRole") userRole:string=""
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
  async showDailyCC(){
    //出差正文
    let dataset:dailyCCRequestClass={
      userId:this.userId as number,
      pageSize:this.pageSize,
      pageIndex:this.pageIndex,
      userName:this.userName
    }
    let res= await DailyCC(dataset)
    this.pageCount=res.pageCount
    this.dailyCCData=this.dailyCCData.concat(res.dailyList)
    this.pageIndex++
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
        Stack({alignContent:Alignment.TopEnd}){
          textinputNavBar({
            rowTitle:"开始时间:",
            inputText:this.businessDate,
            icon:""
          })
          Image("/images/data.png")
            .width(20)
            .position({top:23,left:255})
            .onClick(()=>{
              DatePickerDialog.show({
                onDateAccept:(value)=>{
                  this.businessDate=DateUtils.padStart(value.toLocaleDateString())
                  this.duration= DateUtils.getDays(this.businessDate,this.businessDateEnd)
                }
              })
            })
        }

      }
      Row(){
        textinputNavBar({
          rowTitle:"出差地点:",
          inputText:this.address,
          icon:""
        })
        Stack({alignContent:Alignment.TopEnd}){
          textinputNavBar({
            rowTitle:"返回时间:",
            inputText:this.businessDateEnd,
            icon:""
          })
          Image("/images/data.png")
            .width(20)
            .position({top:23,left:255})
            .onClick(()=>{
              DatePickerDialog.show({
                onDateAccept:(value)=>{
                  this.businessDateEnd=value.toLocaleDateString().split('/').map(date => date.padStart(2, '0')).join('-')
                  this.duration= DateUtils.getDays(this.businessDate,this.businessDateEnd)
                }
              })
            })
        }
      }
      Row(){
        textinputNavBar({
          rowTitle:"交通工具:",
          inputText:this.tool,
          icon:""
        })
        Row(){
          Text("出差总时长:")
            .margin({left:-50})
          Text(this.duration+"")
            .margin({left:10})
        }
        .margin({right:50,top:15,left:70})
        .backgroundColor(Color.White)
        .width(170)
        .height(35)
        .alignItems(VerticalAlign.Center)
      }
    }
    .margin({left:-40})
  }
  async curConfirmFn(){
    let dataset:dailyCCListClass={
      duration:this.duration as number,
      businessDate:this.businessDate,
      address:this.address,
      userId:this.userId,
      endDate:this.businessDateEnd
    }

    await this.addcc(dataset)

    promptAction.showToast({
      message:"添加成功"
    })
    dataset.userId=this.userName
    this.dailyCCData.unshift(dataset)
  }
  async addcc(dataset:dailyCCListClass){
    await addcc(dataset)
  }
  async aboutToAppear(): Promise<void> {
    await this.showDailyCC()
  }
  build() {
    Column(){
      //标题
      Stack({alignContent:Alignment.TopStart}){
        newrightTop({
          titleName:"出差记录"
        })
        Row(){
          if (this.userRole=="管理员"){
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
                this.dailyCCData=[]
                await this.showDailyCC()
              })
          }

          Row(){
            Text(this.date.replaceAll("/","-"))
              .margin({left:240,right:15})
            Image("/images/data.png")
              .width(20)
              .onClick(()=>{
                DatePickerDialog.show({
                  selected:new Date(),
                  start:new Date("1979-1-1"),
                  end:new Date("2030-1-1"),
                  lunar:false,
                  onDateAccept:(value:Date)=>{
                    this.date=DateUtils.padStart(value.toLocaleDateString())
                  }

                })
              })
          }
          .margin({left:this.userRole=="管理员"?50:300,top:this.userRole=="管理员"?0:8})
          if(this.newState){
            Text("申请")
              .fontColor(Color.Blue)
              .margin({left:15,top:8})
              .onClick(async ()=>{
                this.dialogTitle="出差申请"
                this.customDialogCon.open()
              })
          }
        }
        .position({left:100,top:15})//木4
      }

      //正文内容
      Column(){
        //xiao标题
        Row(){
          ForEach(this.smallCCTitle,(item:string)=>{
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
              ForEach(this.dailyCCData,(item:dailyCCListClass)=>{
                Row(){
                  Text(item.userId+"")
                    .textGlobalClass()
                  Text(item.address)
                    .textGlobalClass()
                  Text(item.businessDate)
                    .textGlobalClass()
                  Text(item.endDate)
                    .textGlobalClass()
                  Text(item.duration+"")
                    .textGlobalClass()
                  Text("两条腿")
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
            if (this.dailyCCData.length >= this.pageSize)
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
              await this.showDailyCC()
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
    .visibility(this.curIndex==1 && this.curIndextwo==0 ?Visibility.Visible:Visibility.None)
    .backgroundColor("#f5f9fa")
  }
}
export {dailyCCNavBar}