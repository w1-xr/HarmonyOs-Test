import { AddClass, Class, classDetail, classId, delDA, EditClass, editDA } from '../api'
import { classDetailTitle, classTitle } from '../constants/classManagement'
import { selectNavBar } from '../dialog/select'
import { textinputNavBar } from '../dialog/textinput'
import { delRequestClass, editDARequestClass } from '../models'
import {
  addRequestClass,
  classDataClass, classListClass, classRequestClass, detailDataClass,
  detailListClass,
  detailRequestClass,
  EditRequestClass, } from '../models/classManagement'

import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { rightToptwo } from './rightToptwo'
import { rightTopone } from './rigthTopone'
import { promptAction } from '@kit.ArkUI'

@Extend(Text) function textGlobalClass(){
  .fontSize(14)
  .fontColor("#616161")
  .width(89)
  .height(50)
  .textAlign(TextAlign.Center)
}
class content{
  title:string=""
  icon?:string=""
  text:string|number=""
}
@Component
struct classNavBar{
  @Prop curIndex:number
  @State pageIndex:number=1;//当前的页数；
  pageSize:number=8;//一页显示多少条数据；
  @State pageCount:number=0;//总页数；
  @State classData:classListClass[]=[]
  @State datailData:detailListClass[]=[]
  @State vv:Visibility=Visibility.Visible
  @State @Watch('detailIdchange') detailId:number=-1
  @StorageLink('search') @Watch('searchChange') textt:string = ''
  classTitle:string[]=classTitle
  @State dialogVis: Visibility = Visibility.None;
  classDetailTitle:string[]=classDetailTitle
  @State clazzLeader:string=""
  @State clazzName:string=""
  @State startTime:string=""
  @State endTime:string=""
  @State EditId:number=-1
  @State title:string=""
  @State fileManagerName:string=""
  @State fileManagerSex:string=""
  @State fileManagerDate:string=""
  @State fileManagerPhone:string=""
  @State fileManagerAddress:string=""
  @State fileManagerSosperson:string=""
  @State fileManagerSosphone:string=""
  @State fileManagerAccount:string=""
  @State clazzId:number=-1
  @State fileManagerId:number=-1
  @State selectArr:SelectOption[]=[{value:"男"},{value:"女"}]
  @State selectArrCLass:SelectOption[]=[]
  @State valuee1:string=""
  @State valuee2:string=""
  @State selected1:number=-1
  @State selected2:number=-1
  @State delId:number=-1
  //TODO：dialog------
  private customDialogCon:CustomDialogController=new CustomDialogController({
    //2.builder调用子组件
    builder:MyDialog({
      title:this.title,
      contentArea: () => {this.curArea()}, //内容区,用build接
      cancleWord:"取消",
      confirmWord:"确认",
      confirmFn: () => { this.myCurfn() }
    }),
    cornerRadius: 0,
    width:620,
    offset:{
      dx:100,
      dy:20
    }
  })
  @Builder
  contentOne($$:content){
    Row() {
      Row(){
        Text($$.title + ":")
      }
      .width(100)
      .justifyContent(FlexAlign.End)
      .margin({right:15})
      Row() {
        TextInput({
          text:$$.text+""
        })
          .onChange((value:string)=>{
            if ($$.title=="班级名称"){
              this.clazzName=value
            }else  if($$.title=="班级负责人"){
              this.clazzLeader=value
            }
          })
          .backgroundColor(Color.Transparent)
          .layoutWeight(1)
        Image($$.icon)
          .width(15)
          .onClick(()=>{
            //1.1定义
            DatePickerDialog.show({
              selected:new Date($$.title=="开始时间"?this.startTime:this.endTime), //选择的日期，当前日期
              start:new Date("1979-1-1"),
              end:new Date("2030-1-1"),
              lunar:false,//日期不显示为农历
              onDateAccept:(value:Date)=>{//点击弹窗中的“确定”按钮时触发该回调。
                if ($$.title=="开始时间"){
                  this.startTime=value.toLocaleDateString().replaceAll("/","-")
                }else {
                  this.endTime=value.toLocaleDateString().replaceAll("/","-")
                }
                // console.log(value.toLocaleDateString().replaceAll("/","-")+this.startTime)
              },
            })
          })
      }
      .padding({right:10})
      .width(170)
      .border({
        width: 1,
        color: "#b4b4b4"
      })
    }
    .margin({right:15,top:15})
    .backgroundColor(Color.White)
    .width(270)
    .height(35)
    .alignItems(VerticalAlign.Center)

  }
  @Builder
  curArea(){
    if (this.title=="添加班级" || this.title=="修改班级" ){
      Column() {
        Row() {
          this.contentOne({title:"班级名称", icon:"", text:this.clazzName})
          this.contentOne({title:"开始时间", icon:"/images/chuchai.png", text:this.startTime})
        }
        Row() {
          this.contentOne({title:"班级负责人", icon:"", text:this.clazzLeader})
          this.contentOne({title:"结束时间", icon:"/images/chuchai.png", text:this.endTime})
        }
      }
    }else if (this.title=="修改学生信息"){
      Column(){
        Row(){
          textinputNavBar({
            rowTitle:"姓名:",
            inputText:this.fileManagerName,
            icon:"",
          })
          selectNavBar({
            rowTitle:"班级:",
            selectArr:this.selectArrCLass,
            selected:this.selected2,
            valuee:this.valuee2
          })
        }
        Row(){
          selectNavBar({
            rowTitle:"性别:",
            selectArr:this.selectArr,
            selected:this.selected1,
            valuee:this.valuee1
          })
          Row(){
            Stack({alignContent:Alignment.TopEnd,}){
              textinputNavBar({
                rowTitle:"毕业日期:",
                inputText:this.fileManagerDate,
                icon:""
              })
              Image("/images/data.png")
                .width(20)
                .position({top:23,left:255})

            }
            .onClick(()=>{
              DatePickerDialog.show({
                start:new Date("2002-1-1"),
                end:new Date("2030-1-1"),
                onDateAccept:(value:Date)=>{
                  this.fileManagerDate=value.toLocaleDateString().replaceAll("/","-")
                }
              })
            })
          }
        }
        Row(){
          textinputNavBar({
            rowTitle:"电话:",
            inputText:this.fileManagerPhone,
            icon:""
          })
          textinputNavBar({
            rowTitle:"家庭住址:",
            inputText:this.fileManagerAddress,
            icon:""
          })
        }
        Row(){
          textinputNavBar({
            rowTitle:"紧急联系人:",
            inputText:this.fileManagerSosperson,
            icon:""
          })
          textinputNavBar({
            rowTitle:"紧急联系人电话:",
            inputText:this.fileManagerSosphone,
            icon:""
          })
        }
        Row(){
          textinputNavBar({
            rowTitle:"账号:",
            inputText:this.fileManagerAccount,
            icon:""
          })
        }
        .margin({left:-285})

      }
      .margin({left:-40})
    }

  }
  async myCurfn(){
    if (this.title=="修改班级"){
      // console.log(this.clazzName + "hhh");
      let dataset:EditRequestClass= new EditRequestClass(this.EditId, this.clazzName, this.startTime, this.endTime, 2)
      // console.log(JSON.stringify(dataset))
      let res=await EditClass(dataset)
      promptAction.showToast({
        message:"修改班级信息成功"
      })
    }else if (this.title=="添加班级"){
      let adddataset:addRequestClass={
        clazzName:this.clazzName,
        startTime:this.startTime,
        endTime:this.endTime,
        clazzLeader:2
      }
      if (this.clazzName!="" && this.startTime!="" && this.endTime!="" && this.clazzLeader==2+""){
        let res=await AddClass(adddataset)
        promptAction.showToast({
          message:"添加班级信息成功"
        })
      }
    }else if(this.title=="修改学生信息"){
      await this.editDA()
      promptAction.showToast({
        message:"修改学生信息成功"
      })
    }
  }
  //接口
  async searchChange() {
    this.pageIndex = 1;
    this.classData = [];
    await this.showClass()
  }
async detailIdchange(){
    this.pageIndex=1
     await this.showDetail()
}
async delStudent(){
    let dataset:delRequestClass={
      fileManagerId:this.delId
    }
    let res=await delDA(dataset)
}
  async aboutToAppear(): Promise<void> {//
    await this.showClass()
    let res = await classId();
    for (let i = 0; i < res.length ; i++) {
      let obj:SelectOption={
        value: res[i].clazzName
      }
      this.selectArrCLass.push(obj)
    }
  }
  async showClass(){
    //班级正文
    let classDataset:classRequestClass={
      pageIndex:this.pageIndex,
      pageSize:this.pageSize,
      clazzName:this.textt,
    }
    // console.log(JSON.stringify(classDataset))
    let res=await Class(classDataset)
    this.pageCount=res.pageCount

    this.classData=this.classData.concat(res.clazzList)
    this.pageIndex++
  }
  async showDetail(){
    //班级详情
    let detailDataSet:detailRequestClass={
      pageIndex:this.pageIndex,
      pageSize:this.pageSize,
      clazzId: this.detailId

    }
    // console.log(JSON.stringify(detailDataSet))
    let res=await classDetail(detailDataSet)
    this.pageCount=res.pageCount
    this.datailData=this.datailData.concat(res.clazzList)
    this.pageIndex++
  }
  // TODO: 班级管理-修改学生
  async editDA(){
      let dataset:editDARequestClass={
        fileManagerName:this.fileManagerName,
        fileManagerId:this.fileManagerId,
        fileManagerAccount:this.fileManagerAccount,
        fileManagerSex:this.valuee1,
        clazzId:this.clazzId,
        fileManagerAddress:this.fileManagerAddress,
        fileManagerSosperson:this.fileManagerSosperson,
        fileManagerSosphone:this.fileManagerSosphone,
        fileManagerDate:this.fileManagerDate,
        fileManagerPhone:this.fileManagerPhone
      }
      let res=await editDA(dataset)
    }

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
  @Builder swipperEnd(item:detailListClass){
    Row(){
      Text("修改")
        .fontColor(Color.Green)
        .onClick(()=>{
          this.title="修改学生信息"
          this.fileManagerName=item.fileManagerName
          this.fileManagerId=item.fileManagerId
          this.fileManagerAccount=item.fileManagerAccount
          this.fileManagerSex=item.fileManagerSex
          this.clazzId=item.clazzId
          this.fileManagerAddress=item.fileManagerAddress
          this.fileManagerSosperson=item.fileManagerSosperson
          this.fileManagerSosphone=item.fileManagerSosphone
          this.fileManagerDate=item.fileManagerDate
          this.fileManagerPhone=item.fileManagerPhone
          this.customDialogCon.open()
        })
      Text("删除")
        .fontColor(Color.Red)
        .margin({left:20})
        .onClick(async ()=>{
          this.delId=item.fileManagerId
          await this.delStudent()
          promptAction.showToast({
            message:"删除成功"
          })

        })

    }
  }
  build() {
    Stack({alignContent:Alignment.Top}){
      Column(){
        //标题
        rightToptwo({
          className:"班级管理",
          detail:"-详情"
        })
        //正文
        Column(){
          //xiao标题
          Row(){
            ForEach(this.classDetailTitle,(item:string)=>{
              Row(){
                Text(item)
                  .fontWeight(600)
                  .textAlign(TextAlign.Center)
                  .margin({left:5})
                  .onClick(()=>{
                    this.vv=Visibility.Visible
                  })
              }
              .justifyContent(FlexAlign.Center)
              .width(130)
            })
          }
          .width("100%")
          .height("11%")
          .padding({top:15,bottom:15})
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Top)
          //TODO:接口内容
          List(){
                  ForEach(this.datailData,(item:detailListClass,index:number)=>{
                    ListItem(){
                      Row(){
                        Text(item.fileManagerName)
                          .textGlobalClass()
                          .width(130)
                        Text(item.fileManagerSex)
                          .textGlobalClass()
                          .width(130)
                        Text(item.fileManagerPhone)
                          .textGlobalClass()
                          .width(130)
                        Text(item.fileManagerAddress)
                          .textGlobalClass()
                          .width(130)
                        Text(item.fileManagerSosperson)
                          .textGlobalClass()
                          .width(130)
                        Text(item.fileManagerSosphone)
                          .textGlobalClass()
                          .width(130)
                      }
                      .height(50)
                      .width("100%")
                      .padding({bottom:20})
                      .justifyContent(FlexAlign.Center)
                      .alignItems(VerticalAlign.Center)
                      .justifyContent(FlexAlign.SpaceBetween)
                    }
                    .swipeAction({
                      end:this.swipperEnd(item)
                    })


                  })

                ListItem(){
                  if (this.classData.length >= this.pageSize){
                    Row(){
                      this.bottomTip()
                    }
                    .width("100%")
                  }

                }
          }
          .height("calc(100% - 60vp)")
          .listDirection(Axis.Vertical)
          .backgroundColor(Color.White)
          .width("100%")
          .onReachEnd(async ()=>{//触底；
            if(this.pageIndex<=this.pageCount){
              setTimeout(async ()=>{
                await this.showClass()
              },500)

            }
          })

        }
        .width("95%")
        .height("calc(100% - 80vp)")
        .backgroundColor(Color.White)
        .position({top:65})
        .padding({left:10,right:10})
      }
      Column(){
        Stack({alignContent:Alignment.End}){
          //标题
          rightTopone({
            className:"班级管理",
            place:"请输入班级名称",
            vv:this.vv,
            textt:this.textt,
            title:this.title
          })
          Image("/images/add.png")
            .width(22)
            .position({
              right:30,
              top:20
            })
            .zIndex(99)
            .onClick(async ()=>{
              this.title="添加班级"
              this.clazzName=""
              this.clazzLeader=""
              this.startTime=""
              this.endTime=""
              this.customDialogCon.open();
             //

            })
        }

        //正文
        Column(){
          //xiao标题
          Row(){
            ForEach(this.classTitle,(item:string)=>{
              Row(){
                Text(item)
                  .fontWeight(600)
                  .textAlign(TextAlign.Center)
                  .margin({left:15})
              }
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
               ForEach(this.classData,(item:classListClass)=>{
                 Row(){
                   Text(item.clazzId+"")
                     .textGlobalClass()
                   Text(item.clazzName+"")
                     .textGlobalClass()
                   Text(item.clazzNum+"")
                     .textGlobalClass()
                   Text((item.startTime+"").replaceAll("-","."))
                     .textGlobalClass()
                   Text((item.endTime+"").replaceAll("-","."))
                     .textGlobalClass()
                   Text(item.clazzLeader+"")
                     .textGlobalClass()
                   Text(item.clazzStatus+"")
                     .textGlobalClass()
                     .fontColor(item.clazzStatus+""=="已开班" ?Color.Green:Color.Red)
                   Text("修改")
                     .textGlobalClass()
                     .fontColor(Color.Green)
                     .onClick(()=>{
                       this.customDialogCon.open();
                       this.title="修改班级"
                      this.clazzLeader=item.clazzLeader
                       this.clazzName=item.clazzName
                       this.startTime=item.startTime
                       this.endTime=item.endTime
                       this.EditId=item.clazzId
                       // console.log(this.clazzName)
                     })
                   Text("详情")
                     .textGlobalClass()
                     .textAlign(TextAlign.Start)
                     .margin({left:10})
                     .fontColor("#5880e2")
                     .onClick(()=>{
                       this.vv=Visibility.None
                       this.detailId=item.clazzId

                     })
                 }
                 .height(50)
                 .width("100%")
                 .padding({bottom:20})
                 .justifyContent(FlexAlign.SpaceBetween)

               })
             }


            }
            ListItem(){
              if (this.classData.length >= this.pageSize)
              Row(){
                this.bottomTip()
              }
              .width("100%")
            }


          }
          .height("calc(100% - 60vp)")
          .onReachEnd(async ()=>{//触底；
            if(this.pageIndex<=this.pageCount){
              setTimeout(async ()=>{
                await this.showClass()
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
        .position({top:65})
        .padding({left:10,right:10})
      }
      .visibility(this.vv)
    }
    .visibility(this.curIndex==0?Visibility.Visible:Visibility.None)
    .width("100%")
    .height("100%")
    .backgroundColor("#f5f9fa")
  }
}
export {classNavBar}