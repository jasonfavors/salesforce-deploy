trigger SampleAccountTrigger on Account (before insert) {
  Account account;

  for (Integer i = 0; i < Trigger.new.size(); i++) {
    Trigger.new[i].Phone = SampleDeployClass.getPhone();
  }
}
