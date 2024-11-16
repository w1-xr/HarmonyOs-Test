import { dailyKQNavBar } from '../components/dailyKQ'
import { MainCom } from '../components/T/MainCom'

@Entry
@Component
struct DailyKQIndex {
  @StorageLink("userRole") userRole:string=""
  @State curIndex:number=this.userRole=="学生"?2:1
  @State curIndexTwo:number=2
  build() {
    Column(){
      MainCom({
        curIndex:this.curIndex,
        curIndexTwo:this.curIndexTwo
      }){
        dailyKQNavBar({
          curIndex:1,
          curIndextwo:2
        })
      }
    }
    .width("100%")
    .height("100%")
  }
}