import { LeftNavCom } from './LeftNavCom'
import { TopNav } from './TopNav'

@Component
struct MainCom{
  @Builder init(){}
  @BuilderParam content:()=>void=this.init
  @Prop curIndex:number=0
  @Prop curIndexTwo:number=-1
  build() {
     Column(){
       //上
      TopNav()
       //下（左右）
       Row(){
          //侧边栏
         LeftNavCom({
           curIndex:this.curIndex,
           curIndexTwo:this.curIndexTwo
         })
          //内容区
          this.content()
       }
       .layoutWeight(1)
       .padding({right:155})
       .width("100%")
       .height("100%")
     }
     .width("100%")
    .height("100%")
  }
}
export {MainCom}