import { dailyNavBar } from '../components/daily'
import { MainCom } from '../components/T/MainCom'

@Entry
@Component
struct dailyIndex {
  @State curIndex:number=1
  @State curIndexTwo:number=-1
  build() {
    Column(){
      MainCom({
        curIndex:this.curIndex,
        curIndexTwo:this.curIndexTwo

      }){
       dailyNavBar({
         curIndex:this.curIndex,
         curIndextwo:this.curIndexTwo,
         newState:true
       })
      }
    }
    .width("100%")
    .height("100%")
  }

}