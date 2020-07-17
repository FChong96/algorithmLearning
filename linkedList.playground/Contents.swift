import Cocoa

//链表的头结点一般不存放数据，位于第一个节点之前
//头指针指示头结点或者第一个结点的地址，链表可以没有头结点但不能没有头指针


public class linkList<T>{
    //create a node class
    public class node<T>{
        var data:T          //<T> is a generic(通用的) type
        var next:node?      //tail will point to nil
        weak var previous:node?  //doubly-linked list
        //weak make sure the pointers weak when we delete a node(内存泄漏，这里对weak理解还有问题)
        
        //non-optional value init
        init(data:T){
            self.data = data
        }
    }
    
    private var head:node<T>?
//    private var tail:node<T>?
    
    public var isEmpty:Bool{
        return head == nil
    }
    
    public var first:node<T>?{
        return head
    }
    
    public var last:node<T>?{
        guard var node = head else{
   
            return nil
        }

        //this loop will find the node.next = nil, which is the last node
        while let next = node.next{
            node = next
        }
        return node
    }
    
    //list count -- o(n)time  keep the count (o(n) --> o(1))
    public var count:Int{
        guard var node = head else{
            return 0
        }
        var count = 1
        while let next = node.next{
            node = next
            count += 1
        }
        return count
    }
    //list index
    public func nodeIndex(at index: Int) -> node<T>{
        if index == 0{
            return head!
        }else{
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                
                if node == nil{
                    break
                }
            }
            return node!
        }
    }
    
    //a other way to index: subscript(下标) ep:list[0],list[1]
    public subscript(index: Int) -> T {
        let node = nodeIndex(at: index)
        return node.data
    }
    
    //append a data
    public func append(data:T){
        let newNode = node<T>(data: data)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        }else{
            head = newNode
        }
    }
    
    //insert a data: o(n)time (如果链表没有顺序的话插入优先插在第一个结点前，此时时间复杂度为o(1))
    public func insert(_ node:node<T>, at index:Int){
        let newNode = node
        if index == 0{
            newNode.next = head
            head?.previous = newNode
            head = newNode
        }else{
            let prev = self.nodeIndex(at: index-1)
            let next = prev.next
            
            newNode.next = next
            newNode.previous = prev
            prev.next = newNode
            next?.previous = newNode
        }
    }
    
    //remove node  a->b->c -- a->c b(注意清空node的前后指针)
    public func remove(node: node<T>) -> T{
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        }else{
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
    
        return node.data
    }
}



let list = linkList<Int>()
list.isEmpty
list.first

list.append(data:1)

list.first!.data
list.last!.data

let list2 = linkList<String>()
list2.append(data:"Hello")
list2.append(data:"world")
list2.isEmpty
list2.first!.data
list2.last!.data
list2.append(data:"!")
list2.nodeIndex(at: 1).data
list2.nodeIndex(at: 0).data
list2.append(data:"nihao")
list2.count
list2[2]


