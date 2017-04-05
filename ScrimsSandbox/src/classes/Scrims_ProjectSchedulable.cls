global class Scrims_ProjectSchedulable implements Schedulable {
	/**
	 * @description Executes the scheduled Apex job. 
	 * @param sc contains the job ID
	 */ 
	global void execute(SchedulableContext sc) {
		System.debug('Scheduled Job Started');
		Scrims_ProjectBatch batchClass=new Scrims_ProjectBatch();
		Id jobId=Database.executeBatch(batchClass);
	}
}