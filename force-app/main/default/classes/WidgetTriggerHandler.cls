/**
 * @description       : Nesting Challenge - Enpal
 * @author            : junior95lima@gmail.com 
 * @group             : 
 * @last modified on  : 07-20-2021
 * @last modified by  : junior.lima
 * Modifications Log 
 * Ver   Date         Author                   Modification
 * 1.0   07-17-2021   junior95lima@gmail.com   Initial Version
**/
public class WidgetTriggerHandler {
       public static void adjustRecords(List<Widget__c> widgetList) {
        for (Widget__c unitWidget : widgetList) {
            if(unitWidget.Batch_Updated__c){
                /** USE THE GLOBAL MATCHER TO DEFINE IF IT IS NESTED OR NOT **/
                unitWidget.Is_Properly_Nested__c = WidgetNestedValidation.matcherLoop(unitWidget.Value__c);
            }
        }
    }
}