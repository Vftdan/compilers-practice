import java.util.*;
import java.util.regex.*;

public class DependentRegexpResolver {
	public final Map<String, String> resolved = new HashMap<String, String>();
	Map<String, String> initial;
	static final Pattern substitutionPattern = Pattern.compile("(?<=(^|[^\\\\])(\\\\\\\\){0,128})\\/([A-Za-z0-9_]+)\\/");
	static final Pattern backslash = Pattern.compile("\\\\");
	static final Pattern dollar = Pattern.compile("\\$");
	static final String substitutionPatternPrefix = "(?<=(^|[^\\\\])(\\\\\\\\){0,128})\\/";
	static final String substitutionPatternPostfix = "\\/";
	
	private Map<String, Set<String>> dependencies;
	
	public DependentRegexpResolver(Map<String, String> initial) {
		if(initial == null)
			this.initial = new HashMap<String, String>();
		else
			this.initial = initial;
	}
	
	static String escapeSubstitutable(String orig) {
		return dollar.matcher(backslash.matcher(orig).replaceAll("\\\\\\\\")).replaceAll("\\\\\\$");
	}
	
	public void resolve() {
		Map<String, String> unresolved = new HashMap<String, String>(initial);
		dependencies = new HashMap<String, Set<String>>();
		for(String ident: unresolved.keySet()) {
			Set<String> curDep;
			dependencies.put(ident, curDep = new HashSet<String>());
			Matcher matcher = substitutionPattern.matcher(unresolved.get(ident));
			//System.out.print(ident + ":");
			while(matcher.find()) {
				//System.out.print(" " + matcher.group(3));
				curDep.add(matcher.group(3));
			}
			//System.out.println("");
		}
		while(unresolved.size() > 0) {
			boolean changed = false;
			for(String ident: new HashSet<String>(unresolved.keySet())) {
				if(dependencies.get(ident).size() == 0) {
					changed = true;
					resolved.put(ident, unresolved.get(ident));
					unresolved.remove(ident);
					Pattern ptn = Pattern.compile(substitutionPatternPrefix + ident + substitutionPatternPostfix);
					for(String otherIdent: new HashSet<String>(unresolved.keySet())) {
						if(dependencies.get(otherIdent).contains(ident)) {
							dependencies.get(otherIdent).remove(ident);
							unresolved.put(otherIdent, ptn.matcher(unresolved.get(otherIdent)).replaceAll("(" + escapeSubstitutable(resolved.get(ident)) + ")"));
						}
					}
				}
			}
			if(!changed) {
				System.err.println("Warning: There are unresolved regexps");
				break;
			}
		}
		for(String ident: new HashSet<String>(unresolved.keySet())) {
			resolved.put(ident, substitutionPattern.matcher(unresolved.get(ident)).replaceAll("\\\\_.{-}"));
			unresolved.remove(ident);
		}
	}
}
