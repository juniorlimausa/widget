/**
 * @description       : 
 * @author            : junior.lima
 * @group             : 
 * @last modified on  : 07-20-2021
 * @last modified by  : junior.lima
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   07-20-2021   junior.lima   Initial Version
**/
global class WidgetNestedValidationSchedulable implements Schedulable
{
    global void execute(SchedulableContext ctx) {
        WidgetNestedValidationBatch scClass = new WidgetNestedValidationBatch();
        database.executeBatch(scClass);
     }  
}