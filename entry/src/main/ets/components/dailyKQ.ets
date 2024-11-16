import { Daily, DailyCC, DailyKQ } from '../api/daily'
import { smallCCTitle, smallKQTitle, smallQJTitle, smallTitle } from '../constants'
import { dailyCCListClass, dailyCCRequestClass, dailyKQListClass,
  dailyKQRequestClass,
  dailyListClass, dailyRequestClass } from '../models'
import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { newrightTop } from './newrightTop'
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
struct dailyKQNavBar{
  @Prop curIndex:number
  @Prop curIndextwo:number
  @State textt:string=""
  @State date:string=new Date().toLocaleDateString()
  @State pageIndex:number=1;//当前的页数；
  @State pageCount:number=0;//总页数；
  pageSize:number=8;//一页显示多少条数据；
  smallKQTitle:string[]=smallKQTitle
  @State dailyKQData:dailyKQListClass[]=[]
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
  async showDailyKQ(){
    //日常正文
    let dataset:dailyKQRequestClass={
      time:this.textt,
      pageSize:this.pageSize,
      pageIndex:this.pageIndex
    }
    let res= await DailyKQ(dataset)
    this.pageCount=res.pageCount
    this.dailyKQData=this.dailyKQData.concat(res.countVos)
    this.pageIndex++
  }

  async aboutToAppear(): Promise<void> {
    await this.showDailyKQ()
  }
  build() {
    Column(){
      //标题
      Stack({alignContent:Alignment.TopStart}){
        newrightTop({
          titleName:"考勤统计"
        })
        Row(){
          if (this.userRole=="管理员"){
            TextInput({
              placeholder:"请输入月份",
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
                this.dailyKQData=[]
                await this.showDailyKQ()
              })
          }

          Row(){
            Text(this.date.replaceAll("/","-"))
              .margin({left:this.userRole=="管理员"?240:500,right:15,top:this.userRole=="管理员"?0:8})
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
          .margin({left:50})

        }
        .position({left:100,top:15})//木4
      }

      //正文内容
      Column(){
        //xiao标题
        Row(){
          ForEach(this.smallKQTitle,(item:string)=>{
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
              ForEach(this.dailyKQData,(item:dailyKQListClass)=>{
                Row(){
                  Text(item.userName)
                    .textGlobalClass()
                  Text(item.vacationDay+"")
                    .textGlobalClass()
                  Text(item.userRole)
                    .textGlobalClass()
                  Text(item.businessDay+"")
                    .textGlobalClass()
                  Text(item.workDay+"")
                    .textGlobalClass()
                  Text(item.shouldDay+"")
                    .textGlobalClass()
                  Text(item.realDay+"")
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
            if (this.dailyKQData.length >= this.pageSize)
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
              await this.showDailyKQ()
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
    .visibility(this.curIndex==1 && this.curIndextwo==2 ?Visibility.Visible:Visibility.None)
    .backgroundColor("#f5f9fa")
  }
}
export {dailyKQNavBar}