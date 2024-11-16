import { addUser, Delete, Dept, Edit, User } from '../api/user'
import { userTitle } from '../constants'
import {editUserRequestClass, userListClass, userRequestClass } from '../models/user'
import { LoadingIcon } from '../utils/LoadingIcon'
import { MyDialog } from '../utils/myDialog'
import { newrightTop } from './newrightTop'
import { promptAction } from '@kit.ArkUI'

class content{
  title:string=""
  text:string=""
  icon?:string=""
}
class selectContent{
  title:string=""
  arr:SelectOption[]=[]
  selected:number=0
}
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
struct UserNavBar{
  @State flagg:boolean=false
  @Prop curIndex:number
  @Prop editIndex:number
  @State dialogTitle:string=""
  @State textt:string=""
  @State flag:boolean=false
  @State userName:string=""
  @State userAccount:string=""
  @State userPassword:string=""
  @State userSex:string=""//性别
  @State deptId:string=""//部门
  @State userPhone:string=""//电话
  @State userRole:string=""//用户身份
  @State userId:number=-1
  @State value:string=""
  @State selected:number=0
  @State boxFlag:boolean=false
  @State znArr:SelectOption[]=[{value:"管理员"},{value:"老师"},{value:"学生"}]//用户身份
  @State deptArr:SelectOption[]=[{value:""},{value:""},{value:""}]//用户身份
  @State sexArr:SelectOption[]=[{value:"男"},{value:"女"}]//用户身份
  @State date:string=new Date().toLocaleDateString()
  @State pageIndex:number=1;//当前的页数；
  @State pageCount:number=0;//总页数；
  pageSize:number=8;//一页显示多少条数据；
  userTitle:string[]=userTitle
  @State userData:userListClass[]=[]
  @State delArr: number[] = [];
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
      confirmFn:()=>{this.curConfirmfn()},
      cancleFn:()=>{this.cancle()}
    }),
    cornerRadius:0,
    width:620,
    offset:{
      dx:100,
      dy:20
    }
  })
  cancle(){
    this.editResult()
  }
@Builder textinput($$:content){
  Row() {
    Row(){
      Text($$.title)
    }
    .width(70)
    .justifyContent(FlexAlign.End)
    .margin({right:15})
    Row() {
      TextInput({
        text:$$.text
      })
        .onChange((value:string)=>{
          if($$.title=="姓名:"){
            this.userName=value
          }else if($$.title=="账号:"){
           this.userAccount=value
          }else if($$.title=="密码:"){
            this.userPassword=value
          }else if ($$.title=="电话:"){
            this.userPhone=value
          }
        })
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .height(35)
      Image($$.icon)
        .width(15)
    }
    .padding({right:10})
    .width(200)
    .border({
      width: $$.title=="账号"?0:1,
      color: "#b4b4b4"
    })
  }
  .margin({right:15,top:15})
  .backgroundColor(Color.White)
  .width(270)
  .height(35)
  .alignItems(VerticalAlign.Center)
}
  @Builder select($$:selectContent){
    Row() {
      Row(){
        Text($$.title)
      }
      .width(70)
      .justifyContent(FlexAlign.End)
      .margin({right:15})
      Row() {
        Row(){
          Select($$.arr)
            .value($$.arr[$$.selected].value)
            .selected($$.selected)
            .backgroundColor(Color.Transparent)
            .layoutWeight(1)
            .height(35)
            .onSelect((index:number,value:string)=>{
              if ($$.arr===this.sexArr){
                this.userSex=index+""
              }else if($$.arr===this.deptArr){
              this.deptId=index+""
              }else if ($$.arr===this.znArr){
                this.userRole=(index)+""
              }
            })
        }
          .layoutWeight(1)
      }
      .padding({right:10})
      .width(200)
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
  // xiaowang
  getIndex(arr: SelectOption[], value: string) {
    let index = arr.findIndex(item => item.value == value);
    return index == -1 ? "" : index + "";
  }
editResult(item:userListClass | undefined=undefined){
  this.userName=item?item.userName!:""
  this.userPhone=item?item.userPhone!:""
  this.userAccount=item?item.userAccount!:""
  this.userSex=item? this.getIndex(this.sexArr, item.userSex) : ""
  this.userRole=item? this.getIndex(this.znArr, item.userRole) :""
  this.deptId=item?this.getIndex(this.deptArr, item.deptId!):""
}
@Builder curArea(){
  Column() {
    Row() {
      this.textinput({title:"姓名:", icon:"", text:this.userName})
      this.select({title:"部门:",arr:this.deptArr, selected:Number(this.deptId)})
    }
    Row() {
      this.select({title:"性别:",arr:this.sexArr, selected:Number(this.userSex)})
      this.select({title:"职能:",arr:this.znArr, selected:Number(this.userRole)})
    }
    Row() {
      this.textinput({title:"账号:", icon:"", text:this.userAccount})
      this.textinput({title:"电话:", icon:"", text:this.userPhone})
    }
    Row() {
      this.textinput({title:"密码:", icon:"/images/del.png", text:this.userPassword})
    }
    .margin({left:-285})
  }
}
  async curConfirmfn(){
    let dataset:editUserRequestClass={
      userId:this.userId,
      userName:this.userName,
      userPassword:this.userPassword,
      userAccount:this.userAccount,
      userPhone:this.userPhone,
      userSex :this.userSex,
      userRole : 2+"",
      deptId : (parseInt(this.deptId) + 1) + "",
    }
    if(this.dialogTitle=="添加用户"){
       await this.addUser(dataset)
      promptAction.showToast({
        message:"添加成功"
      })
    }else  if(this.dialogTitle=="修改用户"){
      await this.editUser(dataset)
      promptAction.showToast({
        message:"修改成功"
      })
    }
    this.editResult();
  }
  async showuser(){
    //日常正文
    let dataset:userRequestClass={
      userName:this.textt,
      pageSize:this.pageSize,
      pageIndex:this.pageIndex
    }
    let res= await User(dataset)
    this.pageCount=res.pageCount
    this.userData=this.userData.concat(res.userList)
    this.pageIndex++
  }
  async addUser(dataset:editUserRequestClass){
    let res=await addUser(dataset)
}
  async editUser(dataset:editUserRequestClass){
    let res=await Edit(dataset)

  }
  async delete(){
    let dataset:number=this.userId
     let res=await Delete(dataset)
  }
  async aboutToAppear(): Promise<void> {
    await this.showuser()
    let res=await Dept()
    let j=0
    for (let i =0;i<res.length && j<this.deptArr.length;i++,j++){
        this.deptArr[j].value=res[i].deptName
    }
  }

  build() {
    Column(){
      //标题
      Stack({alignContent:Alignment.TopStart}){
        newrightTop({
          titleName:"用户管理"
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
            .onChange(async ()=>{
              if(this.textt==""){
               await this.showuser()
              }
            })
          Text("搜索")
            .backgroundColor("#0f6ab1")
            .fontColor(Color.White)
            .padding({left:15,right:15,top:5,bottom:5})
            .margin({left:15})
            .onClick(async ()=>{
              this.pageIndex=1
              this.userData=[]
              await this.showuser()
            })
          Image("/images/add.png")
            .width(22)
            .margin({left:340,right:15})
            .onClick(async ()=>{
              this.dialogTitle="添加用户"
              this.customDialogCon.open()
            })
          Image("/images/del.png")
            .onClick(async () => {
              for (let id of this.delArr) {
                this.userId = id
                await this.delete()
              }
              promptAction.showToast({
                message: '删除成功'
              })
            })
            .width(22)
        }
        .position({left:100,top:15})//木4
      }
      //正文内容
      Column(){
        //xiao标题
        Row(){
          ForEach(this.userTitle,(item:string)=>{
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
              ForEach(this.userData,(item:userListClass,index:number)=>{
                Row(){
                  Row(){
                    Checkbox({
                      name:item.userId+"",
                      group:"box"
                    })
                      .select(this.boxFlag)
                      .onChange((res) => {
                        if (res) {
                          this.delArr.push(item.userId);
                        } else {
                          this.delArr.splice(this.delArr.findIndex(data => data == item.userId), 1);
                        }
                      })
                  }
                  .padding({left:30})
                  .width(89)
                  .height(50)
                  Text(item.userName)
                    .textGlobalClass()
                  Text(item.deptId)
                    .textGlobalClass()
                  Text(item.userSex)
                    .textGlobalClass()
                  Text(item.userPhone)
                    .textGlobalClass()
                  Text(item.userRole)
                    .textGlobalClass()
                  Row(){
                    Text("修改")
                      .fontSize(14)
                      .fontColor(Color.Green)
                      .textAlign(TextAlign.Center)
                      .onClick(()=>{
                        this.dialogTitle="修改用户"
                        this.userId=item.userId
                        this.editResult(item)
                        this.editIndex=index
                        this.customDialogCon.open()

                      })
                    Text("删除")
                      .fontSize(14)
                      .fontColor(Color.Red)
                      .textAlign(TextAlign.Center)
                      .margin({left:20})
                      .onClick(async ()=>{
                        this.userId=item.userId
                        await this.delete()
                        promptAction.showToast({
                          message:"删除成功"
                        })
                        this.userData.splice(index,1)

                      })
                  }
                  .width(89)
                  .height(50)

                }
                .height(50)
                .width("100%")
                .padding({bottom:20})
                .justifyContent(FlexAlign.SpaceBetween)
              })
            }
          }
          ListItem(){
            if (this.userData.length >= this.pageSize)
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
              await this.showuser()
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
    .visibility(this.curIndex==2?Visibility.Visible:Visibility.None)
    .backgroundColor("#f5f9fa")
  }
}
export {UserNavBar}