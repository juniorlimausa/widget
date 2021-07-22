/**
 * @description       : Nesting Challenge - Enpal
 * @author            : junior95lima@gmail.com 
 * @group             : 
 * @last modified on  : 07-21-2021
 * @last modified by  : junior.lima
 * Modifications Log 
 * Ver   Date         Author                   Modification
 * 1.0   07-17-2021   junior95lima@gmail.com   Initial Version
**/

trigger WidgetTrigger on Widget__c (before insert, before update) {
     switch on Trigger.OperationType {
        when BEFORE_INSERT {
            /** GLOBAL MACTHCER RULE IN THE HANDLER **/
            System.debug('BEFORE_INSERT------>' + Trigger.OperationType );
            WidgetTriggerHandler.adjustRecords(trigger.new);
        }
        when BEFORE_UPDATE {
            /** GLOBAL MACTHCER RULE IN THE HANDLER **/
            System.debug('BEFORE_UPDATE------>' + Trigger.OperationType );
            WidgetTriggerHandler.adjustRecords(trigger.new);
        } 
    }
}