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

		runner.add(new com.dal.mongotest.TestMongo());

		var prom:Promise<TestResult> = runner.run();
		prom.then(function(result) { onTestRunComplete(result); return result; } );
	}

	/**
	 * Called when the TestRunner is finished running all tests.
	 * @param 	result - the TestResult containing the test results.
	 */
	private static function onTestRunComplete(result:TestResult) : Void
	{
		//#if sys
		//Sys.exit(result.success ? 0 : 1);
		//#end
	}
	
} // End of TestMain class
