trigger Scrims_Project on Scrims_Project__c (after insert)  { 

	for (Scrims_Project__c project : Trigger.New)
	{
		if(Trigger.isInsert)
		{
				System.debug('project inserted');

				//Scrims_ProjectQueueble job = new Scrims_ProjectQueueble();
				//job.max = 2;
				//job.projectToProcess = project;
        		//System.enqueueJob(job); 

				Scrims_QueueData__c queueData=new Scrims_QueueData__c();
				queueData.EntityName__c=project.Name;
				queueData.EntityID__c=project.ID;
				queueData.Status__c='InQueue';
				insert queueData;

				System.debug('started new job inserted');
		}
	}

}