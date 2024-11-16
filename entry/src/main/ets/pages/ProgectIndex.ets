import { PFather } from '../components/PFather'
import { MainCom } from '../components/T/MainCom'

@Entry
@Component
struct ProgectIndex {
  @StorageLink("userRole") userRole:string=""
  @State curIndex:number=this.userRole=="学生"?4:2
  build() {
    Column(){
      MainCom({
        curIndex:this.curIndex,
      }){
        PFather({
          curIndex:6,
        })
      }
    }
    .width("100%")
    .height("100%")
  }
}