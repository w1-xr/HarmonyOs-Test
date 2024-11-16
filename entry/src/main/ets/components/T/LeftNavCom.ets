import { silderDataStu, silderDatatwo } from '../../constants'
import { silderDataClass, twoClass } from '../../models'
import { router } from '@kit.ArkUI'

@Extend(Text) function textglo(){
  .margin({left:15})
}
@Component
struct LeftNavCom{
  silderDatatwo: silderDataClass[]=silderDatatwo
  silderDataStu: silderDataClass[]=silderDataStu
  @StorageLink("userRole") userRole:string=""
  @Prop curIndex:number=0
  @Prop curIndexTwo:number=-1
  @State vib:Visibility= this.curIndex == 1 ? Visibility.Visible : Visibility.None
  build() {
    if(this.userRole=="老师"){
      //侧边栏
      Column(){
        ForEach(this.silderDatatwo,(item:silderDataClass,index:number)=>{
          Column(){
            Row(){
              Image(this.curIndex==index?item.selectedicon:item.icon)
                .width(20)
              Text(item.title)
                .textglo()
                .fontColor(this.curIndex==index?"#0f6ab3":Color.Black)
                .fontSize(this.curIndex==index?23:20)
              Image(this.curIndex==1?item.icon3:item.icon2)
                .width(13)
                .margin({left:-15})
            }
            .border({
              width:{
                right:this.curIndex==index?4:0
              },
              color:"#0f6ab1"
            })
            .justifyContent(FlexAlign.Center)
            .width("100%")
            .height(50)
            .backgroundColor(this.curIndex==index?"#e7f0f7":Color.White)
            .onClick(()=>{
              if (this.curIndex != index) {
                this.curIndex=index
                if (this.curIndex === 0) {
                  router.replaceUrl({ url: "pages/classIndex" });
                } else if (this.curIndex == 1) {
                  router.replaceUrl({ url: "pages/dailyIndex" });
                } else if (this.curIndex === 2) {
                  router.replaceUrl({ url: "pages/ProgectIndex" });
                } else if (this.curIndex === 3) {
                  router.replaceUrl({ url: "pages/SystemIndex" });
                }
              } else if (this.curIndex == 1) {
                this.vib = this.vib == Visibility.Visible ? Visibility.None : Visibility.Visible;
              }
            })
            //二级
            ForEach(item.two,(item2:twoClass,index:number)=>{
              Column(){
                Text(item2.title)
                  .height(35)
                  .fontSize(18)
                  .fontColor(this.curIndexTwo==index?"#0f6ab3":Color.Black)
                  .onClick(()=>{
                    this.curIndexTwo=index
                    if (this.curIndex === 1) {
                      if (this.curIndexTwo === 0) {
                        router.replaceUrl({ url: "pages/dailyCCIndex" });
                      } else if (this.curIndexTwo === 2) {
                        router.replaceUrl({ url: "pages/dailyKQIndex" });
                      } else if (this.curIndexTwo === 1) {
                        router.replaceUrl({ url: "pages/dailyQJIndex" });
                      }
                    }
                  })

              }
              .visibility(this.vib)
            })
          }

        })
      }
      .width("18%")
      .height("100%")
    }else if(this.userRole=="学生"){
      //侧边栏
      Column(){
        ForEach(this.silderDataStu,(item:silderDataClass,index:number)=>{
          Column(){
            Row(){
              Image(this.curIndex==index?item.selectedicon:item.icon)
                .width(20)
              Text(item.title)
                .textglo()
                .fontColor(this.curIndex==index?"#0f6ab3":Color.Black)
                .fontSize(this.curIndex==index?23:20)
            }
            .border({
              width:{
                right:this.curIndex==index?4:0
              },
              color:"#0f6ab1"
            })
            .justifyContent(FlexAlign.Center)
            .width("100%")
            .height(50)
            .backgroundColor(this.curIndex==index?"#e7f0f7":Color.White)
            .onClick(()=>{
              if (this.curIndex != index) {
                this.curIndex=index
                if (this.curIndex === 0) {
                  router.replaceUrl({ url: "pages/StuIndex" });
                } else if (this.curIndex == 1) {
                  router.replaceUrl({ url: "pages/dailyQJIndex" });
                } else if (this.curIndex === 2) {
                  router.replaceUrl({ url: "pages/dailyKQIndex" });
                } else if (this.curIndex === 3) {
                  router.replaceUrl({ url: "pages/rzPage" });
                }else if(this.curIndex==4){
                  router.replaceUrl({url:"pages/ProgectIndex"})
                }else if(this.curIndex==5){
                  router.replaceUrl({url:"pages/SystemIndex"})
                }
              }
            })
          }
        })
      }
      .width("18%")
      .height("100%")
    }

  }
}
export {LeftNavCom}