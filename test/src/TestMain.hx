package ;

import promhx.Promise;
import com.dal.common.unit.TestResult;

/**
 * 	Entry point for unit tests.
 */
class TestMain
{
	/**
	 * Run the unit tests.
	 */
	public static function main()
	{
		var runner = new com.dal.common.unit.TestRunner();

		runner.add(new com.dal.mongotest.TestPromUtil());

		//runner.add(new com.dal.mongotest.TestMongo());
		//runner.add(new com.dal.mongotest.TestAdmin());
		//runner.add(new com.dal.mongotest.TestMongoose());

		var prom:Promise<TestResult> = runner.run();
		prom.then(function(result) { onTestRunComplete(result); return result; } );
	}

	/**
	 * Called when the TestRunner is finished running all tests.
	 * @param 	result - the TestResult containing the test results.
	 */
	private static function onTestRunComplete(result:TestResult) : Void
	{
		// Do nothing.
	}
	
} // End of TestMain class
