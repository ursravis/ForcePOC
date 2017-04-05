/****************************************************************************************************
 * Description - Sample Apex REST service with GET method
 * Author - 
 ****************************************************************************************************/

@RestResource(urlMapping='/projects/*')
global class Scrims_ProjectService {
    
    @HttpGet
    global static List<Scrims_Project__c> doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        List<Scrims_Project__c> result = [
        SELECT 
            CreatedById, 
            CreatedDate, 
            Id, 
            IsDeleted, 
            LastModifiedById, 
            LastModifiedDate, 
            LastReferencedDate, 
            LastViewedDate, 
            Name, 
            OwnerId, 
            ProjectUniqueID__c, 
            ReleaseDate__c, 
            ReleaseTitle__c, 
            StartDate__c, 
            SystemModstamp, 
            WorkingTitle__c, 
            WPRBillingCode__c, 
            WrapDate__c 
        FROM Scrims_Project__c
        ];
        return result;
    }
       @HttpPost
    global static ResponseHandler post(String name,
    String wprCode)
    //,Date startDate,Date wrapDate,Date    releaseDate)
    {
         RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Scrims_Project__c  newProject =  new Scrims_Project__c();
        newProject.Name=name;
        newProject.WPRBillingCode__c=wprCode;
        newProject.ProjectUniqueID__c='Testone';
        //newProject.StartDate__c=DateTime. ();
        //newProject.ReleaseDate__c=DateTime.now();
        //newProject.WrapDate__c=DateTime.now();
        ResponseHandler response = new ResponseHandler();
        try
        {
            insert newProject;
             List<sObject> thesObjectList = new List<sObject>();
            thesObjectList.add((sObject)newProject);
            response.Data = thesObjectList;
            response.Status = 'Success';
            response.ErrorCode = null;
            response.Message = null;
        } 
        catch(DmlException e) 
        {
            //Add custom error code when you could not insert a record
            response.ErrorCode = 'Oyecode - 0001';
            response.Status = 'error';
            response.Message = e.getMessage();
        }
        return response;  
    
    }
    global  class ResponseHandler {
    
    //List of custom attributes that we want to check the status of the org
    public String Status {get; set;}
    public List<sObject> Data {get;set;}
    public String Message {get;set;}
    public String ErrorCode {get; set;}
    
    //Check if Object is NULL or Blank
    global  boolean isNotNullOrEmpty(string str)
    {
        return str!=null || !String.isBlank(str); 
    }   
}
}