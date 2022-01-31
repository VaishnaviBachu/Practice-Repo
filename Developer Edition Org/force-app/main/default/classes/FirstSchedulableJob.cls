global class FirstSchedulableJob implements Schedulable {
    global void execute(SchedulableContext ctx) {
        account acc = new account(Name='Schedule Testing', Phone='6453234522');
        insert acc;
                
    }
}