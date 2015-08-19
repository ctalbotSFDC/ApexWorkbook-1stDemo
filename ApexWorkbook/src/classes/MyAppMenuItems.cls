public class MyAppMenuItems{
	List<AppMenuItem> appmenuitems;
    
    public List<AppMenuItem> getAppMenuItems() {
        if (appmenuitems == null) {
            appmenuitems = [SELECT Id, Name, Label, SortOrder, NamespacePrefix, Description, StartUrl, MobileStartUrl, LogoUrl, IconUrl, InfoUrl, IsUsingAdminAuthorization, Type FROM AppMenuItem];
        }
        return appmenuitems;
    }
}