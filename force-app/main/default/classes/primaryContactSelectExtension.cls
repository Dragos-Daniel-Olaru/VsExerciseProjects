/**
 * File:        primaryContactSelectExtension
 * Project:     VsExerciseProjects
 * Date:        July 19, 2021
 * Created By:  Dragos Olaru
 * *************************************************************************
 * Description:  Extension class for querying and modifying records
 * *************************************************************************
 * History:
 * Date:       			            Modified By:  		           Description:
 *              July 22, 2021                      Dragos Olaru
 */
global with sharing class primaryContactSelectExtension {
  public Account person;
  public primaryContactSelectExtension(
    ApexPages.StandardController stdController
  ) {
    this.person = (Account) stdController.getRecord();
  }

  public list<Contact> contactWorkedOn { get; set; }
  public String searchKey { get; set; }
  public String recordToModifyKey { get; set; }
  public Integer pageCounter = 0;
  public Integer pageSize = 10;

  /**
   * @author Dragos Olaru
   * @Date July 20, 2021
   * @name search
   * @description Query for related contacts on account
   * @return void
   */
  public void search() {
    contactWorkedOn = [
      SELECT Id, LastName, title, phone, Is_Primary_Contact__c
      FROM Contact
      WHERE Accountid = :this.person.Id AND lastname LIKE :'%' + searchKey + '%'
      LIMIT :pageSize
      OFFSET :pageCounter
    ];
  }

  /**
   * @author Dragos Olaru
   * @Date July 20, 2021
   * @name setPrimary
   * @description Set primary contact on account and remove previous primary contact
   * @return void
   */
  public void setPrimary() {
    try {
      recordToModifyKey = apexpages.currentpage()
        .getparameters()
        .get('recordToModifyKey');
      contactWorkedOn[0] = [
        SELECT Id, Is_Primary_Contact__c
        FROM Contact
        WHERE id = :recordToModifyKey AND Accountid = :this.person.Id
      ];
      contactWorkedOn[0].Is_Primary_Contact__c = true;
      contactWorkedOn[1] = [
        SELECT Id, Is_Primary_Contact__c
        FROM Contact
        WHERE
          id != :recordToModifyKey
          AND Accountid = :this.person.Id
          AND Is_Primary_Contact__c = TRUE
      ];
      contactWorkedOn[1].Is_Primary_Contact__c = false;
    } catch (ListException e) {
      System.debug('The following exception has occurred: ' + e.getMessage());
    }

    try {
      update contactWorkedOn;
    } catch (DmlException e) {
      System.debug('The following exception has occurred: ' + e.getMessage());
    }
    search();
  }

  /**
   * @author Dragos Olaru
   * @Date July 26, 2021
   * @name Previous
   * @description Go to previous page
   * @return null
   */

  public PageReference Previous() {
    pageCounter -= pageSize;
    return null;
  }

  /**
   * @author Dragos Olaru
   * @Date July 26, 2021
   * @name Previous
   * @description Go to next page
   * @return null
   */

  public PageReference Next() {
    pageCounter += pageSize;
    return null;
  }
}
