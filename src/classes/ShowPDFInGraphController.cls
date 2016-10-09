public with sharing class ShowPDFInGraphController {
 
 public List<PieWedgeData> getPieData() 
 {  
  List<PieWedgeData> data = new List<PieWedgeData>();
  
  
     
   data.add(new PieWedgeData('XYZ',20));
 
  return data;  
 }  
 
 // Wrapper class  
 public class PieWedgeData 
 {  
  public String name { get; set; }  
  public Decimal data { get; set; }  
  
  public PieWedgeData(String name, Decimal data) 
  {  
   this.name = name;  
   this.data = data;  
  }  
 }  
}