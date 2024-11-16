import { dailyCCNavBar } from '../components/dailyCC'
import { MainCom } from '../components/T/MainCom'

@Entry
@Component
struct DailyCCIndex {
  @State curIndex:number=1
  @State curIndexTwo:number=0
  build() {
    Column(){
      MainCom({
        curIndex:this.curIndex,
        curIndexTwo:this.curIndexTwo
      }){
        dailyCCNavBar({
          curIndex:1,
          curIndextwo:0,
          newState:true
        })
      }
    }
    .width("100%")
    .height("100%")
  }
}