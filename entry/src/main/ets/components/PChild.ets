import { addChild, addmember, Child, editChild, Leader, Member } from '../api/project'
import { ChildTitle } from '../constants'
import { selectNavBar } from '../dialog/select'
import { textinputNavBar } from '../dialog/textinput'
import { addChildRequestClass,
  addmemberRequestClass,
  childListClass, childRequestClass,
  editChildRequestClass,
  LeaderDataClass,
  memberDataClass, memberRequestClass } from '../models'
import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { newrightTop } from './newrightTop'
import { PTask } from './PTask'
import { promptAction } from '@kit.ArkUI'
import { ifaa } from '@kit.OnlineAuthenticationKit'

@Extend(Text) function textGlobalClass(){
  .fontSize(14)
  .fontColor("#616161")
  .width(89)
  .height(50)
  .textAlign(TextAlign.Center)
}
@Extend(Text) function textGlobalClass2(){
  .fontSize(13)
  .fontColor("#616161")
  .width(60)
  .height(50)
  .textAlign(TextAlign.Center)

}
@Extend(TextInput) function textInput(){
  .layoutWeight(1)
  .fontSize(14)
  .placeholderColor("#c0c0c0")
  .fontColor("#c0c0c0")
  .backgroundColor(Color.Transparent)
}
@Extend(List) function ListGlobalClass(){
  .edgeEffect(EdgeEffect.Fade)
  .height("calc(100% - 60vp)")
  .listDirection(Axis.Vertical)
  .backgroundColor(Color.White)
  .width("100%")
}
@Styles function  topStyle(){
  .width(170)
  .backgroundColor(Color.Transparent)
  .borderRadius(0)
  .border({
    width:1,
    color:"#c0c0c0"
  })
  .height(33)
  .margin({left:20,right:10})
}

@Styles function  Zhengwen(){
  .width("98%")
  .height("calc(100% - 260vp)")
  .backgroundColor(Color.White)
  .position({top:250,left:10})
  .padding({left:10,right:10})

}
@Styles function  smallTitle(){
  .width("100%")
  .height("11%")
  .padding({top:10})
  .margin({bottom:10})
}
@Component
struct PChild{
  @Prop @Watch('getData') projectId:number
  @Link Childvisibility:Visibility
  @Link Taskvisibility:Visibility
  @State titleName:string="项目管理-项目详情"
  @State foncolorIndex:number=-1
  @State childProjectName:string=""
  @State dialogTitle:string=""
  @State projectChildId:number=-1
  @State smallTitleChild:string[]=ChildTitle
  @State pageIndex:number=1
  @State pageCount:number=-1
  pageSize:number=8
  @State ChildData:childListClass[]=[]
  @State memberArr:memberDataClass[]=[]
  @State  v:number=0
  @State op:number=0
  @State start:string=""
  @State end:string=""
  @State valuee:string=""
  @State selected:number=-1
  @State userId:number=-1
  @State progress:number|string=""
  @State prop:number|string=""
  @State workingHours:number|string=""
  @State LeaderArr:SelectOption[]=[]
  @State leaderList: LeaderDataClass[] = [];
  @State leaderId:number=-1
  @State ChildName:string=""
  @State userIdArr:addmemberRequestClass[]=[]
  async Leader(){
    this.leaderList = await Leader()
    for (let i=0;i<this.leaderList.length;i++){
      let obj:SelectOption={
        value:this.leaderList[i].userName
      }
      this.LeaderArr.push(obj)
    }
  }
  tab(){
    animateTo((this.ani),()=>{
      this.v=this.v==1?0:1
      this.op=this.op==0?0.2:0
    })
  }
  ani:AnimateParam={
    duration:500,
    curve:Curve.Linear
  }
  //dialog
  private customDialogCon:CustomDialogController=new CustomDialogController({
    builder:MyDialog({
      title:this.dialogTitle,
      contentArea:()=>{this.curArea()},
      confirmFn:()=>{this.curConfirmFn()},
      cancleFn:()=>{this.canclefn()}
    }),
    cornerRadius:0,
    width:620,
    offset:{
      dx:100,
      dy:20
    }
  })
  @Builder curArea(){
    if (this.dialogTitle=="添加子项目") {
      Column() {
        Row() {
          textinputNavBar({
            rowTitle: "子项目名称", //
            inputText: this.ChildName,
            icon: ""
          })
          selectNavBar({
            rowTitle: "负责人",
            selectArr: this.LeaderArr,
            selected: this.selected,
            valuee: this.valuee
          })
        }

        Row() {
          textinputNavBar({
            rowTitle: "项目工期",
            inputText: this.workingHours,
            icon: ""
          })
          Stack({ alignContent: Alignment.TopEnd }) {
            textinputNavBar({
              rowTitle: "开始时间",
              inputText: this.start,
              icon: ""
            })
            Image("/images/data.png")
              .width(20)
              .position({ top: 23, left: 255 })
              .onClick(() => {
                DatePickerDialog.show({
                  onDateAccept: (value) => {
                    this.start = value.toLocaleDateString().replaceAll("/", "-")
                  }
                })
              })
          }
        }

        Row() {
          Stack({ alignContent: Alignment.TopEnd }) {
            textinputNavBar({
              rowTitle: "结束时间",
              inputText: this.end,
              icon: ""
            })
            Image("/images/data.png")
              .width(20)
              .position({ top: 23, left: 255 })
              .onClick(() => {
                DatePickerDialog.show({
                  onDateAccept: (value) => {
                    this.end = value.toLocaleDateString().replaceAll("/", "-")
                  }
                })
              })
          }

          textinputNavBar({
            rowTitle: "比重", //
            inputText: this.prop,
            icon: ""
          })
        }
      }
      .margin({ left: -40 })
    }else if(this.dialogTitle=="添加项目组成员"){
      Grid(){
       ForEach(this.leaderList,(item:LeaderDataClass)=>{
         GridItem(){
           Row(){
             Checkbox({
               name:item.userId+"",
               group:"my"
             })
               .onChange((value) => {
                 if (value) {
                   let obj:addmemberRequestClass = {
                     userId: item.userId,
                     projectId: this.projectId
                   };
                   this.userIdArr.push(obj);
                 } else {
                   const index = this.userIdArr.findIndex(data => data.userId == item.userId);
                   if (index !== -1) {
                     this.userIdArr.splice(index, 1);
                   }
                 }
               });
             Text(item.userName)
               .fontSize(14)
               .layoutWeight(1)
           }
           .width("100%")
           .height(50)
           .justifyContent(FlexAlign.Start)
         }
       })
      }
      .padding({left:20})
      .height(150)
      .columnsTemplate("1fr 1fr 1fr 1fr")
    }else if(this.dialogTitle=="修改子项目"){
      Column() {
        Row() {
          textinputNavBar({
            rowTitle: "子项目名称", //
            inputText: this.ChildName,
            icon: ""
          })
          selectNavBar({
            rowTitle: "负责人",
            selectArr: this.LeaderArr,
            selected: this.selected,
            valuee: this.valuee
          })
        }

        Row() {
          textinputNavBar({
            rowTitle: "项目工期",
            inputText: this.workingHours,
            icon: ""
          })
          Stack({ alignContent: Alignment.TopEnd }) {
            textinputNavBar({
              rowTitle: "开始时间",
              inputText: this.start,
              icon: ""
            })
            Image("/images/data.png")
              .width(20)
              .position({ top: 23, left: 255 })
              .onClick(() => {
                DatePickerDialog.show({
                  onDateAccept: (value) => {
                    this.start = value.toLocaleDateString().replaceAll("/", "-")
                  }
                })
              })
          }
        }

        Row() {
          Stack({ alignContent: Alignment.TopEnd }) {
            textinputNavBar({
              rowTitle: "结束时间",
              inputText: this.end,
              icon: ""
            })
            Image("/images/data.png")
              .width(20)
              .position({ top: 23, left: 255 })
              .onClick(() => {
                DatePickerDialog.show({
                  onDateAccept: (value) => {
                    this.end = value.toLocaleDateString().replaceAll("/", "-")
                  }
                })
              })
          }
          textinputNavBar({
            rowTitle: "比重", //
            inputText: this.prop,
            icon: ""
          })
        }
      }
      .margin({ left: -40 })
    }
  }
  async curConfirmFn(){
    if (this.dialogTitle=="添加子项目"){
      this.leaderId=this.leaderList[this.selected].userId;
      await this.addChildd()
      promptAction.showToast({
        message:"添加成功"
      })
      this.tab()
    }else if(this.dialogTitle=="添加项目组成员"){
      await this.addmember()
      promptAction.showToast({
        message:"添加成功"
      })
      this.tab()
    }else if(this.dialogTitle=="修改子项目"){
      this.leaderId=this.leaderList[this.selected].userId;
      await this.editChild()
      promptAction.showToast({
        message:"修改成功"
      })
    }
  }
  canclefn(){
    this.userIdArr=[]
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
@Builder swipperEnd(item:childListClass){
  Row(){
    Text("修改")
      .fontSize(14)
      .fontColor(Color.Green)
      .margin({top:-10})
      .onClick(()=>{
        this.dialogTitle="修改子项目"
        this.ChildName=item.childProjectName
          this.leaderId=item.childProjectLeader
          this.workingHours=item.workingHours
          this.start=item.startDate
          this.end=item.endDate
          this.prop=item.prop
          this.projectId=item.projectId
        this.projectChildId=item.childProjectId
        this.customDialogCon.open()
      })
  }
}
  async getData() {
    let dataset:memberRequestClass={
      projectId:this.projectId
    }
    this.memberArr=await Member(dataset)
  }
  async showChild(){
    let dataset:childRequestClass={
      childProjectName:this.childProjectName,
      pageIndex:1,
      pageSize:3,
      projectId:this.projectId
    }
    let res=await Child(dataset)
    this.ChildData=this.ChildData.concat(res.childList)
    this.pageCount=res.pageCount
    this.pageIndex++
  }
  async addmember(){
    let res=await addmember(this.userIdArr)
  }
  async addChildd(){
    let dataset:addChildRequestClass={
      childProjectName:this.ChildName,
      childProjectLeader:this.leaderId,
      workingHours:Number(this.workingHours as number),
      startDate:this.start,
      endDate:this.end,
      prop:Number(this.prop as number),
      projectId:this.projectId
    }
    let res=await addChild(dataset)
    // console.log(JSON.stringify(dataset))
  }
  async editChild(){
    let dataset:editChildRequestClass={
      childProjectName:this.ChildName,
      childProjectId:this.projectChildId,
      childProjectLeader:this.leaderId,
      workingHours:Number(this.workingHours as number),
      startDate:this.start,
      endDate:this.end,
      prop:Number(this.prop as number),
      projectId:this.projectId
    }
    let res=await editChild(dataset)
    // console.log("修改",JSON.stringify(dataset))
  }
  async aboutToAppear(): Promise<void> {
    await this.showChild()
    await this.Leader()
  }

  build() {
    //项目列表
    Column(){
      Column(){
        //1.标题
        Stack({alignContent:Alignment.TopStart}){
          newrightTop({
            titleName:this.titleName
          })
          Row(){
            TextInput({
              placeholder:"请输入子项目名称",//
              text:$$this.childProjectName
            })
              .onChange((value)=>{
                this.childProjectName=value
              })
              .placeholderColor("#c0c0c0")
              .fontSize(13)
              .topStyle()
            Text("搜索")
              .backgroundColor("#0f6ab1")
              .fontColor(Color.White)
              .padding({left:15,right:15,top:5,bottom:5})
              .margin({left:15})
              .onClick(()=>{
                this.showChild()
              })
            Stack({alignContent:Alignment.TopStart}){
              //1.
              Image("/images/add.png")
                .width(20)
                .onClick(()=>{
                    this.tab()
                })
                .margin({left:300,top:15})
              //2.弹出框
                Column(){
               Row(){
                 Text("添加子项目")
                   .width(110)
                   .textAlign(TextAlign.Center)
                   .fontSize(14)
                   .border({
                     width:1,
                     color:Color.Gray
                   })
                   .fontColor(this.foncolorIndex==1?Color.Blue:Color.Black)
                   .padding({top:8,bottom:8,left:5,right:5})
                   .onClick(async ()=>{
                        this.foncolorIndex=1
                        this.dialogTitle="添加子项目"
                        await this.customDialogCon.open()

                   })
               }
                Row(){
                  Text("添加项目组成员")
                    .width(110)
                    .fontSize(14)
                    .textAlign(TextAlign.Center)
                    .border({
                      width:1,
                      color:Color.Gray
                    })
                    .fontColor(this.foncolorIndex==2?Color.Blue:Color.Black)
                    .padding({top:8,bottom:8,left:5,right:5})
                    .onClick(async ()=>{
                      this.foncolorIndex=2
                      this.dialogTitle="添加项目组成员"
                      await this.customDialogCon.open()
                    })
                }
                }
                .width(110)
                .zIndex(1000)
                .backgroundColor(Color.White)
                .position({top:35,right:15})
                .scale({
                  centerX:100,
                  centerY:0,
                  x:this.v,
                  y:this.v
                })
            }
          }
          .position({left:180,top:8})//
        }
        .height(43)
        .zIndex(100)
        .width("98%")
        .backgroundColor(Color.White)
        .margin({top:10})
        //2.中间
        Column(){
          Row(){
            Row(){}.width(2) .height(10).backgroundColor(Color.Blue)
            Text("项目组成员")
              .margin({left:10})
          }
          .padding({top:10})
          .margin({left:30})
          .width("100%")
          Grid(){
            ForEach(this.memberArr,(item:memberDataClass)=>{
              GridItem(){
                Row(){
                  Text(item.userId)
                    .textGlobalClass2()
                  Text(item.userPhone)
                    .textGlobalClass2()
                    .width(85)
                  Text(item.status)
                    .textGlobalClass2()
                    .fontColor(item.status=="空闲"?Color.Green:Color.Red)
                }
                .height(40)
                .alignItems(VerticalAlign.Top)
              }
            })
          }
          .height(130)
          .columnsTemplate("1fr 1fr 1fr")
        }
        .width("98%")
        .position({top:75,left:8})
        .padding({left:10,right:10})
        .height(160)
        .backgroundColor(Color.White)
        //2.正文内容
        Column(){
          //2.1小标题
          Row() {
            ForEach(this.smallTitleChild, (item: string) => {
              Text(item)
                .fontWeight(600)
                .textAlign(TextAlign.Center)
                .width(89)
                .height('100%')
                .zIndex(999)
            })
          }
          .backgroundColor(Color.White)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Top)
          .smallTitle()
          //2.2接口内容
          List(){
            ForEach(this.ChildData,(item:childListClass,index:number)=>{
              ListItem(){
                Row(){
                  Text(item.childProjectId+"")
                    .textGlobalClass()
                  Text(item.childProjectName)
                    .textGlobalClass()
                  Text(item.childProjectLeader+"")
                    .textGlobalClass()
                  Text(item.workingHours+"")
                    .textGlobalClass()
                  Text(item.startDate)
                    .textGlobalClass()
                  Text(item.endDate)
                    .textGlobalClass()
                  Text(item.progress+"")
                    .textGlobalClass()
                  Text("详情")
                    .textGlobalClass()
                    .fontColor(Color.Blue)
                    .onClick(()=>{
                      this.Childvisibility=Visibility.None
                      this.Taskvisibility=Visibility.Visible
                      this.projectChildId=item.childProjectId
                      console.log(this.projectChildId+"projectChildId:")

                    })
                }
                .height(50)
                .width("100%")
                .padding({bottom:10})
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .swipeAction({
                end:this.swipperEnd(item)
              })

            })
            ListItem(){
              if (this.ChildData.length>=this.pageSize){
                Row(){
                  this.bottomTip()
                }
                .width("100%")
              }
            }
          }
          .ListGlobalClass()
          .onReachEnd(async ()=>{
            if (this.pageIndex<=this.pageCount){
              setTimeout(async ()=>{
                await this.showChild()
              },500)
            }
          })
        }
        .Zhengwen()
      }
      .visibility(this.Childvisibility)
      if(this.projectChildId!=-1 && this.Taskvisibility==Visibility.Visible){
        PTask({
          Taskvisibility:this.Taskvisibility,
          projectChildId:this.projectChildId,
          projectId:this.projectId
        })
      }
    }
    .padding({left:10,right:10})
    .width("100%")
    // .height("100%")
    .backgroundColor("#f5f9fa")


  }
}
export {PChild}