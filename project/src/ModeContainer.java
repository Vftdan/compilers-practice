import java.util.*;

public class ModeContainer {
	protected String name = "";
	public final List<String> lexerRules = new ArrayList<String>();
	
	public String getName() {
		return name;
	}

	public ModeContainer(String name) {
		this.name = name;
	}
}
