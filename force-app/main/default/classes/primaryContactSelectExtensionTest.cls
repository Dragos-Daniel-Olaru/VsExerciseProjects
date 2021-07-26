/**
 * File:        primaryContactSelectExtensionTest
 * Project:     VsExerciseProjects
 * Date:        July 19, 2021
 * Created By:  Dragos Olaru
 * *************************************************************************
 * Description:  Test class
 * *************************************************************************
 * History:
 * Date:       			            Modified By:  		           Description:
 *              July 23, 2021                      Dragos Olaru
 */
@isTest
private class primaryContactSelectExtensionTest {
  /**
   * @author Dragos Olaru
   * @Date July 26, 2021
   * @name setup
   * @description Setup method for dummy records
   * @return void
   */

  @testSetup
  static void setup() {
    List<Contact> ContactList = new List<Contact>();
    Account testAccount = new Account();
    testAccount.Name = 'demo';
    insert testAccount;

    ContactList[0].AccountId = testAccount.Id;
    ContactList[0].lastName = 'demoContact';
    ContactList[0].Title = 'Ms';
    ContactList[0].Phone = '202-555-0137';
    ContactList[0].Is_Primary_Contact__c = false;

    ContactList[1].AccountId = testAccount.Id;
    ContactList[1].lastName = 'demoContactTrue';
    ContactList[1].Title = 'Ms';
    ContactList[1].Phone = '202-555-0136';
    ContactList[1].Is_Primary_Contact__c = true;

    insert ContactList;
  }

  /**
   * @author Dragos Olaru
   * @Date July 22, 2021
   * @name TestSearch
   * @description Test search on controller
   * @return void
   */

  public static testMethod void TestSearch() {
    Account acct = [SELECT Id FROM Account WHERE Name = 'demo' LIMIT 1];
    Contact TestContact = [
      SELECT Id, AccountId, Is_Primary_Contact__c
      FROM Contact
      WHERE Name = 'demoContact'
      LIMIT 1
    ];
    ApexPages.StandardController testStandardController = new ApexPages.StandardController(
      acct
    );
    primaryContactSelectExtension testController = new primaryContactSelectExtension(
      testStandardController
    );
    testController.searchKey = 'de';
    testController.recordToModifyKey = testcontact.Id;
    testController.contactWorkedOn = new List<Contact>();
    testController.person = acct;
    ApexPages.currentPage()
      .getParameters()
      .put('recordToModifyKey', testController.recordToModifyKey);
    testController.search();
  }

  /**
   * @author Dragos Olaru
   * @Date July 22, 2021
   * @name TestSetPrimary
   * @description Test set primary contact on controller
   * @return void
   */

  public static testMethod void TestSetPrimary() {
    Account acct = [SELECT Id FROM Account WHERE Name = 'demo' LIMIT 1];
    Contact TestContact = [
      SELECT Id, AccountId, Is_Primary_Contact__c
      FROM Contact
      WHERE Name = 'demoContact'
      LIMIT 1
    ];
    Contact TestContactTrue = [
      SELECT Id, AccountId, Is_Primary_Contact__c
      FROM Contact
      WHERE Name = 'demoContactTrue'
      LIMIT 1
    ];
    ApexPages.StandardController testStandardController = new ApexPages.StandardController(
      acct
    );
    primaryContactSelectExtension testController = new primaryContactSelectExtension(
      testStandardController
    );
    testController.searchKey = 'de';
    testController.recordToModifyKey = testcontact.Id;
    testController.contactWorkedOn = new List<Contact>();
    testController.person = acct;
    ApexPages.currentPage()
      .getParameters()
      .put('recordToModifyKey', testController.recordToModifyKey);
    testController.search();
    testController.setPrimary();
  }

  /**
   * @author Dragos Olaru
   * @Date July 22, 2021
   * @name TestSetPrimaryListFail
   * @description Test search on controller with list exception
   * @return void
   */

  public static testMethod void TestSetPrimaryListFail() {
    Account acct = [SELECT Id FROM Account WHERE Name = 'demo' LIMIT 1];
    Contact TestContact = [
      SELECT Id, AccountId, Is_Primary_Contact__c
      FROM Contact
      WHERE Name = 'demoContact'
      LIMIT 1
    ];
    Contact TestContactTrue = [
      SELECT Id, AccountId, Is_Primary_Contact__c
      FROM Contact
      WHERE Name = 'demoContactTrue'
      LIMIT 1
    ];
    ApexPages.StandardController testStandardController = new ApexPages.StandardController(
      acct
    );
    primaryContactSelectExtension testController = new primaryContactSelectExtension(
      testStandardController
    );
    testController.searchKey = 'de';
    testController.recordToModifyKey = testcontact.Id;
    testController.contactWorkedOn = new List<Contact>();
    testController.person = acct;
    ApexPages.currentPage()
      .getParameters()
      .put('recordToModifyKey', testController.recordToModifyKey);
    testController.setPrimary();
  }
}
