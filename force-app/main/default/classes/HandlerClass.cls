/**
 * File:        HandlerClass
 * Project:     VsExerciseProjects
 * Date:        July 28, 2021
 * Created By:  Dragos Olaru
 * *************************************************************************
 * Description:  Class with handlers for the triggers
 * *************************************************************************
 * History:
 * Date:       			            Modified By:  		           Description:
 *
 */

public with sharing class HandlerClass {
  /**
   * @author Dragos Olaru
   * @Date July 28, 2021
   * @name BeforeAction
   * @description Blocks setting another primary contact
   * @return void
   */

  public void BeforeAction(Contact[] newContacts) {
    for (Contact c : newContacts) {
      if (c.Is_Primary_Contact__c) {
        try {
          Integer primaryContactCount = [
            SELECT COUNT()
            FROM Contact
            WHERE
              AccountId = :c.AccountId
              AND Id != :c.Id
              AND Is_Primary_Contact__c = TRUE
          ];
          if (primaryContactCount > 0) {
            c.addError(Label.PrimaryContactAlert);
          }
        } catch (Exception e) {
          System.debug('Error' + e.getMessage());
        }
      }
    }
  }

  /**
   * @author Dragos Olaru
   * @Date July 28, 2021
   * @name AfterAction
   * @description After insert trigger handle
   * @return void
   */

  public void AfterAction(Contact[] newContacts) {
    for (Contact c : newContacts)
      if (c.Is_Primary_Contact__c) {
        Database.executeBatch(new BatchableClass(c.AccountId));
      }
  }

  /**
   * @author Dragos Olaru
   * @Date July 28, 2021
   * @name AfterUpdate
   * @description After update trigger handle
   * @return void
   */

  public void AfterUpdate(Contact[] oldContacts, Contact[] newContacts) {
    for (Integer i = 0; i < newContacts.size(); i++) {
      contact newContact = newContacts[i];
      contact oldContact = oldContacts[i];

      if (
        newContact.Is_Primary_Contact__c && !oldContact.Is_Primary_Contact__c
      ) {
        Database.executeBatch(new BatchableClass(newContact.AccountId));
      }
    }
  }
}
