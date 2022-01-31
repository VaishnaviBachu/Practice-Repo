global class MyfirstWebservice{


    webservice static Id makeNewAcc(String AccName){
        Account a= new Account();
        a.Name = AccName;
        Insert a;
        return a.id;
    }

}