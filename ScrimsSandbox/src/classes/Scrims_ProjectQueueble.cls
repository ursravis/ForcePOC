public class Scrims_ProjectQueueble implements Queueable,Database.AllowsCallouts {
	public	Integer max;
	public Integer counter=1;
	public Scrims_Project__c projectToProcess;
	public void	execute(QueueableContext context)
	{
			System.debug('Counter: '+counter);
			HttpRequest req = new HttpRequest();
			req.setEndpoint('http://requestb.in/1lafoi61');
			req.setMethod('GET');
			Http http = new Http();
			HttpResponse resp = http.send(req);
			String html = resp.getBody();
			System.debug('Request: ' + req.toString());
			System.debug('Body: ' + html);
			counter=counter+1;
			
			if(max >= counter) {
				Scrims_ProjectQueueble job = new Scrims_ProjectQueueble();
				job.max = max;
				job.counter = counter;
				job.projectToProcess=projectToProcess;
        		System.enqueueJob(job);    
			}

		else{
			 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			// Send the email to the job submitter
			String[] toAddresses = new String[] {'ravi.aakula@fox.com'};
			mail.setToAddresses(toAddresses);
			mail.setSenderDisplayName('Queue Processing');
			mail.setSubject('Project Created  '+ projectToProcess.Name );
			String aaa='Project Name: '+ projectToProcess.Name + 'Project ID: '+ projectToProcess.ID + '\n';
			mail.setPlainTextBody('New Project Created ' +aaa);

			// Add your attachment to the email. 

			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });


		}
	}
}