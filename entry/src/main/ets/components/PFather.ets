import { addFather, Father, Leader, Member } from '../api/project'
import { FatherTitle } from '../constants'
import { selectNavBar } from '../dialog/select'
import { textinputNavBar } from '../dialog/textinput'
import { addFatherRequestClass, FatherListRequestClass, LeaderDataClass,
  memberDataClass,
  memberRequestClass,
  projectListClass } from '../models'
import { LoadingIcon } from '../utils/LoadingIcon'
import { newrightTop } from './newrightTop'
import { PTask } from './PTask'
import { promptAction, PromptAction } from '@kit.ArkUI'
import { MyDialog } from '../utils/myDialog'
import { PChild } from './PChild'


@Extend(Text) function textGlobalClass(){
  .fontSize(14)
  .fontColor("#616161")
  .width(89)
  .height(50)
  .textAlign(TextAlign.Center)
}
@Extend(TextInput) function textInput(){
  .layoutWeight(1)
  .fontSize(14)
  .placeholderColor("#c0c0c0")
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
  .width(150)
  .backgroundColor(Color.Transparent)
  .borderRadius(0)
  .border({
    width:1,
    color:"#c0c0c0"
  })
  .height(33)
  .margin({left:20,right:10})
}
@Styles function  middle(){
  .width(20)
  .height(2)
  .backgroundColor("#c0c0c0")
  .margin({left:10,right:10})
}
@Styles function  end(){
  .border({
    width:1,
    color:"#c0c0c0"
  })
  .height(33)
  .padding({right:10})
  .width(140)
}
@Styles function  Sousuo(){
  .backgroundColor("#0f6ab1")
  .padding({left:15,right:15,top:5,bottom:5})
  .margin({left:15})
}
@Styles function  Zhengwen(){
  .width("95%")
  .height("calc(100% - 80vp)")
  .backgroundColor(Color.White)
  .position({top:65,})
  .padding({left:10,right:10})
}
@Styles function  smallTitle(){
  .width("100%")
  .height("11%")
  .padding({top:15,bottom:15})
}

@Component
struct PFather{
  @Prop curIndex:number
  @State curIndexTwo:number=-1
  @State curIndexOne:number=-1
  @State Fathervisibility:Visibility=Visibility.Visible
  @State Childvisibility:Visibility=Visibility.None
  @State Taskvisibility:Visibility=Visibility.None
  @State FatherInput:string=""
  @State StartTime:string=""
  @State EndTime:string=""
  @State start:string=""
  @State end:string=""
  @State titleName:string="项目管理"
  @State placeholder:string="请输入项目名称"
  @State smallTitleFather:string[]=FatherTitle
  @State FatherData:projectListClass[]=[]
  @State memberArr:memberDataClass[]=[]
  @State pageIndex:number=1
  @State pageCount:number=-1
  @State valuee:string=""
  @State selected:number=-1
  @State projectName:string=""
  @State progress:number|string=""
  pageSize:number=8
  @State leaderList: LeaderDataClass[] = [];
  @State LeaderArr:SelectOption[]=[]
  @State leaderId:number=-1
  @State projectId:number=-1
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
  async showFather(){
    let dataset:FatherListRequestClass={
      pageIndex:this.pageIndex,
      pageSize:this.pageSize,
      projectName:this.FatherInput,
      startTime: this.StartTime == '' ? '1970-01-01' : this.StartTime,
      endTime: this.EndTime == '' ? '2099-12-31' : this.EndTime//保尔
    }
    let res=await Father(dataset)
    this.FatherData=this.FatherData.concat(res.projectList)
    this.pageCount=res.pageCount
    this.pageIndex++
  }
  async Leader(){
    this.leaderList = await Leader()
    for (let i=0;i<this.leaderList.length;i++){
      let obj:SelectOption={
        value:this.leaderList[i].userName
      }
      this.LeaderArr.push(obj)
    }
  }
  async add(){
    let dataset:addFatherRequestClass={
      projectName:this.projectName,
      projectLeader:this.leaderId,
      workingHours:Number(this.progress as number),
      startDate:this.start,
      endDate:this.end
    }
    let res=await addFather(dataset)
  }
  //diaLog
  private diaLog:CustomDialogController=new CustomDialogController({
    builder:MyDialog({
       title:"添加项目",
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
  async curConfirm(){
    this.leaderId=this.leaderList[this.selected].userId;
    await this.add()
    promptAction.showToast({
      message:"添加成功"
    })

  }
@Builder curContent(){
    Column(){
       Row(){
         textinputNavBar({
           rowTitle:"项目名称",
           inputText:this.projectName,
           icon:""
         })
         selectNavBar({
           rowTitle:"负责人",
           selectArr:this.LeaderArr,
           selected:this.selected,
           valuee:this.valuee
         })
       }
      Row(){
        textinputNavBar({
          rowTitle:"项目工期",
          inputText:this.progress,
          icon:""
        })
        Stack({alignContent:Alignment.TopEnd}){
          textinputNavBar({
            rowTitle:"开始时间",
            inputText:this.start,
            icon:""
          })
          Image("/images/data.png")
            .width(20)
            .position({top:23,left:255})
            .onClick(()=>{
              DatePickerDialog.show({
                onDateAccept:(value)=>{
                  this.start=value.toLocaleDateString().replaceAll("/","-")
                }
              })
            })
        }
      }
      Row(){
        Stack({alignContent:Alignment.TopEnd}){
          textinputNavBar({
            rowTitle:"结束时间",
            inputText:this.end,
            icon:""

          })
          Image("/images/data.png")
            .width(20)
            .position({top:23,left:255})
            .onClick(()=>{
              DatePickerDialog.show({
                onDateAccept:(value)=>{
                 this.end=value.toLocaleDateString().replaceAll("/","-")
                }
              })
            })
        }
      }
      .margin({left:-285})

    }
    .margin({left:-40})
}
  async aboutToAppear(): Promise<void> {
    await this.Leader()
    await this.showFather()
  }
  build() {
    Column(){
      //项目列表
      Column(){
        //1.标题
        Stack({alignContent:Alignment.TopStart}){
          newrightTop({
            titleName:this.titleName
          })
          Row(){
            TextInput({
              placeholder:this.placeholder,
              text:$$this.FatherInput
            })
              .placeholderColor("#c0c0c0")
              .fontSize(13)
              .topStyle()
            Row(){
              TextInput({
                placeholder:"开始时间",
                text:$$this.StartTime
              })
                .textInput()
              Image("/images/data.png")
                .width(18)
                .margin({left:10})
                .onClick(()=>{
                  DatePickerDialog.show({
                    onDateAccept:(value)=>{
                      this.StartTime=value.toLocaleDateString().replaceAll("/","-")
                    }
                  })
                })
            }

            .end()
            Row(){}.middle()
            Row(){
              TextInput({
                placeholder:"结束时间",
                text:$$this.EndTime
              })
                .textInput()

              Image("/images/data.png")
                .width(18)
                .margin({left:10})
                .onClick(()=>{
                  DatePickerDialog.show({
                    onDateAccept:(value)=>{
                      this.EndTime=value.toLocaleDateString().replaceAll("/","-")
                    }
                  })
                })
            }
            .end()
            Text("搜索")
              .Sousuo()
              .fontColor(Color.White)
              .onClick(async ()=>{
                this.pageIndex=1
                this.FatherData=[]
                await this.showFather()

              })

            Image("/images/add.png")
              .width(20)
              .margin({left:60})
              .onClick(()=>{
                 this.diaLog.open()
              })
          }
          .position({left:100,top:15})//木4

        }


        //2.正文内容
       Column(){
          //2.1小标题
         Row() {
           ForEach(this.smallTitleFather, (item: string) => {
             Row() {
               Text(item)
                 .fontWeight(600)
                 .textAlign(TextAlign.Center)
             }
             .justifyContent(FlexAlign.Center)
             .width(89)
           })
         }
         .justifyContent(FlexAlign.SpaceBetween)
         .alignItems(VerticalAlign.Top)
         .smallTitle()

         //2.2接口内容
         List(){
             ForEach(this.FatherData,(item:projectListClass,index:number)=>{
               ListItem(){
                 Row(){
                   Text(item.projectId+"")
                     .textGlobalClass()
                   Text(item.projectName)
                     .textGlobalClass()
                   Text(item.projectLeader)
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
                     .onClick(async ()=>{
                       this.Fathervisibility=Visibility.None
                       this.Childvisibility=Visibility.Visible
                       this.projectId=item.projectId
                     })
                 }
                 .height(50)
                 .width("100%")
                 .padding({bottom:20})
                 .justifyContent(FlexAlign.SpaceBetween)
               }

             })
             ListItem(){
               if (this.FatherData.length>=this.pageSize){
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
            await this.showFather()
             },500)
           }
         })
       }
       .Zhengwen()

      }
      .visibility(this.Fathervisibility)
      PChild({
        Childvisibility:this.Childvisibility,
        projectId:this.projectId,
        Taskvisibility:this.Taskvisibility
      })
    }
    .visibility(this.curIndex==6?Visibility.Visible:Visibility.None)
    .width("100%")
    .height("100%")
    .backgroundColor("#f5f9fa")

    }
}
export {PFather}