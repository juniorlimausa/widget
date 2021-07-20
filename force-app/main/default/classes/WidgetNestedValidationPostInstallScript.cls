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
public with sharing class WidgetNestedValidationPostInstallScript {
    public static String cronCommand = '0 0 * * * ?';
    public static String runCronJob() {
        /** INITIATE THE CRON ROUTINE (EVERY HOUR) **/
        WidgetNestedValidationSchedulable scClass = new WidgetNestedValidationSchedulable(); 
        return System.schedule('WidgetNestedValidationSchedulable - Every Hour', cronCommand, scClass);
    }
}