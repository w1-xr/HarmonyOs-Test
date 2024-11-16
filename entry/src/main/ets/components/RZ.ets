import { addRZ, Class, delRZ, editRZ, rzz, stuDAdel } from '../api'
import { rzTitle } from '../constants'
import { textinputNavBar } from '../dialog/textinput'
import { classRequestClass, fileManagerListClass, stuDARequestClass } from '../models'
import { addrzRequestClass, editrzRequestClass, logListClass, rzRequestClass } from '../models/rz'
import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { newrightTop } from './newrightTop'
import { promptAction } from '@kit.ArkUI'

@Extend(Text) function textGlobalClass(){
  .fontSize(14)
  .fontColor("#616161")
  .width(89)
  .height(50)
  .textAlign(TextAlign.Center)
}
@Component
struct RZNavBar {
  @Prop curIndex: number
  @State smallTitle: string[] = rzTitle
  @State pageIndex:number=1
  @State pageCount:number=0
  @State logClazz:number=-1
  @State logStatus:number=-1
  @State logId:number=-1
  @State logCount:string=""
  @State logUserName:string=""
  @State dialogTitle:string=""
  @State rzData:logListClass[]=[]
  @State zxDAData:fileManagerListClass[]=[]
  pageSize:number=8
  @StorageLink("userId") userId:number=-1
  @StorageLink("userName") userName:string=""
  @Builder swipperEnd(index:number){
    Row(){
      Text("修改")
        .fontColor(Color.Green)//我爱学习
        .onClick(()=>{
          this.dialogTitle="修改日志"
          this.logCount=this.rzData[index].logCount
          this.logStatus=this.rzData[index].logStatus
          this.customDialogCon.open()
        })
      Text("删除")
        .fontColor(Color.Red)
        .margin({left:20})
        .onClick(async ()=>{
          await this.delrz()
          promptAction.showToast({
            message:"删除成功"
          })
        })
    }
  }
  @Builder bottomTip(){
    Column(){
      if(this.pageIndex<=this.pageCount){
        LoadingIcon()
      }
      Text(this.pageIndex<=this.pageCount ? "加载中" : "没有更多了~~~~~")
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
  }
  async showrzList(){
    let dataset:rzRequestClass={
      pageSize:this.pageSize,
      pageIndex:this.pageIndex
    }
   let res=await rzz(dataset)
    this.pageCount=res.pageCount

    this.rzData=this.rzData.concat(res.logList)
    this.pageIndex++
      let findlogId= this.rzData.find(item=>item.logUserName==this.userName)
      if (findlogId){
        this.logId=findlogId.logId

      }

  }

  async showZaixiao(){
    let dataset:stuDARequestClass={
      pageIndex:this.pageIndex,
      pageSize:this.pageSize,
      fileManagerType:"在习生",
      fileManagerName:this.userName
    }
    let res=await stuDAdel(dataset)
    this.logClazz=res.fileManagerList[0].clazzId
  }
  async addrz(){
    let dataset:addrzRequestClass={
      logUserName:this.userId,
      logClazz:this.logClazz,
      logCount:this.logCount,
      logStatus:this.logStatus
    }
    let res=await addRZ(dataset)

  }

  async editrz(){
      let dataset:editrzRequestClass={
        logId:this.logId,
        logCount:this.logCount,
        logStatus:this.logStatus
      }
      let res=await editRZ(dataset)
      console.log("修改日志",JSON.stringify(dataset))

  }
  async delrz(){
    let dataset:number=this.logId
    await delRZ(dataset)
  }

  async aboutToAppear(): Promise<void> {
    await this.showZaixiao()
     await this.showrzList()
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
  async curConfirmFn(){
    if (this.dialogTitle=="修改日志"){
      await this.editrz()
      promptAction.showToast({
        message:"修改成功"
      })
    }else if (this.dialogTitle=="添加日志"){
      await this.addrz()
      promptAction.showToast({
        message:"添加成功"
      })
    }

  }

  @Builder curArea(){
     Column(){
       Row(){
         textinputNavBar({
           rowTitle:"内容:",
           inputText:this.logCount,
           icon:"",
         })
         textinputNavBar({
           rowTitle:"状态:",
           inputText:this.logStatus,
           icon:"",
         })
       }
     }
     .margin({left:-40})
  }
  build() {
    Column() {
      //1.标题
      Stack({ alignContent: Alignment.TopEnd }) {
        newrightTop({
          titleName: "日志系统"
        })
        Row(){
          Image("/images/reflesh.png")
            .width(20)
            .onClick(()=>{
              this.pageIndex=1
              this.rzData=[]
              setTimeout(async ()=>{
                await this.showrzList()
              },500)
            })
          Image("/images/add.png")
            .width(20)
            .margin({left:20})
            .onClick(()=>{
                this.dialogTitle="添加日志"
              this.customDialogCon.open()
            })
        }
        .position({top:20,right:20})

      }

      //2.正文内容
      Column() {
        //2.1xiao标题
        Row() {
          ForEach(this.smallTitle, (item: string) => {
            Row() {
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
        //2.2 接口内容
        List(){
               ForEach(this.rzData,(item:logListClass,index:number)=>{
                 ListItem(){
                   Row(){
                     Text(item.logUserName)
                       .textGlobalClass()
                     Text(item.userSex)
                       .textGlobalClass()
                     Text(item.logClazz)
                       .textGlobalClass()
                     Text(item.createTime)
                       .textGlobalClass()
                     Text(item.logCount)
                       .textGlobalClass()
                   }

                   .height(50)
                   .width("100%")
                   .padding({bottom:20})
                   .justifyContent(FlexAlign.SpaceBetween)
                 }
                 .swipeAction({
                   end:this.swipperEnd(index)
                 })
               })
          ListItem(){
            if (this.rzData.length>=this.pageSize){
              Row(){
                this.bottomTip()
              }
              .width("100%")

            }
          }

           }
        .edgeEffect(EdgeEffect.Fade)
        .height("calc(100% - 60vp)")
        .onReachEnd(async ()=>{
          if (this.pageIndex<=this.pageCount){
            setTimeout(async ()=>{
              await this.showrzList()
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
    .visibility(this.curIndex==4?Visibility.Visible:Visibility.None)
    .backgroundColor("#f5f9fa")
  }
}
export {RZNavBar}