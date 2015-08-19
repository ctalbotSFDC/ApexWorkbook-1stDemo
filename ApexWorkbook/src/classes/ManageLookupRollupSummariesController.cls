/**
 * Copyright (c) 2013, Andrew Fawcett
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the Andrew Fawcett, nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

public with sharing class ManageLookupRollupSummariesController {

	public LookupRollupSummary__mdt LookupRollupSummary {get;set;}

	public String selectedLookup {get;set;}

	public ManageLookupRollupSummariesController() {
		LookupRollupSummary = new LookupRollupSummary__mdt();
	}

	public List<SelectOption> getLookups() {
		// List current rollup custom metadata configs
		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('[new]','Create new...'));
		for(LookupRollupSummary__mdt rollup : 
				[select DeveloperName, Label from LookupRollupSummary__mdt order by Label])
			options.add(new SelectOption(rollup.DeveloperName,rollup.Label));
		return options;
	}

	public PageReference init() {
		// URL parameter?
		selectedLookup = ApexPages.currentPage().getParameters().get('developerName');		
		if(selectedLookup!=null)
		{
			LookupRollupSummary = 
				[select 
					Id,
					Label,
					Language,
					MasterLabel,
					NamespacePrefix,
					DeveloperName,
					QualifiedApiName,
					ParentObject__c,
					RelationshipField__c,
					ChildObject__c,
					RelationshipCriteria__c,
					RelationshipCriteriaFields__c,
					FieldToAggregate__c,
					FieldToOrderBy__c,
					Active__c,
					CalculationMode__c,
					AggregateOperation__c,
					CalculationSharingMode__c,
					AggregateResultField__c,
					ConcatenateDelimiter__c,
					CalculateJobId__c,
					Description__c 
				from LookupRollupSummary__mdt 
				where DeveloperName = :selectedLookup];
		}
		return null;
	}

	public PageReference load() {
		// Reload the page
		PageReference newPage = Page.managelookuprollupsummaries;
		newPage.setRedirect(true);
		if(selectedLookup != '[new]')
			newPage.getParameters().put('developerName', selectedLookup);
		return newPage;
	}

	public PageReference save() {
		try {
			// Insert / Update the rollup custom metadata
			if(LookupRollupSummary.Id==null)
				CustomMetadataService.createMetadata(new List<SObject> { LookupRollupSummary });
			else
				CustomMetadataService.updateMetadata(new List<SObject> { LookupRollupSummary });
			// Reload this page (and thus the rollup list in a new request, metadata changes are not visible until this request ends)
			PageReference newPage = Page.managelookuprollupsummaries;
			newPage.setRedirect(true);
			newPage.getParameters().put('developerName', LookupRollupSummary.DeveloperName);
			return newPage;			
		} catch (Exception e) {
			ApexPages.addMessages(e);
		}
		return null;
	}

	public PageReference deleteX() {
		try {
			// Delete the rollup custom metadata
			CustomMetadataService.deleteMetadata(
				LookupRollupSummary.getSObjectType(), new List<String> { LookupRollupSummary.DeveloperName });
			// Reload this page (and thus the rollup list in a new request, metadata changes are not visible until this request ends)
			PageReference newPage = Page.managelookuprollupsummaries;
			newPage.setRedirect(true);
			return newPage;			
		} catch (Exception e) {
			ApexPages.addMessages(e);
		}
		return null;
	}	
}