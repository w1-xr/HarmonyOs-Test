import { MainCom } from '../components/T/MainCom'
import { System } from '../components/T/System'

@Entry
@Component
struct SystemIndex {
  @StorageLink("userRole") userRole:string=""
  @State curIndex:number=this.userRole=="学生"?5:3
  build() {
    Column(){
      MainCom({
        curIndex:this.curIndex,
      }){
        System({
          curIndex:7,

        })
      }
    }
    .width("100%")
    .height("100%")
  }
}