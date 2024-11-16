import { dailyNavBar } from '../components/daily'
import { MainCom } from '../components/T/MainCom'

@Entry
@Component
struct StuIndex {
  @StorageLink("userRole") userRole:string=""
  @State curIndex:number=this.userRole=="学生"?0:1
  @State curIndexTwo:number=-1
  build() {
    Column(){
      MainCom({
        curIndex:this.curIndex,
        curIndexTwo:this.curIndexTwo

      }){
         Text("握手首页")
      }

    }
    .width("100%")
    .height("100%")
  }

}