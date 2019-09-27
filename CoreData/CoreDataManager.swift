//
//  CoreDataManager.swift
//  TakeTime
//
//  Created by 刘恒 on 2019/9/21.
//  Copyright © 2019 刘恒. All rights reserved.
//

import CoreData

let CoreDataShare = CoreDataManager.share
let groupIdentifier = "group.com.dada"

final class CoreDataManager: NSObject {
    static let share = CoreDataManager()
    
    private override init() {}
    
    /**
     管理上下文
     */
    lazy var managerContext = {() -> NSManagedObjectContext in
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        //设置存储调度器
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
    
    /**
     模型对象
     */
    lazy var managerObjectModel = {
        () -> NSManagedObjectModel in
        /**
         参数是模型文件的bundle数组  如果是nil  自动获取所有bundle的模型文件
         let model = NSManagedObjectModel.mergedModel(from: nil)
         */
        let modelUrl = Bundle.main.url(forResource: "TakeTime", withExtension: "momd")
        return NSManagedObjectModel(contentsOf: modelUrl!)!
    }()
    
    /**
     存储调度器
     */
    lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator?  = {
        () -> NSPersistentStoreCoordinator? in
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managerObjectModel)
        let url = self.getDocumentUrlPath()?.appendingPathComponent("event.sqlit", isDirectory: true)
        do{
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }catch{print("coreData协调器创建失败")}
        return coordinator
    }()
    
    /**
     获取数据库路径
     */
    private func getDocumentUrlPath() -> URL?{
        return FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier:  groupIdentifier)
    }
    
    /**
     保存数据
     */
    public func save(){
        do {
            try managerContext.save()
        } catch  {
            print("数据操作失败")
        }
    }
}
