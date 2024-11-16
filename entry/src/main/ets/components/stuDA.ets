import {  addDA, classId, delDA, detailDA, editDA, stuDAdel } from '../api'
import { yuzhaoTitle, zaixiaoTitle } from '../constants'
import { selectNavBar } from '../dialog/select'
import { textinputNavBar } from '../dialog/textinput'
import { addDARequestCLass,
  delRequestClass,
  editDARequestClass, fileManagerListClass,
  sDetailRequestClass,
  stuDARequestClass } from '../models'
import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { newrightTop } from './newrightTop'
import { promptAction } from '@kit.ArkUI'

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
struct stuDANavBar{
@Prop curIndex:number
  @State statu:string=""
  @State fileManagerName:string=""
  @State clazzName:string=""
  @State fileManagerSex:string=""
  @State fileManagerDate:string=""
  @State fileManagerPhone:string=""
  @State fileManagerAddress:string=""
  @State fileManagerSosperson:string=""
  @State fileManagerSosphone:string=""
  @State fileManagerAccount:string=""
  @State dialogTitle:string=""
  @State clazzId:number=-1
  @State selectArr:SelectOption[]=[{value:"男"},{value:"女"}]
  @State selectArrCLass:SelectOption[]=[]
  @State valuee1:string=""
  @State valuee2:string=""
  @State selected1:number=-1
  @State selected2:number=-1
  @State textt:string=""
  @State titleName:string=""
  @State vib:Visibility=Visibility.Visible
  yuzhaotitle:string[]=yuzhaoTitle
  zaixiaotitle:string[]=zaixiaoTitle
  @State pageIndex:number=1//当前页数
  @State pageCount:number=0//总页数
  pageSize:number=8//一页显示8个数据
  @State yzDAData:fileManagerListClass[]=[]
  @State zxDAData:fileManagerListClass[]=[]
  @State fileManagerId:number=-1
  @State delId:number=-1

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
  let res=await classId()
  let findClass=res.find(item=>item.clazzName==this.valuee2)
  if (findClass){
    this.clazzId=findClass.clazzId
  }
  if (this.statu=="add"){
    await this.add()
    promptAction.showToast({
      message:"添加成功"
    })
  }else if(this.statu=="edit") {
    await this.editDA()
    promptAction.showToast({
      message:"修改成功"
    })
  }
}
 @Builder curArea(){
  if (this.titleName=="预招生档案"){
    Column(){
      Row(){
        textinputNavBar({
          rowTitle:"姓名:",
          inputText:this.fileManagerName,
          icon:"",
        })
        selectNavBar({
          rowTitle:"预报班级:",
          selectArr:this.selectArrCLass,
          selected:this.selected2,
          valuee:this.valuee2
        })
      }
      Row(){
        selectNavBar({
          rowTitle:"性别:",
          selectArr:this.selectArr,//
          selected:this.selected1,
          valuee:this.valuee1
        })
        Row(){
          Stack({alignContent:Alignment.TopEnd,}){
            textinputNavBar({
              rowTitle:"预报道日期:",
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
      }
      .margin({left:-280})

    }
    .margin({left:-40})
  }else if(this.titleName=="在校生/毕业生"){
    Column(){
      Row(){
        textinputNavBar({
          rowTitle:"姓名:",
          inputText:this.fileManagerName,
          icon:"",
          ena:this.dialogTitle =="在习生详情"?false:true
        })
        selectNavBar({
          rowTitle:"班级:",
          selectArr:this.selectArrCLass,
          selected:this.selected2,
          valuee:this.valuee2,
          ena:this.dialogTitle =="在习生详情"?false:true

        })
      }
      Row(){
        selectNavBar({
          rowTitle:"性别:",
          selectArr:this.selectArr,
          selected:this.selected1,
          valuee:this.valuee1,
          ena:this.dialogTitle =="在习生详情"?false:true
        })
        Row(){
          Stack({alignContent:Alignment.TopEnd,}){
            textinputNavBar({
              rowTitle:"毕业日期:",
              inputText:this.fileManagerDate,
              icon:"",
              ena:this.dialogTitle =="在习生详情"?false:true
            })
            Image("/images/data.png")
              .width(20)
              .position({top:23,left:255})
              .visibility(this.dialogTitle=="在习生详情"?Visibility.None:Visibility.Visible)

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
          icon:"",
          ena:this.dialogTitle =="在习生详情"?false:true
        })
        textinputNavBar({
          rowTitle:"家庭住址:",
          inputText:this.fileManagerAddress,
          icon:"",
          ena:this.dialogTitle =="在习生详情"?false:true
        })
      }
      Row(){
        textinputNavBar({
          rowTitle:"紧急联系人:",
          inputText:this.fileManagerSosperson,
          icon:"",
          ena:this.dialogTitle =="在习生详情"?false:true
        })
        textinputNavBar({
          rowTitle:"紧急联系人电话:",
          inputText:this.fileManagerSosphone,
          icon:"",
          ena:this.dialogTitle =="在习生详情"?false:true
        })
      }
      Row(){
        textinputNavBar({
          rowTitle:"账号:",
          inputText:this.fileManagerAccount,
          icon:"",
          ena:this.dialogTitle =="在习生详情"?false:true
        })
      }
      .margin({left:-285})

    }
    .margin({left:-40})
  }


 }
  async showYuzhao(){
    let dataset:stuDARequestClass={
      pageIndex:this.pageIndex,
      pageSize:this.pageSize,
      fileManagerType:"预招生",
      fileManagerName:this.textt
    }
    let res=await stuDAdel(dataset)
    this.pageCount=res.pageCount
    this.yzDAData=this.yzDAData.concat(res.fileManagerList)
    this.pageIndex++
  }
  async showZaixiao(){
    let dataset:stuDARequestClass={
      pageIndex:this.pageIndex,
      pageSize:this.pageSize,
      fileManagerType:"在习生",
      fileManagerName:this.textt
    }
    let res=await stuDAdel(dataset)
    this.pageCount=res.pageCount
    this.zxDAData=this.zxDAData.concat(res.fileManagerList)
    this.pageIndex++
  }
  async add(){
  if (this.titleName=="预招生档案"){
    let dataset:addDARequestCLass={
        fileManagerName:this.fileManagerName,
        fileManagerSex:this.valuee1,
        clazzId:this.clazzId,
       fileManagerDate:this.fileManagerDate,
       fileManagerPhone:this.fileManagerPhone,
       fileManagerType:"预招生"
    }
   let res=await addDA(dataset)
  }else if (this.titleName=="在校生/毕业生"){
    let dataset:addDARequestCLass={
      fileManagerName:this.fileManagerName,
      fileManagerSex:this.valuee1,
      clazzId:this.clazzId,
      fileManagerDate:this.fileManagerDate,
      fileManagerPhone:this.fileManagerPhone,
      fileManagerType:"在习生",
      fileManagerAccount:this.fileManagerAccount,
      fileManagerAddress:this.fileManagerAddress,
      fileManagerSosperson:this.fileManagerSosperson,
      fileManagerSosphone:this.fileManagerSosphone
    }
    let res=await addDA(dataset)
  }
  }
  async editDA(){
  if (this.titleName=="预招生档案"){
    let dataset:editDARequestClass= {
      fileManagerName: this.fileManagerName,
      fileManagerId: this.fileManagerId,
      fileManagerSex: this.valuee1,
      clazzId:this.clazzId,
      fileManagerDate: this.fileManagerDate,
      fileManagerPhone: this.fileManagerPhone,
    }
    let res=await editDA(dataset)
    console.log("----",JSON.stringify(dataset))
  }else if(this.titleName=="在校生/毕业生") {
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
  }
  async aboutToAppear(): Promise<void> {
      let res = await classId();
      for (let i = 0; i < res.length ; i++) {
        let obj:SelectOption={
          value: res[i].clazzName
        }
          this.selectArrCLass.push(obj)
      }
  }
  async delStudent(){
    let dataset:delRequestClass={
      fileManagerId:this.delId
    }
    let res=await delDA(dataset)
  }
  async detailStu(){
  let dataset:sDetailRequestClass={
    fileManagerId:this.fileManagerId
  }
  let res=await detailDA(dataset)
  }
  @Styles text(){
    .shadow({
      radius:15,
      color:"rgba(0,0,0,0.2)"
    })
    .width(250)
    .height(180)
    .backgroundColor(Color.White)
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
  build() {
    Column(){

      Stack({alignContent:Alignment.Top}){
       //1.预招生/在校生
        Column(){
          Stack({alignContent:Alignment.TopStart}){
            //标题
              newrightTop({
                titleName:this.titleName
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
                  if(this.titleName=="预招生档案"){
                    this.yzDAData=[]
                    await this.showYuzhao()
                  }else {
                    this.zxDAData=[]
                    await this.showZaixiao()
                  }


                })
              Image("/images/add.png")
                .width(22)
                .margin({left:340,right:15})
                .onClick(async ()=>{
                  this.dialogTitle=this.titleName=="预招生档案"?"添加预招生":"添加在习生"
                  this.pageIndex=1
                  this.statu="add"
                  this.customDialogCon.open()
                })
            }
            .position({left:140,top:15})//木4
        }
        //正文内容
          Column(){
            //xiao标题
            Row(){
                ForEach(this.titleName=="预招生档案"?this.yuzhaotitle:this.zaixiaotitle,(item:string)=>{
                  Row(){
                    Text(item)
                      .fontWeight(600)
                      .textAlign(TextAlign.Center)
                      .onClick(()=>{
                          this.vib=Visibility.Visible
                      })
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
                        ForEach(this.titleName=="预招生档案"?this.yzDAData:this.zxDAData,(item:fileManagerListClass,index:number)=>{
                            Row(){
                                if (this.titleName=="预招生档案") {
                                  Text(item.fileManagerName)
                                    .textGlobalClass()
                                  Text(item.fileManagerSex)
                                    .textGlobalClass()
                                  Text(item.clazzName)
                                    .textGlobalClass()
                                  Text(item.fileManagerDate)
                                    .textGlobalClass()
                                  Text(item.fileManagerPhone)
                                    .textGlobalClass()
                                }else  if(this.titleName=="在校生/毕业生"){
                                  Text(item.fileManagerName)
                                    .textGlobalClass()
                                  Text(item.fileManagerSex)
                                    .textGlobalClass()
                                  Text(item.clazzName)
                                    .textGlobalClass()
                                  Text(item.fileManagerDate)
                                    .textGlobalClass()
                                  Text(item.fileManagerPhone)
                                    .textGlobalClass()
                                  Text(item.fileManagerStatus)
                                    .textGlobalClass()
                                    .fontColor(item.fileManagerStatus=="已毕业"?Color.Green:Color.Red)
                                }
                                  Row(){
                                    Text("修改")
                                      .fontSize(14)
                                      .fontColor(Color.Green)
                                      .textAlign(TextAlign.Center)
                                      .onClick(()=>{
                                        this.dialogTitle=this.titleName=="预招生档案"?"修改预招生":"修改在习生"
                                        this.customDialogCon.open()
                                        this.statu="edit"
                                        this.fileManagerName=item.fileManagerName
                                        this.fileManagerId=this.titleName=="预招生档案"?this.yzDAData[index].fileManagerId:this.zxDAData[index].fileManagerId
                                        this.fileManagerAccount=item.fileManagerAccount
                                        this.valuee1=item.fileManagerSex
                                        this.clazzId=item.clazzId
                                        this.fileManagerAddress=item.fileManagerAddress
                                        this.fileManagerSosperson=item.fileManagerSosperson
                                        this.fileManagerSosphone=item.fileManagerSosphone
                                        this.fileManagerDate=item.fileManagerDate
                                        this.fileManagerPhone=item.fileManagerPhone
                                        this.valuee2=item.clazzName
                                      })
                                    Text("删除")
                                      .fontSize(14)
                                      .fontColor(Color.Red)
                                      .textAlign(TextAlign.Center)
                                      .margin({left:20})
                                      .onClick(async ()=>{
                                        this.delId=item.fileManagerId
                                        await this.delStudent()
                                        promptAction.showToast({
                                          message:"删除成功"
                                        })

                                      })
                                  }
                                  .width(89)
                                  .height(50)
                              if (this.titleName=="在校生/毕业生"){
                                Text("详情")
                                  .fontColor(Color.Blue)
                                  .textGlobalClass()
                                  .fontColor(Color.Blue)
                                  .onClick(async ()=>{
                                    this.dialogTitle="在习生详情"
                                    this.fileManagerName=item.fileManagerName
                                    this.fileManagerId=item.fileManagerId
                                    this.fileManagerAccount=item.fileManagerAccount
                                    this.valuee1=item.fileManagerSex
                                    this.clazzId=item.clazzId
                                    this.fileManagerAddress=item.fileManagerAddress
                                    this.fileManagerSosperson=item.fileManagerSosperson
                                    this.fileManagerSosphone=item.fileManagerSosphone
                                    this.fileManagerDate=item.fileManagerDate
                                    this.fileManagerPhone=item.fileManagerPhone
                                    this.valuee2=item.clazzName
                                      this.customDialogCon.open()

                                  })
                              }
                            }
                            .height(50)
                            .width("100%")
                            .padding({bottom:20})
                            .justifyContent(FlexAlign.SpaceBetween)
                        })
                    }
                }
                //显示刷新和文字
                ListItem(){
                  if(this.titleName=="预招生档案"){
                    if(this.yzDAData.length>=this.pageSize){
                      Row(){
                        this.bottomTip()
                      }
                      .width("100%")
                    }

                  }else if(this.titleName=="在校生/毕业生") {
                    if (this.zxDAData.length>=this.pageSize){
                      Row(){
                        this.bottomTip()
                      }
                      .width("100%")
                    }
                  }
                }
            }
            .edgeEffect(EdgeEffect.Fade)
            .height("calc(100% - 60vp)")
            .onReachEnd(async ()=>{
              if (this.pageIndex<=this.pageCount){
                setTimeout(async ()=>{
                    this.titleName=="预招生档案"?await this.showYuzhao():await this.showZaixiao()
                },500)
              }
            })


          }
          .width("95%")
          .height("calc(100% - 80vp)")
          .backgroundColor(Color.White)
          .position({top:65,left:5})
          .padding({left:10,right:10})
        }

        //2.选择
        Column(){
          Row({space:20}){
            Column({space:10}){
              Text("预招生")
                .margin({top:70})
              Text("查看详情")
                .fontColor(Color.Blue)
                .fontSize(13)
            }
            .text()
            .onClick(async ()=>{
              this.yzDAData=[]
              this.pageIndex=1
              this.titleName="预招生档案"
              await this.showYuzhao();
              this.vib=Visibility.None




            })
            Column({space:10}){
              Text("在习生/毕业生档案")
                .margin({top:70})
              Text("查看详情")
                .fontColor(Color.Blue)
                .fontSize(13)
            }
            .onClick(async ()=>{
              this.zxDAData=[]
              this.pageIndex=1
              this.titleName="在校生/毕业生"
              await this.showZaixiao();
              this.vib=Visibility.None
            })
            .text()
          }
          .margin({top:150})
        }
        .visibility(this.vib)
        .width("100%")
        .height("100%")
        .backgroundColor("#f5f9fa")


      }


    }
    .width("100%")

    .height("100%")
    .visibility(this.curIndex==3?Visibility.Visible:Visibility.None)
    .backgroundColor("#f5f9fa")
  }
}
export {stuDANavBar}