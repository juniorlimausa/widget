/**
 * @description       : 
 * @author            : junior.lima
 * @group             : 
 * @last modified on  : 07-22-2021
 * @last modified by  : junior.lima
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   07-20-2021   junior.lima   Initial Version
**/
global class WidgetNestedValidationBatch implements Database.batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        /** SELECT WIDGETS RECORDS CREATED LAST HOUR **/
        DateTime lastHourDateTime = System.Now().addHours(-1);
        String query = 'SELECT  Id, Name, Batch_Updated__c, Value__c FROM Widget__c WHERE CreatedDate >= :lastHourDateTime and Is_Properly_Nested__c = FALSE';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bd, List<Widget__c> listWidgetsLastHours)
    {
        for(Widget__c unitWidget : listWidgetsLastHours)
        {          
            /** USE THE GLOBAL MATCHER TO DEFINE IF IT IS NESTED OR NOT **/
            unitWidget.Batch_Updated__c = TRUE;
        }
        update listWidgetsLastHours;
    }
    global void finish(Database.BatchableContext bc)
    {
    }
}