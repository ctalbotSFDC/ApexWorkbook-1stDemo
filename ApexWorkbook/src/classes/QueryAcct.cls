public class QueryAcct {
    private List<QueryDetails> curQuery;
    //private List<String> curFields;
    public List<Account> myAccts;
    
    public List<Account> getmyAccts() {
        return myAccts;
    }
    
    public List<QueryDetails> getcurQuery() {
        return curQuery;
    }
    
    public void setQuery (String field, String text, String comparison) {
        QueryDetails q = new QueryDetails(field, text, comparison);
        curQuery.add(q);
        //curFields.add(field);
    }
    
    public void addQD() {
        QueryDetails q = new QueryDetails('name', '%Test%', 'like');
        curQuery.add(q);
    }
    
    public void executeQuery () {
        Integer i = 0;
        Integer stoplen = curQuery.size() - 1;
        String mytext = '';
        for (QueryDetails item : curQuery) {
            if (i == stoplen) {
                mytext = mytext + ' ' + item.field + ' ' + item.comparison + ' \'' + item.text + '\'';
            } else {
                mytext = mytext + ' ' + item.field + ' ' + item.comparison + ' \'' + item.text + '\' and ';
            }
            i++;
        }
        if (stoplen == -1) {
            mytext = 'name like \'%\'';
        }
        myAccts = Database.query('SELECT Id, name FROM Account WHERE ' + mytext);
    }
    
    public QueryAcct() {
        curQuery = new List<QueryDetails>();
        addQD();
        executeQuery();
    }
    
    
}