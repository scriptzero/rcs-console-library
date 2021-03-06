package it.ht.rcs.console.shard.rest
{
  import it.ht.rcs.console.shard.model.Shard;
  import it.ht.rcs.console.shard.model.ShardStat;
  import it.ht.rcs.console.shard.model.System;
  
  import mx.rpc.events.ResultEvent;

  public class DBShardDemo implements IDBShard
  {
    
    private var system:System = new System({ shards: [
      new Shard({ _id: "shard0000", host: "shard-server-a:27018" }),
      new Shard({ _id: "shard0001", host: "shard-server-b:27018" })
    ], ok: "1" });
    
    public function all(onResult:Function=null, onFault:Function=null):void
    {
      if (onResult != null)
        onResult(new ResultEvent("system.index", false, true, system));
    }
    
    public function show(id:String, onResult:Function=null, onFault:Function=null):void
    {
      var event:ResultEvent;
      
      if (id == "shard0000")
        event = new ResultEvent("system.show", false, true, new ShardStat({ dataSize: 141897900, storageSize: 282641664, ok: 1 }));
      else if (id == "shard0001")
        event = new ResultEvent("system.show", false, true, new ShardStat({ dataSize: 40325641,  storageSize: 55632187,  ok: 1 }));
      
      if (onResult != null)
        onResult(event);
    }
    
  }
  
}