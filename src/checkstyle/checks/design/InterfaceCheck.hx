package checkstyle.checks.design;

/**
	Checks and enforces interface style. Either to allow properties and methods or just methods. Has an option to "allowMarkerInterfaces".
**/
@name("Interface")
@desc("Checks and enforces interface style. Either to allow properties and methods or just methods. Has an option to `allowMarkerInterfaces`.")
class InterfaceCheck extends Check {
	/**
		allows empty marker interfaces, or forbid their use
	**/
	public var allowMarkerInterfaces:Bool;

	/**
		allow properties inside interface types
	**/
	public var allowProperties:Bool;

	public function new() {
		super(TOKEN);
		allowMarkerInterfaces = true;
		allowProperties = false;
		categories = [Category.COMPLEXITY, Category.STYLE];
		points = 13;
	}

	override function actualRun() {
		var root:TokenTree = checker.getTokenTree();
		var interfaces:Array<TokenTree> = root.filter([Kwd(KwdInterface)], ALL);
		for (intr in interfaces) {
			var functions:Array<TokenTree> = intr.filter([Kwd(KwdFunction)], ALL);
			var vars:Array<TokenTree> = intr.filter([Kwd(KwdVar)], ALL);

			if (functions.length == 0 && vars.length == 0) {
				if (allowMarkerInterfaces) continue;
				else logPos("Marker interfaces are not allowed", intr.pos);
			}

			if (!allowProperties && vars.length > 0) logPos("Properties are not allowed in interfaces", intr.pos);
		}
	}

	override public function detectableInstances():DetectableInstances {
		return [{
			fixed: [],
			properties: [{
				propertyName: "allowMarkerInterfaces",
				values: [true, false]
			}, {
				propertyName: "allowProperties",
				values: [true, false]
			}]
		}];
	}
}