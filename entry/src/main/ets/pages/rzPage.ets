import { dailyKQNavBar } from '../components/dailyKQ'
import { RZNavBar } from '../components/RZ'
import { MainCom } from '../components/T/MainCom'

@Entry
@Component
struct rzPage {
  @State curIndex:number=3
  @State curIndexTwo:number=2
  build() {
    Column(){
      MainCom({
        curIndex:this.curIndex,
        curIndexTwo:this.curIndexTwo
      }){
        RZNavBar({
          curIndex:4,
        })
      }
    }
    .width("100%")
    .height("100%")
  }
}