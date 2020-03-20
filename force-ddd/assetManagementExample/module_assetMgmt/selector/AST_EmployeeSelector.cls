public class AST_EmployeeSelector {
  
    public AST_Schema.Employee getEmployeeById(String employeeId) {
        // Employee__c employeeObj = [SELECT Id, Name, Location__c, Start_Date__c, External_ID__c
        //                              FROM Employee__c
        //                             WHERE External_ID__c = :employeeId];
 
        AST_Schema.Employee result = new AST_Schema.Employee();
        // result.employeeId = employeeObj.External_ID__c;
        // result.employeeLocation = employeeObj.Location__c;
        // result.employeeStartDate = employeeObj.Start_Date__c;
 
        return result;
    }
 }
 
 