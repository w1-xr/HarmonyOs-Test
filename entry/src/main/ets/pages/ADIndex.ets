import { Class } from '../api/class'
import { IndexNavBar } from '../components/Index'
import { silderData } from '../constants'
import { silderDataClass } from '../models/classManagement'
import { router, Router } from '@kit.ArkUI'

@Entry
@Component
struct baoerADIndex {
  curdata:string=new Date().toLocaleString()
  silderData:silderDataClass[]=silderData
  @StorageLink("userName") userName:string=""
  build() {
    Stack({alignContent:Alignment.Top}){
      //头部
      Row(){
        Image("/images/baoer.png")
          .height("50%")
        Row(){
          Text(this.curdata)
            .layoutWeight(1)
            .textAlign(TextAlign.End)
          Image("/images/reflesh.png")
            .width(25)
            .margin({left:20,right:30})//

          Image("/images/my.png")
            .width(23)
          Text(this.userName)
            .margin({left:5})
            .fontSize(18)
          Image("/images/tuichu.png")
            .width(23)
            .margin({left:30})
            .onClick(()=>{
             router.clear()
              AppStorage.clear()
              router.replaceUrl({
                url:"pages/ADLogin"
              })
            })
        }
        .layoutWeight(1)
      }
      .backgroundColor(Color.White) //
      .width("100%")
      .padding({left:40,right:30})
      .height(80)
      //侧边栏和内容区
      IndexNavBar({
        silderData:this.silderData
      })
    }
  }
}