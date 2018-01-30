# DS_TEST
jsont to model


import DS_ModelSDK
@objcMembers
class Bank: NSObject{
var id: String?
var name: String?
}

@objcMembers
class Card: NSObject{
var id: String?
var name: String?
var bank: Bank?
}
@objcMembers
class User: NSObject{
var name: String?
var age: Int = 0
var cards:[Card]?
var card: Card?
}

struct House{
var address: String?
init(){}
}








//测试调用方法,多层字典数组转模型
let dic = ["name": "周顺",
"age": "25",
"cards":[["name":"金融","id":"1"],["name":"乐购","id": "2"]],
"card":["name": "家乐福", "id": "1005","bank":["id": "005","name": "招商银行"]]] as [String : Any]
let u = DS_Model<User>.ds_Obj(dic)
print(u.card?.bank?.name ?? "")
print(u.cards?.last?.name ?? "")
