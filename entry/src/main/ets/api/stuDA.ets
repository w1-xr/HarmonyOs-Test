import { addDARequestCLass, classIdDataClass,
  delRequestClass,
  editDARequestClass,
  sDetailDataClass,
  sDetailRequestClass,
  stuDADataClass, stuDARequestClass } from '../models/stuDA'
import { Request } from '../utils/request'

//档案列表接口
export function stuDAdel(dataset:stuDARequestClass){
  return Request.postRequest<stuDARequestClass,stuDADataClass>("fileManager/fileManagerList",dataset)
}
//添加档案
export function addDA(dataset:addDARequestCLass){
  return Request.postRequest<addDARequestCLass,void>("fileManager/addFileManager",dataset)
}
//班级下拉框
export function classId(){
  return Request.postRequest<void,classIdDataClass[]>("fileManager/clazz")
}
//修改档案
export function editDA(dataset:editDARequestClass){
  return Request.postRequest<editDARequestClass,void>("fileManager/updateFileManager",dataset)
}
//删除档案
export function delDA(dataset:delRequestClass){
  return Request.postRequest<delRequestClass,void>("fileManager/deleteFileManager",dataset)
}
//档案详情
export function detailDA(dataset:sDetailRequestClass){
  return Request.postRequest<sDetailRequestClass,sDetailDataClass>("fileManager/fileManagerInfo ",dataset)
}
