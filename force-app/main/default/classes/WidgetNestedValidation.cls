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
public with sharing class WidgetNestedValidation {

    static String inputToAnalyse = '';
    static String outputToAnalyse = '';
    static Integer assetLenght = 0;

    /** AURA ENABLED FUNCTION TO THE USER INTERFACE **/
    @AuraEnabled
    public static Boolean validInput(string inputText) {

        /** FRONT-END CHECK THE INPUT DATA AND THE USER PROFILE **/
       Profile currentUserProfile = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
       return (matcherLoop(inputText) || (currentUserProfile.Name == 'Widget Masters' || currentUserProfile.Name == 'System Administrator'));
    }

    /** AURA ENABLED FUNCTION TO INSERT A NEW WIDGET RECORD **/
    @AuraEnabled
    public static string saveRecord(string inputText) {
        Widget__c newWidget = new Widget__c();
        newWidget.Value__c = inputText;
        insert newWidget;

        if (newWidget.Id != null) {
            Widget__c newWidgetRecordCreated = [SELECT 
            Name FROM Widget__c where Id =: newWidget.Id LIMIT 1];
            return newWidgetRecordCreated.Name;
        }
        
        return null;
    }

    public static Boolean matcherLoop(String inputText) {

        /** REGEX TO FILTER ONLY CHARACTHERS THAT ARE IN THE SCOPE OF THE LOGIC **/
        Matcher validCharacters = Pattern.compile('[{]|[}]|[\\[]|[\\]]|[(]|[)]').matcher(inputText);
        while (validCharacters.find()){
            inputToAnalyse += validCharacters.group(0);
        } 

        /** REMOVE REPETITIVE SCENARIOS THAT ARE DETERMINISTIC FOR THE REGEX REGRATION **/
        while (inputToAnalyse.contains('((') || inputToAnalyse.contains('))') ||
        inputToAnalyse.contains('[[') || inputToAnalyse.contains(']]') ||
        inputToAnalyse.contains('{{') || inputToAnalyse.contains('}}') ||
        inputToAnalyse.contains('()') || inputToAnalyse.contains('{}') ||
        inputToAnalyse.contains('[]')){
            inputToAnalyse = inputToAnalyse
            .replace(' ','').replace('()','').replace('[]','')
            .replace('{}','').replace('((','(').replace('))',')')
            .replace('[[','[').replace(']]',']')
            .replace('{{','{').replace('}}','}');
        } 

        /** REGEX TO FIND INPUTS AND OUTPUTS FOR THE ALL THREE POSSIBLE CASES **/
        Matcher masterMatcher = Pattern.compile('\\[[^\\[\\]]*\\]|\\([^()]*\\)|\\{[^{}]*\\}').matcher(inputToAnalyse);
        while (masterMatcher.find()){
            /** CONCATENATE ALL INPUTS IN ONLY ONE STRING OUTPUT **/
            outputToAnalyse += String.valueOf(masterMatcher.group());
        } 

        /** LOGIC TO AVOID INVERTED INPUTS AFTER THE REGEX REGREATION **/
        if (inputToAnalyse.contains('][') || inputToAnalyse.contains('}{') ||
        inputToAnalyse.contains(')(')) {
            return false;
        /** PURE LENGHT LOGIC TO AVOID OUSITE INPUTS (NOT SORTED IN THE FINAL REGEX STRING) **/
        }else if(outputToAnalyse.length() != inputToAnalyse.length()) {
            return false;
        }else{
            return true;
        }
    }
}