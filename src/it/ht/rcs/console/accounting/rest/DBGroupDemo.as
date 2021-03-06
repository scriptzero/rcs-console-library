package it.ht.rcs.console.accounting.rest
{
  import it.ht.rcs.console.accounting.model.Group;
  import it.ht.rcs.console.accounting.model.User;
  import it.ht.rcs.console.operation.model.Operation;
  
  import mx.collections.ArrayCollection;
  import mx.rpc.events.ResultEvent;
  
  public class DBGroupDemo implements IDBGroup
  {

    private var groups:ArrayCollection = new ArrayCollection([
      new Group({ _id: '1', name: 'demo',       alert: false, user_ids: ['2', '3'],                               item_ids: ['o1', 'o2', 'o3'] }),
      new Group({ _id: '2', name: 'developers', alert: false, user_ids: ['2', '3', '4', '5', '6', '7', '8', '9'], item_ids: ['o3'] }),
      new Group({ _id: '3', name: 'test',       alert: true,  user_ids: ['10'],                                   item_ids: [] })
    ]);
    
    public function all(onResult:Function=null, onFault:Function=null):void
    {
      if (onResult != null) 
        onResult(new ResultEvent('group.index', false, true, groups));
    }
    
    public function show(id:String, onResult:Function=null, onFault:Function=null):void
    {
    }
    
    public function create(params:Object, onResult:Function=null, onFault:Function=null):void
    {
      var group:Group = new Group(params);
      group._id = new Date().time.toString();
      groups.addItem(group);
      
      if (onResult != null) 
        onResult(new ResultEvent('group.create', false, true, group));
    }
    
    public function update(group:Group, property:Object, onResult:Function=null, onFault:Function=null):void
    {
      if (onResult != null)
        onResult(new ResultEvent('group.update'));
    }
    
    public function destroy(group:Group, onResult:Function=null, onFault:Function=null):void
    {
      if (onResult != null)
        onResult(new ResultEvent('group.destroy'));
    }
    
    public function add_user(group:Group, user:User, onResult:Function=null, onFault:Function=null):void
    {
      if (onResult != null) 
        onResult(new ResultEvent('group.add_user'));
    }
    
    public function del_user(group:Group, user:User, onResult:Function=null, onFault:Function=null):void
    {
      if (onResult != null) 
        onResult(new ResultEvent('group.del_user'));
    }
    
    public function add_operation(group:Group, op:Operation, onResult:Function=null, onFault:Function=null):void
    {
      if (onResult != null) 
        onResult(new ResultEvent('group.add_operation'));
    }
    
    public function del_operation(group:Group, op:Operation, onResult:Function=null, onFault:Function=null):void
    {
      if (onResult != null) 
        onResult(new ResultEvent('group.del_operation'));
    }
    
    public function alert(group:Group, onResult:Function=null, onFault:Function=null):void
    {
    }
    
  }
  
}