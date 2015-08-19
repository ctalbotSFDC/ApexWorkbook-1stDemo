public with sharing class AppsController {

    private final List<AppMenuItem> apps;
    public final InitPiece__c extra {set; get;}
    private final Boolean isAdmin;
    private String favorites = '[]';
    public Boolean isDevice {set; get;}
    public Boolean isDesktop {set; get;}
    public Boolean isBot {set; get;}
    
    public AppsController() {
        User u = [select id, Name, FavoriteApps__c from User where id = :UserInfo.getUserId()];
        if (u.FavoriteApps__c != null) {
            favorites = u.FavoriteApps__c;
        }
        List<SetupEntityAccess> seas = [SELECT SetupEntityId FROM SetupEntityAccess WHERE ParentId IN (SELECT PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId = :UserInfo.getUserId())];
        Set<id> ids = new Set<id>();
        for (SetupEntityAccess sea:seas){
            ids.add(sea.SetupEntityId);
        }
        apps = [select id, name, Label, Type, LogoURL, StartURL, InfoURL from AppMenuItem where Type = 'ConnectedApplication'  and id in :ids order by SortOrder ASC];
        
        extra = [select id, name, label__c, type__c, logourl__c from InitPiece__c];
        //apps.add(0,temp);
            // using a whitelist security model instead of a blacklist security model
            // 00ed00000012T4h == built in "System Administrator" profile
        if (userinfo.getProfileId() == '00ed00000012T4h') {
            isAdmin = true;
        } else {
            isAdmin = false;
        }
        
        String userAgent = ApexPages.currentPage().getHeaders().get('USER-AGENT');
     
    //& some devices use custom headers for the user-agent.
    if (userAgent==null || userAgent.length()==0){
        userAgent = ApexPages.currentPage().getHeaders().get('HTTP_X_OPERAMINI_PHONE_UA');
    }       
    if (userAgent==null || userAgent.length()==0){
        userAgent = ApexPages.currentPage().getHeaders().get('HTTP_X_SKYFIRE_PHONE');
    }
             
    //& replace with custom setting - using (?i) case insensitive mode.     
    String deviceReg = '(?i)(iphone|ipod|ipad|blackberry|android|palm|windows\\s+ce)';
    String desktopReg = '(?i)(windows|linux|os\\s+[x9]|solaris|bsd)';
    String botReg = '(?i)(spider|crawl|slurp|bot)';
     
    isDevice = false;
    isDesktop = false;
    isBot = false;
     
    Matcher m = Pattern.compile(deviceReg).matcher(userAgent);
    if (m.find()){
        isDevice = true;
    } else {
        //& don't compile the patterns unless required.
        m = Pattern.compile(desktopReg).matcher(userAgent);
        if (m.find()) isDesktop = true;
         
        m = Pattern.compile(botReg).matcher(userAgent);
        if (m.find()) isBot = true;
    }
    }
    
    public String getFavorites() {
        return favorites;
    }
    
    public List<AppMenuItem> getApps() {
        return apps;
    }
    
    public Boolean getIsAdmin() {
        return isAdmin;
    }
    
    
}