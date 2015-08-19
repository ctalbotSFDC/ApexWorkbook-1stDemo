<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Date_2</fullName>
        <field>Date_Completed_2nd_Review__c</field>
        <formula>NOW()</formula>
        <name>Update Date 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Initial_Date</fullName>
        <field>Date_Initial_Completed__c</field>
        <formula>NOW()</formula>
        <name>Update Initial Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Date 1</fullName>
        <actions>
            <name>Update_Initial_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Review_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Completed-Initial</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Date 2</fullName>
        <actions>
            <name>Update_Date_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Review_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Re-Review Completed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
