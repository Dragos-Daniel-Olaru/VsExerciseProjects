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
public class primaryContactSelectExtensionTest {
  public Account person;
  public primaryContactSelectExtensionTest(
    ApexPages.StandardController stdController
  ) {
    this.person = (Account) stdController.getRecord();
  }

  /**
   * @author Dragos Olaru
   * @Date July 22, 2021
   * @name TestSearch
   * @description Test search on controller
   * @return void
   */

  public static testMethod void TestSearch() {
    Account testAccount = new Account();
    Contact testContact = new Contact();
    testAccount.Name = 'demo';
    insert testAccount;
    testContact.AccountId = testAccount.Id;
    testContact.lastName = 'demoContact';
    testContact.Title = 'Ms';
    testContact.Phone = '202-555-0137';
    testContact.Is_Primary_Contact__c = false;

    insert testContact;

    primaryContactSelectExtension testController = new primaryContactSelectExtension();
    testController.searchKey = 'de';
    testController.contactWorkedOn = new List<Contact>();
    testController.person = testAccount;
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
    Account testAccount = new Account();
    Contact testContact = new Contact();
    Contact testContactTrue = new Contact();
    testAccount.Name = 'demo';
    insert testAccount;

    testContact.AccountId = testAccount.Id;
    testContact.lastName = 'demoContact';
    testContact.Title = 'Ms';
    testContact.Phone = '202-555-0137';
    testContact.Is_Primary_Contact__c = false;

    testContactTrue.AccountId = testAccount.Id;
    testContactTrue.lastName = 'demoContactTrue';
    testContactTrue.Title = 'Ms';
    testContactTrue.Phone = '202-555-0136';
    testContactTrue.Is_Primary_Contact__c = true;

    insert testContact;
    insert testContactTrue;

    primaryContactSelectExtension testController = new primaryContactSelectExtension();
    testController.searchKey = 'de';
    testController.modKey = testcontact.Id;
    testController.contactWorkedOn = new List<Contact>();
    testController.person = testAccount;
    System.debug(testController.modKey);
    System.debug(testcontact.Id);
    ApexPages.currentPage()
      .getParameters()
      .put('modKey', testController.modKey);
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
    Account testAccount = new Account();
    Contact testContact = new Contact();
    Contact testContactTrue = new Contact();
    testAccount.Name = 'demo';
    insert testAccount;
    testContact.AccountId = testAccount.Id;
    testContact.lastName = 'demoContact';
    testContact.Title = 'Ms';
    testContact.Phone = '202-555-0137';
    testContact.Is_Primary_Contact__c = false;

    testContactTrue.AccountId = testAccount.Id;
    testContactTrue.lastName = 'demoContactTrue';
    testContactTrue.Title = 'Ms';
    testContactTrue.Phone = '202-555-01376';
    testContactTrue.Is_Primary_Contact__c = true;

    insert testContact;
    insert testContactTrue;

    primaryContactSelectExtension testController = new primaryContactSelectExtension();
    testController.modKey = testcontact.Id;
    testController.contactWorkedOn = new List<Contact>();
    testController.person = testAccount;
    ApexPages.currentPage()
      .getParameters()
      .put('modKey', testController.modKey);
    testController.setPrimary();
  }
}
