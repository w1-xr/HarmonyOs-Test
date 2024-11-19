import { loginRequestClass } from '../models'
import { router } from '@kit.ArkUI'
import { Login } from '../api'

@Extend(TextInput) function textGlobalClass(){
  .backgroundColor(Color.White)
  .borderRadius(0)
  .border({width:1,color:"#b4b4b4"})
  .placeholderColor("#d9d9d9")
}
@Entry
@Component
struct BaoerADLogin {
  @State userAccount:string="xiaowangS"
  @State userPassword:string="123456"
  @State flaguser:boolean=false
  @State flagpwd:boolean=false
  build() {
    Stack({alignContent:Alignment.Center}){
      Image("/images/login.png")
        .width("100%")
        .height("100%")
      Row(){
        Row(){
          Image("/images/baoer.png")//保尔
            .height(70)
        }

        .shadow({
          color:"rgba(0,0,0,0.3)",
          radius:15
        })
        .justifyContent(FlexAlign.Center)
        .backgroundColor("#e7f2f8")
        .width("50%")
        .height("100%")
        Column({space:20}){
          Text("保尔科技办公自动化平台")
            .fontSize(20)
            .fontWeight(700)
          TextInput({
            placeholder:"用户账号",
            text:$$this.userAccount
          })
            .textGlobalClass()
          TextInput({
            placeholder:"用户密码",
            text:$$this.userPassword
          })
            .textGlobalClass()

          Button("登录")
            .width(330)
            .height(42)
            .backgroundColor("#0f6ab1")
            .borderRadius(1)
            .enabled(true)
            .onClick(async ()=>{

              let dataset:loginRequestClass={
                userAccount:this.userAccount,
                userPassword:this.userPassword
              }
              let res=await Login(dataset)
              AppStorage.setOrCreate("userId",res.userInfo.userId)
              AppStorage.setOrCreate('userRole', res.userInfo.userRole)
              AppStorage.setOrCreate("userName",res.userInfo.userName)
              AppStorage.setOrCreate("userAccount",res.userInfo.userAccount)
              AppStorage.setOrCreate("userPassword",res.userInfo.userPassword)
              AppStorage.setOrCreate("userSex",res.userInfo.userSex)
              AppStorage.setOrCreate("userPhone",res.userInfo.userPhone)
              AppStorage.setOrCreate("userRole",res.userInfo.userRole)
              AppStorage.setOrCreate("deptId",res.userInfo.deptId)
              if (res.userInfo.userId){
                if (res.userInfo) {
                  switch (res.userInfo.userRole) {
                    case '管理员':
                      router.replaceUrl({
                        url:"pages/ADIndex"
                      })
                      break;
                    case '老师':
                      router.replaceUrl({
                        url: 'pages/classIndex'
                      })
                      break;

                    default:
                      router.replaceUrl({
                        url: 'pages/StuIndex'
                      })
                      break;
                  }
                }

              }else {
                console.log("xxxxxx")//
              }
            })//


        }
        .shadow({
          color:"rgba(0,0,0,0.3)",
          radius:10
        })
        .backgroundColor(Color.White)
        .padding(40)
        .height("100%")
        .width("50%")
      }
      .height("50%")
      .width("80%")
    }

  }
}