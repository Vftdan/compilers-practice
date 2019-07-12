import java.util.*;

public class ModeContainer {
	protected String name = "";
	public final List<String> lexerRules = new ArrayList<String>();
	public final List<String> endRules = new ArrayList<String>();
	public final List<String> startRules = new ArrayList<String>();
	public String mainStartRule = null;
	public boolean written = false;
	
	public String getName() {
		return name;
	}
	
	public ModeContainer(String name) {
		this.name = name;
	}
}
