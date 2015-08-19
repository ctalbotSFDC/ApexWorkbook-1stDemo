<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>email_Technician</fullName>
        <description>email Technician</description>
        <protected>false</protected>
        <recipients>
            <field>Technician__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Festival_Emails_solution/Maintenance_Notification_solution</template>
    </alerts>
    <rules>
        <fullName>Alert Technician</fullName>
        <actions>
            <name>email_Technician</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>ticket_opened</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <formula>IF(isnull(Technician__r.Email), false, true)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>ticket_opened</fullName>
        <assignedTo>ctalbot@apexworkbook.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Maintenance_Ticket__c.CreatedDate</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>ticket opened!</subject>
    </tasks>
</Workflow>
