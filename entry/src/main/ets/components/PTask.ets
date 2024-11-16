import { addTask, delTask, editTask, Leader, Task } from '../api'
import { TaskTitle } from '../constants'
import { selectNavBar } from '../dialog/select'
import { textinputNavBar } from '../dialog/textinput'
import {
  editTaskRequestClass,
  LeaderDataClass, TaskListRequestClass } from '../models'
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
  .position({top:65,left:20})
  .padding({right:10})
}
@Styles function  smallTitle(){
  .width("100%")
  .height("11%")
  .padding({top:15,bottom:15})
}

@Component
struct PTask{
 @Prop projectId:number=-1
  @Prop  projectChildId:number=-1
  @Prop Taskvisibility:Visibility=Visibility.None;
  @State TaskInput:string=""
  @State StartTime:string=""
  @State EndTime:string=""
  @State titleName:string="任务列表"
  @State placeholder:string="请输入项目名称"
  @State smallTitleTask:string[]=TaskTitle
  @State TaskList:editTaskRequestClass[]=[]
  @State tasklist:string='1244'
  @State pageIndex:number=1
  @State pageCount:number=-1
  pageSize:number=8
  @State dialogTitle:string=""
  @State TaktName:string=""
  @State start:string=""
  @State end:string=""
  @State valuee:string=""
  @State selected:number=-1
  @State progress:number|string=""
  @State workingHours:number|string=""
  @State LeaderArr:SelectOption[]=[]
  @State leaderList: LeaderDataClass[] = [];
  @State leaderId:number=-1
  @State taskId:number=-1
  @State updateIndex: number = -1;
  async Leader(){
    this.leaderList = await Leader()
    for (let i=0;i<this.leaderList.length;i++){
      let obj:SelectOption={
        value:this.leaderList[i].userName
      }
      this.LeaderArr.push(obj)
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
 async showTask(){
   let dataset:TaskListRequestClass={
      taskName:this.TaskInput,
      startTime:this.StartTime,
      // endTime:this.EndTime,
      projectChildId:this.projectChildId,
    }
    let res=await Task(dataset)
    this.TaskList.push(...res.taskList)
    this.pageCount=res.pageCount
    this.pageIndex++
  }
  async addTask(dataset:editTaskRequestClass){
    let res=await addTask(dataset)
  }
  async editTask(dataset:editTaskRequestClass){
    let res=await editTask(dataset)
  }
  async delTask(){
    let dataset:number=this.taskId
    let res=await delTask(dataset)
  }
  //dialog
  private customDialogCon:CustomDialogController=new CustomDialogController({
    builder:MyDialog({
      title:this.dialogTitle,
      contentArea:()=>{this.curArea()},
      cancleFn: () => {  },
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
    if (this.dialogTitle=="添加任务"){
      Column(){
        Row(){
          textinputNavBar({
            rowTitle:"任务名称",//
            inputText:this.TaktName,
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
            inputText:this.workingHours,
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
    }else if(this.dialogTitle=="修改任务"){
      Column(){
        Row(){
          textinputNavBar({
            rowTitle:"任务名称",//
            inputText:this.TaktName,
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
            inputText:this.workingHours,
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
          textinputNavBar({
            rowTitle:"项目进度",
            inputText:this.progress,
            icon:""
          })

        }
      }
      .margin({left:-40})
    }
  }
  async curConfirmFn(){
    this.leaderId=this.leaderList[this.selected].userId;
    let dataset:editTaskRequestClass={
      projectChildId:this.projectChildId,
      taskName:this.TaktName,
      taskLeader:this.leaderId,
      workingHours:this.progress as number,
      startDate:this.start,
      endDate:this.end,
      progress:this.progress as number,
      prop:10,
      projectId:this.projectId,
      taskId:this.taskId
    }
    if (this.dialogTitle=="添加任务"){
      await this.addTask(dataset)
      promptAction.showToast({
        message:"添加成功"
      })
    }else {
      await this.editTask(dataset)
      promptAction.showToast({
        message:"修改成功"
      })
      this.TaskList.splice(this.updateIndex, 1, dataset);
    }
  }
  copyOrClearData(item: editTaskRequestClass | undefined = undefined) {
    this.customDialogCon.close();
    this.TaktName = item ? item.taskName! : '';
    this.workingHours = item ? item.workingHours! : '';
    this.start = item ? item.startDate! : '';
    this.end = item ? item.endDate! : '';
    this.progress = item ? item.progress : '';
    this.selected = item ? this.leaderList.findIndex(leader => leader.userId == item.taskLeader) : 0;
  }
  async aboutToAppear(): Promise<void> {
    await this.showTask()
    await this.Leader()
  }
  build() {
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
            text:$$this.TaskInput
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
          Text("搜索")//
            .Sousuo()
            .fontColor(Color.White)
            .onClick(()=>{
              this.TaskList=[]

               this.showTask()
            })
          Image("/images/add.png")
            .width(20)
            .margin({left:60})
            .onClick(()=>{
                this.copyOrClearData();
                this.dialogTitle="添加任务"
                this.customDialogCon.open()

            })

        }
        .position({left:100,top:15})//木4

      }
      //2.正文内容
      Column(){
        //2.1小标题
        Row() {
          ForEach(this.smallTitleTask,(item: string) => {
            Row() {
              Text(item)
                .fontWeight(600)
                .textAlign(TextAlign.Center)
            }
            .justifyContent(FlexAlign.Center)
            .width(85)
          })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Top)
        .smallTitle()
        //2.2接口内容
        List(){
          ForEach(this.TaskList,(item:editTaskRequestClass,index:number)=>{
            ListItem(){
              Row(){
                Text(item.taskId+"")
                  .textGlobalClass()
                Text(item.taskName)
                  .textGlobalClass()
                Text(this.leaderList.find(leader => leader.userId == item.taskLeader)?.userName)
                  .textGlobalClass()
                Text(item.workingHours+"")
                  .textGlobalClass()
                Text(item.startDate)
                  .textGlobalClass()
                Text(item.endDate)
                  .textGlobalClass()
                Text(item.progress+"")
                  .textGlobalClass()
                Text(item.prop+"")
                  .textGlobalClass()
                Row(){
                  Text("修改")
                    .fontSize(14)
                    .fontColor(Color.Green)
                    .textAlign(TextAlign.Center)
                    .onClick(async ()=>{
                      this.taskId=item.taskId
                      this.updateIndex = index;
                      this.dialogTitle="修改任务"
                      this.copyOrClearData(item);
                      this.customDialogCon.open()

                    })
                  Text("删除")
                    .fontSize(14)
                    .fontColor(Color.Red)
                    .textAlign(TextAlign.Center)
                    .margin({left:5})
                    .onClick(async ()=>{
                      this.taskId=item.taskId
                     await this.delTask()
                      promptAction.showToast({
                        message:"删除成功"
                      })
                      this.TaskList.splice(index, 1);
                    })
                }
                .width(89)
                .height(50)

              }
              .height(50)
              .width("100%")
              .padding({bottom:20})
              .justifyContent(FlexAlign.SpaceBetween)
            }

          })

          ListItem(){
            if (this.TaskList.length>=this.pageSize){
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
              await this.showTask()
            },500)
          }
        })
      }
      .Zhengwen()

    }
      .visibility(this.Taskvisibility)
      .width("100%")
      .height("100%")
      .backgroundColor("#f5f9fa")

  }
}
export {PTask}