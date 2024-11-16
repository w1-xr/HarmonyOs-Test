import { pass, shenHe } from '../api/shenhe'
import { shenheTitle } from '../constants'
import { passRequestClass, shenheDataClass } from '../models/shenhe'
import { LoadingIcon } from '../utils/LoadingIcon'
import { newrightTop } from './newrightTop'
import { promptAction } from '@kit.ArkUI'

@Extend(Text) function textGlobalClass(){
  .fontSize(14)
  .fontColor("#616161")
  .width(89)
  .height(50)
  .textAlign(TextAlign.Center)
}
@Component
struct shenheNavBar{
  @Prop curIndex:number
  @LocalStorageLink("userId") examine:number=-1
  @State vacationId:number=-1
  @State pageIndex:number=1
   pageSize:number=8
  @State pageCount:number=-1
  @State Passstatus:number=-1
  smallTitle:string[]=shenheTitle
  @State shenheData:shenheDataClass[]=[]
  @Builder bottomTip(){
    Column(){
      if(this.pageIndex<this.pageCount){
        LoadingIcon()
      }
      Text(this.pageIndex<=this.pageCount ? "加载中" : "没有更多了~~~~~")
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
  }

  async showshenheList(){
   let res=await shenHe()
    this.shenheData=this.shenheData.concat(res)
  }
  async pass(){
    let dataset:passRequestClass={
      vacationId:this.vacationId,
      status:this.Passstatus,
      examine:this.examine
    }
    let res=await pass(dataset)
  }
 async  aboutToAppear(): Promise<void> {
   await this.showshenheList()
  }

  build() {
  Column(){
    //1.标题
      newrightTop({
        titleName:"审核系统"
      })

    //2.内容
    List(){
        ListItem(){
          Column(){
            //2.1小标题
            Row(){
              ForEach(this.smallTitle, (item: string) => {
                Row() {
                  Text(item)
                    .fontWeight(600)
                    .textAlign(TextAlign.Center)
                }
                .justifyContent(FlexAlign.Center)
                .width(89)
              })
            }
            .width("100%")
            .height("11%")
            .padding({top:15,bottom:15})
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Top)
            //2.2接口内容
            List(){
              ForEach(this.shenheData,(item:shenheDataClass,index:number)=>{
                ListItem(){
                  Row(){
                    Text(item.userId)
                      .textGlobalClass()
                    Text(item.vacationCount)
                      .textGlobalClass()
                    Text(item.identify)
                      .textGlobalClass()
                    Text(item.vacationDate+"-"+item.endDate)
                      .textGlobalClass()
                    Row(){
                      Text("通过")
                        .fontSize(14)
                        .fontColor(Color.Green)
                        .textAlign(TextAlign.Center)
                        .onClick(()=>{
                          this.Passstatus=1
                          this.vacationId=this.shenheData[index].vacationId
                          this.pass()
                        })
                      Text("不通过")
                        .fontSize(14)
                        .fontColor(Color.Red)
                        .textAlign(TextAlign.Center)
                        .margin({left:10})
                        .onClick(async ()=>{
                          this.Passstatus=0
                          this.vacationId=this.shenheData[index].vacationId
                          await this.pass()
                          promptAction.showToast({
                            message: "已通过"

                          })
                        })
                    }
                    .width(89)
                    .height(50)
                  }
                  .height(50)
                  .width("100%")
                  .padding({bottom:20})
                  .justifyContent(FlexAlign.SpaceBetween)
                }
              })
              ListItem(){
                if (this.shenheData.length>=this.pageSize){
                  Row(){
                    this.bottomTip()
                  }
                  .width("100%")

                }
              }
            }
            .edgeEffect(EdgeEffect.Fade)
            .height("clac(100% - 60vp)")
            .onReachEnd(async ()=>{
              if (this.pageIndex<=this.pageCount){
                setTimeout(async ()=>{
                  await this.showshenheList()
                },500)
              }
            })
            .listDirection(Axis.Vertical)
            .backgroundColor(Color.White)
            .width("100%")


          }
          // .width("95%")
          // .height("calc(100% - 80vp)")
          // .backgroundColor(Color.White)
          // .position({top:65,left:20})
          // .padding({left:10,right:10})
        }
    }
    .edgeEffect(EdgeEffect.Fade)
    .width("95%")
    .height("calc(100% - 80vp)")
    .backgroundColor(Color.White)
    .position({top:65,left:20})
    .padding({left:10,right:10})
  }
  .width("100%")
  .height("100%")
  .visibility(this.curIndex==5?Visibility.Visible:Visibility.None)
  .backgroundColor("#f5f9fa")
  }
}
export {shenheNavBar}