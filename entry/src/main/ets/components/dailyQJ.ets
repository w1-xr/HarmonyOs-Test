import { addQJ, Daily, DailyCC, DailyKQ, DailyQJ } from '../api/daily'
import { smallCCTitle, smallKQTitle, smallQJTitle, smallTitle } from '../constants'
import { selectNavBar } from '../dialog/select'
import { textinputNavBar } from '../dialog/textinput'
import { dailyCCListClass, dailyCCRequestClass, dailyKQListClass,
  dailyKQRequestClass,
  dailyListClass,
  dailyQJListClass,
  dailyQJRequestClass,
  dailyRequestClass } from '../models'
import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { newrightTop } from './newrightTop'
import { promptAction } from '@kit.ArkUI'
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
struct dailyQJNavBar{
  @Prop curIndex:number
  @Prop curIndextwo:number
  @State textt:string=""
  @State date:string=new Date().toLocaleDateString()
  @State pageIndex:number=1;//当前的页数；
  @State pageCount:number=0;//总页数；
  pageSize:number=8;//一页显示多少条数据；
  smallQJTitle:string[]=smallQJTitle
  @Prop newState:boolean=false
  @State dailyQJData:dailyQJListClass[]=[]
  @State QJName:string=""
  @State vacationDate:string=""
  @State vacationDateEnd:string=""
  @State valuee:string=""
  @State vacationCount:string=""
  @State duration:string | number=""
  @State selected:number=-1
  @State identifyID:number=-1
  @StorageLink("userId") userId:number=-1
  @StorageLink("userName") userName:string=""
  @StorageLink("userRole") userRole:string=""
  identifyArr:SelectOption[]=[{value:"老师"},{value:"学生"}]
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
  private dialog:CustomDialogController=new CustomDialogController({
    builder:MyDialog({
      title:"请假申请",
      contentArea:()=>{this.curContent()},
      confirmFn:()=>{this.curConfirm()}
    }),
    cornerRadius:0,
    width:620,
    offset:{
      dx:100,
      dy:20
    }
  })
  @Builder curContent(){
    Column(){
      Row(){
        Row(){
          Text("姓名:")
          Text(this.userName)
            .margin({left:10})
            .fontColor(Color.Gray)
        }
        .margin({right:50,top:15,left:70})
        .backgroundColor(Color.White)
        .width(170)
        .height(35)
        .alignItems(VerticalAlign.Center)
        Stack({alignContent:Alignment.TopEnd}){
          textinputNavBar({
            rowTitle:"开始时间",
            inputText:this.vacationDate,
            icon:""
          })
          Image("/images/data.png")
            .width(20)
            .position({top:23,left:255})
            .onClick(()=>{
              DatePickerDialog.show({
                onDateAccept:(value)=>{
                  this.vacationDate=DateUtils.padStart(value.toLocaleDateString())
                  this.duration= DateUtils.getDays(this.vacationDate,this.vacationDateEnd)
                }
              })
            })
        }
      }
      Row(){
        Row(){
          Text("标识:")
          Text(this.userRole=="老师"?"老师":"学生")
            .margin({left:10})
            .fontColor(Color.Gray)
        }
        .margin({right:50,top:15,left:70})
        .backgroundColor(Color.White)
        .width(170)
        .height(35)
        .alignItems(VerticalAlign.Center)
        Stack({alignContent:Alignment.TopEnd}){
          textinputNavBar({
            rowTitle:"返回时间",
            inputText:this.vacationDateEnd,
            icon:""
          })
          Image("/images/data.png")
            .width(20)
            .position({top:23,left:255})
            .onClick(()=>{
              DatePickerDialog.show({
                onDateAccept:(value)=>{
                  this.vacationDateEnd=DateUtils.padStart(value.toLocaleDateString())
                  this.duration= DateUtils.getDays(this.vacationDate,this.vacationDateEnd)
                }
              })
            })
        }
      }
      Row(){
        textinputNavBar({
          rowTitle:"请假事由",
          inputText:this.vacationCount,
          icon:""
        })
        Row(){
          Text("请假总时长:")
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

  async curConfirm(){
    this.identifyID=this.selected==0?2:3
    let dataset:dailyQJListClass={
      duration:Number(this.duration),
      vacationDate:this.vacationDate,
      endDate:this.vacationDateEnd,
      vacationCount:this.vacationCount,
      userId:this.userId,
      userName:this.userName,
      identify:this.userRole=="老师"?2:3//
    }
    console.log("请假",JSON.stringify(dataset))
    await this.addQJ(dataset)
    promptAction.showToast({
      message:"添加成功"
    })
    dataset.identify=this.userRole=="老师"?"老师":"学生"
    dataset.userId=this.userName


    this.dailyQJData.unshift(dataset)
  }

  async addQJ(dataset:dailyQJListClass){
    await addQJ(dataset)
  }
  async showDailyQJ(){
    //日常正文
    let dataset:dailyQJRequestClass={
      userId:this.userId,//登陆的身份
      userName:this.userRole=="管理员"?this.textt:this.userName,
      pageSize:this.pageSize,
      pageIndex:this.pageIndex
    }
    let res= await DailyQJ(dataset)
    this.pageCount=res.pageCount
    this.dailyQJData=this.dailyQJData.concat(res.vacationList)
    this.pageIndex++
  }

  async aboutToAppear(): Promise<void> {
    await this.showDailyQJ()
    // 123
  }
  build() {
    Column(){
      //标题
      Stack({alignContent:Alignment.TopStart}){
        newrightTop({
          titleName:"请假统计"
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
                this.dailyQJData=[]
                await this.showDailyQJ()
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
                    this.date=value.toLocaleDateString().replaceAll("/","-")

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
                this.dialog.open()
              })
          }
        }
        .position({left:100,top:15})//木4
      }

      //正文内容
      Column(){
        //xiao标题
        Row(){
          ForEach(this.smallQJTitle,(item:string)=>{
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
              ForEach(this.dailyQJData,(item:dailyQJListClass)=>{
                Row(){
                  Text(item.userId+"")
                    .textGlobalClass()
                  Text(item.identify+"")
                    .textGlobalClass()
                  Text(item.vacationCount)
                    .textGlobalClass()
                  Text(item.vacationDate)
                    .textGlobalClass()
                  Text(item.endDate)
                    .textGlobalClass()
                  Text(item.duration+"")
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
            if (this.dailyQJData.length >= this.pageSize)
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
              await this.showDailyQJ()
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
    .visibility(this.curIndex==1 && this.curIndextwo==1 ?Visibility.Visible:Visibility.None)
    .backgroundColor("#f5f9fa")
  }
}
export {dailyQJNavBar}