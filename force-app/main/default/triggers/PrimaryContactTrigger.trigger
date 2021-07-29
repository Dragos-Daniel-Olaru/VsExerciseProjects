/**
 * File:        PrimaryContactTrigger
 * Project:     VsExerciseProjects
 * Date:        July 28, 2021
 * Created By:  Dragos Olaru
 * *************************************************************************
 * Description:  Trigger for blocking the setting of new primary contacts and setting the primary contact phone in all secondary contacts
 * *************************************************************************
 * History:
 * Date:       			            Modified By:  		           Description:
 *
 */

trigger PrimaryContactTrigger on Contact(
  before insert,
  before update,
  after insert,
  after update
) {
  HandlerClass handler = new HandlerClass();
  if (Trigger.isBefore) {
    handler.BeforeAction(Trigger.new);
  } else if (Trigger.isAfter)
  {
   if(Trigger.isInsert){
    handler.AfterAction(Trigger.new);}
   else if (Trigger.isUpdate) {
    handler.AfterUpdate(Trigger.old, Trigger.new);
  }
}
