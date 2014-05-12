@isTest
public class SampleDeployClass {

  static testMethod void testHelloWorld() {
    Account testAccount, queriedAccount;

    helloMethod();

    // Test insert trigger
    testAccount = new Account(Name= 'fred');
    insert testAccount;

    // Check that the trigger properly set the phone field
    queriedAccount = [select Id,
                             Phone
                      from Account
                      where Id = :testAccount.Id];

    System.assertEquals(getPhone(), queriedAccount.Phone);
  }

  public static String getPhone() {
    return 'SamplePhone#';
  }
  
  private static void helloMethod() {
    System.debug('Hello World');
  }
}
