/**
 * File:        BatchableClass
 * Project:     VsExerciseProjects
 * Date:        July 28, 2021
 * Created By:  Dragos Olaru
 * *************************************************************************
 * Description:  Class with batch actions for the triggers
 * *************************************************************************
 * History:
 * Date:       			            Modified By:  		           Description:
 *
 */

public class BatchableClass implements Database.Batchable<SObject>, Database.Stateful {
  public Contact primaryContact;
  public id accountId;
  public String primaryContactPhone;

  /**
   * @author Dragos Olaru
   * @Date July 28, 2021
   * @name BatchableClass
   * @description Custom batchable constructor
   * @return void
   */

  public BatchableClass(Id accountId) {
    this.accountId = accountId;
    List<Contact> PrimaryContactList = [
      SELECT Id, Phone, AccountId, Is_Primary_Contact__c
      FROM Contact
      WHERE AccountId = :accountId AND Is_Primary_Contact__c = TRUE
    ];
    this.primaryContact = primaryContactList[0];
  }

  /**
   * @author Dragos Olaru
   * @Date July 28, 2021
   * @name start
   * @description Returns the record set as a QueryLocator object that will be batched for execution.
   * @return void
   */

  public Database.QueryLocator start(Database.BatchableContext bc) {
    List<Contact> primaryContactList = [
      SELECT Id, Phone, AccountId, Is_Primary_Contact__c
      FROM Contact
      WHERE AccountId = :accountId AND Is_Primary_Contact__c = TRUE
    ];
    primaryContactPhone = primaryContactList[0].Phone;
    return Database.getQueryLocator(
      'SELECT Id FROM Contact ' +
      'WHERE AccountId = \'' +
      PrimaryContact.AccountId +
      '\' AND Id != \'' +
      PrimaryContact.Id +
      '\''
    );
  }

  /**
   * @author Dragos Olaru
   * @Date July 28, 2021
   * @name execute
   * @description Execution logic for the batch job
   * @return void
   */

  public void execute(Database.BatchableContext bc, List<Contact> ContactList) {
    for (Contact c : ContactList) {
      c.Primary_Contact_Phone__c = primaryContact.Phone;
    }
    update ContactList;
  }

  /**
   * @author Dragos Olaru
   * @Date July 28, 2021
   * @name finish
   * @description Cleanup
   * @return void
   */

  public void finish(Database.BatchableContext bc) {
  }
}
