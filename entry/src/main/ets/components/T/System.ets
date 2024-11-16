import { selectNavBar } from '../../dialog/select'
import { textinputNavBar } from '../../dialog/textinput'
import { promptAction } from '@kit.ArkUI'
import { editUserRequestClass, loginRequestClass } from '../../models'
import { Edit, Login } from '../../api'

@Component
struct System{
@Prop curIndex:number
  @State selectArr:SelectOption[]=[{value:"男"},{value:"女"}]
  @State selectArrCLass:SelectOption[]=[]
  @State selected1:number=-1
  @State pwd:number|string=""
  @StorageLink("userName") userName:string=""
  @StorageLink("userId") userId:number=-1
  @StorageLink("userSex") userSex:string=""
  @StorageLink("userPhone") userPhone:string=""
  @StorageLink("userPassword") userPassword:string=""
  @StorageLink("userAccount") userAccount:string=""
  aboutToAppear(): void {
  if (this.userSex){
    this.selected1=this.userSex=="男"?0:1
  }
}
  build() {
    Column(){
      Column(){
        Row(){
          textinputNavBar({
            rowTitle:"姓名:",
            inputText:this.userName,
            icon:"",
          })
          selectNavBar({
            rowTitle:"性别:",
            selectArr:this.selectArr,//
            selected:this.selected1,
            valuee:this.userSex
          })
        }
        Row(){
          textinputNavBar({
            rowTitle:"电话:",
            inputText:this.userPhone,
            icon:"",
          })
          textinputNavBar({
            rowTitle:"账号:",
            inputText:this.userAccount,
            icon:"",
          })
        }
        Row(){
          textinputNavBar({
          rowTitle:"密码:",
          inputText:this.pwd,
          icon:"",
        })
        }
        .margin({left:-280})
        Text("修改")
          .fontColor(Color.White)
          .backgroundColor(Color.Blue)
          .padding({left:20,right:20,top:5,bottom:5})
          .margin({top:30})
          .onClick(async ()=>{
            let dataset:editUserRequestClass={
              userId:this.userId,
              userName:this.userName,
              userPassword:this.pwd+"",
              userAccount:this.userAccount,
              userPhone:this.userPhone,
              userSex :this.selected1,

            }
            console.log(JSON.stringify(dataset))
            if (this.userName=="" || this.userSex=="" || this.userPhone=="" || this.pwd=="" ||this.userAccount==""){
              promptAction.showToast({
                message:"值不能为空"
              })
            }else {
              await Edit(dataset)
              promptAction.showToast({
                message:"修改成功"
              })
              this.pwd=""
            }


          })

      }
      .backgroundColor(Color.White)
      .width(620)
      .margin({top:120})
      .padding({top:30,bottom:30,right:20})
    }
    .width("100%")
    .height("100%")
    .visibility(this.curIndex==7?Visibility.Visible:Visibility.None)
    .backgroundColor("#f5f9fa")
  }
}
export {System}