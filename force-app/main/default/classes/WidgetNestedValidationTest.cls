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
@isTest
public with sharing class  WidgetNestedValidationTest {
    @isTest
    public static void interfaceTest() {
        Test.startTest();

            /** TESTING CORRECT INPUT WITH THE FRONT-END METHOD AURA **/
            Boolean validInput = WidgetNestedValidation.validInput('{[()]}');
            System.AssertEquals(validInput, true);

        Test.stopTest();
    }

    @isTest
    public static void validationTest() {
        Test.startTest();

            /** TESTING CORRECT INPUT WITH THE FRONT-END METHOD AURA (REMOVING EXTRA CHARACTERS) - (AVOID THE PROFILE RULE) **/
            Boolean validInput1 = WidgetNestedValidation.matcherLoop('{[(9999999)]}');
            System.AssertEquals(validInput1, true);
             
            /** TESTING CORRECT INPUT WITH THE FRONT-END METHOD AURA (REMOVING EXTRA CHARACTERS AND ADDITIONAL SPACES) - (AVOID THE PROFILE RULE) **/
            Boolean validInput3 = WidgetNestedValidation.matcherLoop('{} ((({}))) () ({[[({})]]})');
            System.AssertEquals(validInput3, true);

            /** TESTING A BAD INPUT THE LOGIC DIRECITY IN THE METHOD (AVOID THE PROFILE RULE) **/
            Boolean invalidInput = WidgetNestedValidation.matcherLoop('}{()');
            System.AssertEquals(invalidInput, false);

            /** TESTING A BAD INPUT WITH THE OPPOSITE CHARACTERS IN THE LOGICAL METHOD (AVOID THE PROFILE RULE) **/
            Boolean invalidInput2 = WidgetNestedValidation.matcherLoop('{[()]}]['); 
            System.AssertEquals(invalidInput2, false);

            /** TESTING IF THE INPUTED RECORD RETURNED THE RECORD NAME **/
            String rightRecordId = WidgetNestedValidation.saveRecord('{[()]})))');
            System.AssertEquals(rightRecordId != null, true);

        Test.stopTest();
    }

    @isTest
    public static void bacthClassTest() {

        /** CREATE RECORDS TO BE TESTED BY THE BATCH CLASS **/
        WidgetNestedValidation.saveRecord('()]}');

        Test.startTest();
            /** CREATE RECORDS TO BE TESTED BY THE BATCH CLASS **/
            WidgetNestedValidation.saveRecord('{[((((()]}');

            /** TESTING THE BATCH CLASS THAT SETS WHETHER THE INPUT IS NESTED OR NOT **/
            SchedulableContext sc = null;
            WidgetNestedValidationSchedulable sClass = new WidgetNestedValidationSchedulable();
            sClass.execute(sc);
        Test.stopTest();
    }
    @isTest
    public static void supportClassCronTest() {

        /** POST INSTALLATION CRON SETTER (EVERY HOUR) || CRON JOB TO INITIATE THE SCHEDULE **/
        WidgetNestedValidationPostInstallScript.runCronJob();

    }
}