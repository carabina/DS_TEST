//
//  DS_Model.swift
//  DS_ReflectDemo
//
//  Created by d2space on 2018/1/24.
//  Copyright © 2018年 D2space. All rights reserved.
//

import Foundation

open class DS_Model<T: NSObject>{
    
    //字典转模型
    open class func ds_Obj(_ json: Any?) -> T{
        guard let json = json else{return T()}
        guard json is Dictionary<String, Any> || json is [String: Any] else{return T()}
        let obj = T()
        obj.ds_property(json)
        return obj
    }
    
    //字典转模型数组
    open class func ds_Objs(_ json: Any?) -> [T]{
        guard let json = json else {return [T()]}
        guard json is Array<Any> || json is [Any] else {return [T()]}
        guard let arr = json as? [Any] else{return [T()]}
        let models:[T] = arr.map {
            return DS_Model<T>.ds_Obj($0)
        }
        return models
    }
}

extension NSObject{
    func ds_property(_ json: Any){
        let keys = ds_propertyKeys()
        if let dic = json as? Dictionary<String, Any>{
            for property_Key in keys{
                if let value = dic[property_Key]{
                    if value is Array<Any>{
                        //数组类型转模型数组
                        if let dics = value as? Array<Any>{
                            if dics.count > 0{
                                if let clsName = ds_classNameFromArr(property_Key){
                                    let models = ds_Objs(dics, clsName)
                                    setValue(models, forKey: property_Key)
                                }
                            }
                        }
                    }else if value is Dictionary<String, Any>{
                        //字典类型转模型
                        if let clsName = ds_classNameFromDic(property_Key){
                            if let model = ds_Obj(clsName){
                                model.ds_property(value)
                                setValue(model, forKey: property_Key)
                            }
                        }
                    }else{
                        //基础类型全部转string
                        let valueStr = String(describing: value)
                        self.setValue(valueStr, forKey: property_Key)
                    }
                }
            }
        }
    }
    //获取模型下的所有property_Key
    fileprivate func ds_propertyKeys() -> Array<String>{
        let m_obj = Mirror(reflecting: self)
        return m_obj.children.flatMap {$0.label}
    }
    //从数组中获取类名
    fileprivate func ds_classNameFromArr(_ propertyKey: String) -> String?{
        let m_obj = Mirror(reflecting: self)
        for item in m_obj.children{
            if item.label == propertyKey{
                let m_subObj = Mirror(reflecting: item.value)
                var className = String(m_subObj.description)
                className = className.replacingOccurrences(of: "Mirror for Optional<Array<", with: "")
                className = className.replacingOccurrences(of: ">", with: "")
                return className
            }
        }
        return nil
    }
    //从字典中获取类名
    fileprivate func ds_classNameFromDic(_ propertyKey: String) -> String?{
        let m_obj = Mirror(reflecting: self)
        for item in m_obj.children{
            if item.label == propertyKey{
                let m_subObj = Mirror(reflecting: item.value)
                var className = String(m_subObj.description)
                className = className.replacingOccurrences(of: "Mirror for Optional<", with: "")
                className = className.replacingOccurrences(of: ">", with: "")
                return className
            }
        }
        return nil
    }
    //string 转 实例对象，对象为nsobject
    fileprivate func ds_Obj(_ className: String) -> NSObject?{
        let path = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        if let cls = Bundle.main.classNamed(path + "." + className) as? NSObject.Type{
            return cls.init()
        }
        return nil
    }
    
    //获取实例对象数组
    fileprivate func ds_Objs(_ dics:  Array<Any>,_ clsName: String) -> NSMutableArray{
        let models = NSMutableArray()
        for dic in dics{
            if let model = ds_Obj(clsName){
                model.ds_property(dic)
                models.add(model)
            }
        }
        return models
    }
}
