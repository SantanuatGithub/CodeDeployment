global with sharing class LoginPageController {

    public String reguserConfPassword { get; set; }
    public String reguserPassword { get; set; }
    public String reguserEmail { get; set; }
    public String reguserLastName { get; set; }
    public String reguserFirstName { get; set; }
    public String password { get; set; }
    public String userName { get; set; }
    
    global PageReference login() 
    {
        //String startUrl = System.currentPageReference().getParameters().get('startURL');
        //system.debug('******** startURL : '+startURL);
       
        return Site.login(username, password, '/apex/MyProfilePage');
    }
    
    private boolean isValidPassword() {
        return reguserPassword == reguserConfPassword;
    }
    
    public PageReference registerUser() {
    System.debug('------------Entry-----------');
        if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }
        
        Profile profileObj = [Select Id from Profile where Name = 'Customer Community Login User'];
        String accountId = '0019000001OjPkP';
        
        //System.debug(reguserEmail + reguserFirstName + reguserLastName + reguserPassword);
        
        User u = new User();
        u.Username = reguserEmail ;
        u.Email = reguserEmail ;
        u.FirstName = reguserFirstName ;
        u.LastName = reguserLastName ;
        u.CommunityNickname = reguserFirstName;
        //u.alias= reguserFirstName;
        //u.profile.UserLicense.Name = 'Customer Community Login';    
        //u.ProfileId = profileObj.Id;
        /*try
        {
            insert u;
        }catch(DMLException ex)
        {
            System.debug(ex.getMessage());
        }
        */
         System.debug('user----->'+u);
       String userId = Site.createPortalUser(u,accountId,reguserPassword);
        
        if (userId   != null) { 
       
            if (reguserPassword!= null && reguserPassword.length() > 1) {
                return Site.login(reguserEmail, reguserPassword , '/apex/MyProfilePage');
            }
            else {
                PageReference page = System.Page.CommunitiesSelfRegConfirm;
                page.setRedirect(true);
                return page;
            }
        }
        return null; 
    }
    
   
    
}