package it.ht.rcs.console.monitor.controller
{
  import com.adobe.serialization.json.JSON;
  
  import it.ht.rcs.console.DB;
  import it.ht.rcs.console.controller.Manager;
  import it.ht.rcs.console.events.RefreshEvent;
  import it.ht.rcs.console.monitor.model.License;
  import it.ht.rcs.console.monitor.model.LicenseCount;
  import it.ht.rcs.console.utils.CurrMaxObject;
  
  import mx.core.FlexGlobals;
  import mx.rpc.events.ResultEvent;
  
  [Bindable]
  public class LicenseManager extends Manager
  {
    public var type:String = "reusable";
    public var serial:String = "off";
    public var users:CurrMaxObject = new CurrMaxObject("0", "0");
    
    public var agent_total:CurrMaxObject = new CurrMaxObject("0", "0");
    public var agent_desktop:CurrMaxObject = new CurrMaxObject("0", "0");
    public var agent_mobile:CurrMaxObject = new CurrMaxObject("0", "0");
    
    public var agent_linux:Boolean = false;
    public var agent_osx:Boolean = false;
    public var agent_windows:Boolean = false;
    public var agent_android:Boolean = false;
    public var agent_blackberry:Boolean = false;
    public var agent_ios:Boolean = false;
    public var agent_symbian:Boolean = false;
    public var agent_winmo:Boolean = false;
    
    public var collectors:CurrMaxObject = new CurrMaxObject("0", "0");
    public var anonymizers:CurrMaxObject = new CurrMaxObject("0", "0");
    
    public var alerting:Boolean = false;
    public var correlation:Boolean = false;
    
    public var ipa:CurrMaxObject = new CurrMaxObject("0", "0");
    public var rmi:Boolean = false;
    
    public var shards:CurrMaxObject = new CurrMaxObject("0", "0");
    public var exploits:String;
    
    /* singleton */
    private static var _instance:LicenseManager = new LicenseManager();
    public static function get instance():LicenseManager { return _instance; } 
    
    public function LicenseManager()
    {
      super();
      /* always get new data upon startup */
      onRefresh(null);
    }
    
    override protected function onRefresh(e:RefreshEvent):void
    {
      super.onRefresh(e);
      trace('LicenseManager -- Refresh');
      
      DB.instance.license.limit(onLoadLimit);
      DB.instance.license.count(onLoadCount);
    }
    
    private function onLoadLimit(e:ResultEvent):void
    {
      var limits:License = e.result as License;
        
      type = limits['type'];
      serial = limits['serial'].toString();
      
      users.max = (limits['users'] == null) ? 'U' : limits['users'].toString();
      
      agent_total.max = (limits['backdoors']['total'] == null) ? 'U' : limits['backdoors']['total'].toString();
      agent_desktop.max = (limits['backdoors']['desktop'] == null) ? 'U' : limits['backdoors']['desktop'].toString();
      agent_mobile.max = (limits['backdoors']['mobile'] == null) ? 'U' : limits['backdoors']['mobile'].toString();
      
      agent_linux = limits['backdoors']['linux'][0];
      agent_osx = limits['backdoors']['osx'][0];
      agent_windows = limits['backdoors']['windows'][0];
      agent_android = limits['backdoors']['android'][0];
      agent_blackberry = limits['backdoors']['blackberry'][0];
      agent_ios = limits['backdoors']['ios'][0];
      agent_symbian = limits['backdoors']['symbian'][0];
      agent_winmo = limits['backdoors']['winmo'][0];
      
      collectors.max = (limits['collectors']['collectors'] == null) ? 'U' : limits['collectors']['collectors'].toString();
      anonymizers.max = (limits['collectors']['anonymizers'] == null) ? 'U' : limits['collectors']['anonymizers'].toString();
      
      alerting = limits['alerting'];
      correlation = limits['correlation'];
      
      ipa.max = (limits['ipa'] == null) ? 'U' : limits['ipa'].toString();
      rmi = limits['rmi'];
      
      shards.max = (limits['shards'] == null) ? 'U' : limits['shards'].toString();
    }

    private function onLoadCount(e:ResultEvent):void
    {
      var current:LicenseCount = e.result as LicenseCount;
      
      users.curr = current['users'].toString();
      
      agent_total.curr = current['backdoors']['total'].toString();
      agent_desktop.curr = current['backdoors']['desktop'].toString();
      agent_mobile.curr = current['backdoors']['mobile'].toString();
      
      collectors.curr = current['collectors']['collectors'].toString();
      anonymizers.curr = current['collectors']['anonymizers'].toString();
      
      ipa.curr = current['ipa'].toString();
      
      shards.curr = current['shards'].toString();
    }

  }
}