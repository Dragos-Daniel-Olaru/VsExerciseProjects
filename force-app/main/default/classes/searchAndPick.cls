global with sharing class searchAndPick {
          private final Account person;
          public searchAndPick(ApexPages.StandardController stdController){
    this.person= (Account)stdController.getRecord();
  }
    
     public list <Contact> ctt {get;set;}
    public list <Contact> cttt {get;set;}
    public list <Contact> ctct {get;set;}
    public String searchKey {get;set;}
     public String modKey {get;set;}
    public searchAndPick( ) {
    }
    public void search(){
        ctt = [SELECT Id, LastName, title, phone, Is_Primary_Contact__c from Contact where Accountid =:this.person.Id AND lastname like:'%'+searchKey+'%' LIMIT 10];
}
    public void setPrimary(){
        	modKey = apexpages.currentpage().getparameters().get('modKey');
			ctct = [SELECT Id, Is_Primary_Contact__c from Contact where id =:modKey AND Accountid =:this.person.Id];
        	ctct[0].Is_Primary_Contact__c = true;
        	update ctct;
        	cttt = [SELECT Id, Is_Primary_Contact__c from Contact where id !=:modKey AND Accountid =:this.person.Id AND Is_Primary_Contact__c = true];
        	cttt[0].Is_Primary_Contact__c = false;
        	update cttt;
        	search();
        }
}