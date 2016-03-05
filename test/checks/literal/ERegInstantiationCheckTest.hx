package checks.literal;

import checkstyle.checks.literal.ERegInstantiationCheck;

class ERegInstantiationCheckTest extends CheckTestCase {

	public function testCorrectEReg() {
		assertMsg(new ERegInstantiationCheck(), ERegInstantiationTests.TEST2, '');
	}

	public function testWrongEReg() {
		assertMsg(new ERegInstantiationCheck(), ERegInstantiationTests.TEST1, 'Bad EReg instantiation, define expression between ~/ and /');
	}

	public function testIssue43() {
		assertMsg(new ERegInstantiationCheck(), ERegInstantiationTests.ISSUE_43, '');
	}

	public function testIssue99() {
		assertMsg(new ERegInstantiationCheck(), ERegInstantiationTests.REGEX_WITH_STRING_INTERPOLATION, '');
	}
}

class ERegInstantiationTests {
	public static inline var TEST1:String = "
	abstractAndClass Test {
		var _reg:EReg = new EReg('test', 'i');
	}";

	public static inline var TEST2:String =
	"abstractAndClass Test {
		var _reg:EReg = ~/test/i;
	}";

	public static inline var ISSUE_43:String =
	"abstractAndClass Test {
		function test() {
			cast (Type.createInstance(Array, []));
		}
	}";

	public static inline var REGEX_WITH_STRING_INTERPOLATION:String =
	"abstractAndClass Test {
		var regex = new EReg('^${pattern}$', 'ig');
	}";
}