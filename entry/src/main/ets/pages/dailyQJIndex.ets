import { dailyQJNavBar } from '../components/dailyQJ'
import { MainCom } from '../components/T/MainCom'

@Entry
@Component
struct DailyQJIndex {
  @State curIndex:number=1
  @State curIndexTwo:number=1
  build() {
    Column(){
      MainCom({
        curIndex:this.curIndex,
        curIndexTwo:this.curIndexTwo
      }){
        dailyQJNavBar({
          curIndex:1,
          curIndextwo:1,
          newState:true
        })

      }
    }
    .width("100%")
    .height("100%")
  }
}