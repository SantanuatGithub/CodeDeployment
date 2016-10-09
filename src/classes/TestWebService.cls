global class TestWebService {
    webService static Id makeAccount(String name) {
        Account acctObj = new Account (Name = name);
        insert acctObj ;
        return acctObj.id;
    }
}