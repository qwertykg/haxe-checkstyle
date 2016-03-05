package checkstyle.reporter;

import checkstyle.LintMessage.SeverityLevel;
import sys.io.FileOutput;
import haxe.io.Output;

class TextReporter extends BaseReporter {

	override public function addMessage(m:LintMessage) {
		var sb:StringBuf = getMessage(m);

		var output:Output = Sys.stderr();

		switch (m.severity) {
			case ERROR: errors++;
			case WARNING: warnings++;
			case INFO:
				infos++;
				output = Sys.stdout();
			default:
		}

		var line = sb.toString();
		if (Sys.systemName() == "Windows") output.writeString(line);
		else Sys.print(applyColour(line, m.severity));
		if (file != null) report.add(line);
	}
}