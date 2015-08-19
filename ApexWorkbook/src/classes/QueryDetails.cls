public class QueryDetails {
        public String field { get; set; }
        public String text { get; set; }
        public String comparison { get; set; }
        
        
        
        public QueryDetails (String myfield, String mytext, String mycompare) {
            field = myfield;
            text = mytext;
            comparison = mycompare;
        }
}