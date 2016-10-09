public with sharing class InnerClassTableController {

   
   
    public List<WrapperClass> wrapperClassList{get;set;}
    private List<WrapperClass> dupwrapperClassList = new List<WrapperClass>();
   
    public Boolean showrmvButton{get;set;}
    private Integer rowNum;
    private Boolean defaultRow{get;set;}
    
    
    WrapperClass wrapperClassObj;
    
    public InnerClassTableController(ApexPages.StandardController controller) {
   
    wrapperClassList = new List<WrapperClass>();
    defaultRow = true;
    rowNum = 0;
    
    addRow();
       
       
    }
    
    public void addRow()
    {
       
       wrapperClassObj = new WrapperClass();
       
       if(!defaultRow)
       {
           rowNum = rowNum+1;
           showrmvButton = true;
       }
       else
           showrmvButton = false;
           
      
       wrapperClassObj.addRowURL = '+';
       wrapperClassObj.removeRowURL = '-';
       wrapperClassObj.rowIndex = rowNum;
       
       wrapperClassList.add(wrapperClassObj); 
       defaultRow = false;
    }
    
    public void removeRow()
    {
       Integer rowNum1 = 0;
       
       dupwrapperClassList.clear();
       dupwrapperClassList.addall(wrapperClassList);
       wrapperClassList.clear();
       
       rownum = Integer.valueOf(Apexpages.currentPage().getParameters().get('index'));
       for(WrapperClass wrapperClassObj : dupwrapperClassList)
       {
           if(wrapperClassObj.rowIndex != rowNum)
           {
                wrapperClassObj.rowIndex = rowNum1;
                wrapperClassList.add(wrapperClassObj);
                rowNum1 = rowNum1+1;
           }
            
       }
       
       if(wrapperClassList.size() == 1)
           showrmvButton = false;
      
    }
    
    public class WrapperClass
    {
       public String name{get;set;}
       public Boolean active{get;set;}
       public String SLA{get;set;}
       public String ownership{get;set;}
       public String addRowURL{get;set;}
       public String removeRowURL{get;set;}
       public Integer rowIndex{get;set;}
    }
    

}