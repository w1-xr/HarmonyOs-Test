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
         Column(){
           Image("/images/dog.png")
             .height("80%")
           Text("欢迎来到保尔科技公司")
             .fontSize(30)
             .fontWeight(600)
         }
         .width("100%")
         .height("100%")
      }

    }
    .width("100%")
    .height("100%")
  }

}