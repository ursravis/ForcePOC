global class Scrims_ProjectBatch implements Database.Batchable<SObject>, Database.AllowsCallouts, Database.Stateful {
	
	global Scrims_ProjectBatch() {
		
	}
	
	/**
	 * @description gets invoked when the batch job starts
	 * @param context contains the job ID
	 * @returns the record set as a QueryLocator object that will be batched for execution
	 */ 
	global Database.QueryLocator start(Database.BatchableContext context) {
		System.debug('Batch Started');
		return 
		Database.getQueryLocator('SELECT CreatedById, CreatedDate, EntityID__c,EntityName__c,Id, IsDeleted,LastModifiedById,LastModifiedDate, Name, OwnerId, RetryCount__c,Status__c, SystemModstamp FROM Scrims_QueueData__c Where Status__c=\'InQueue\'');
	}

	/**
	 * @description gets invoked when the batch job executes and operates on one batch of records. Contains or calls the main execution logic for the batch job.
	 * @param context contains the job ID
	 * @param scope contains the batch of records to process.
	 */ 
   	global void execute(Database.BatchableContext context, List<Scrims_QueueData__c> scope) {
		System.debug('Batch Executtion');
		String	projectData='';
		for(Scrims_QueueData__c queueProject : scope)
		{ 
			String aaa='Project Name: '+ queueProject.EntityName__c + 'Project ID: '+ queueProject.EntityID__c + '\n';
			projectData= projectData+ aaa;
			queueProject.Status__c='Success';
		}
		UPDATE scope;

		//send emails
		 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			// Send the email to the job submitter
			String[] toAddresses = new String[] {'ravi.aakula@fox.com'};
			mail.setToAddresses(toAddresses);
			mail.setSenderDisplayName('Batch Processing');
			mail.setSubject('Projects Created  ' );
			mail.setPlainTextBody('Following  Project Created '+ '\n' +projectData);
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
	/**
	 * @description gets invoked when the batch job finishes. Place any clean up code in this method.
	 * @param context contains the job ID
	 */ 
	global void finish(Database.BatchableContext context) {
		System.debug('Batch Finished');

	}
}