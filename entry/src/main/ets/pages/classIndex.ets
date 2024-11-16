import { classNavBar } from '../components/classManagement'
import { MainCom } from '../components/T/MainCom'

@Entry
@Component
struct ClassIndex {
@State curIndex:number=0
@State curIndexTwo:number=-1
  build() {
     Column(){
       MainCom({
         curIndex:this.curIndex,
         curIndexTwo:this.curIndexTwo
       }
       ){
         classNavBar({
           curIndex:this.curIndex,
         })
       }
     }
     .width("100%")
     .height("100%")
  }
}