global class ConvertLeadAction {
  @InvocableMethod(label='Convert Leads')
  global static List<ConvertLeadActionRequest>   convertLeads(List<ConvertLeadActionRequest> requests) {
         List<ConvertLeadActionRequest> results = new List<ConvertLeadActionRequest>();
         for (ConvertLeadActionRequest request : requests) {
                results.add(request);
         }
         return results;
  }





  global class ConvertLeadActionRequest {
    @InvocableVariable(required=true)
        public ID leadId;
    @InvocableVariable(required=true)
        public String convertedStatus;
    @InvocableVariable(label='Account Id')
        public ID accountId;
    @InvocableVariable
        public ID contactId;
    @InvocableVariable
        public Boolean overWriteLeadSource;


  }
  
  }