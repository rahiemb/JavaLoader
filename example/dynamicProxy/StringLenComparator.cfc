<cfcomponent output="false">

<!--- match methods to java.util.Comparator interface --->

<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction	name="onMissingMethod" access="public" returntype="any" output="false" hint="Since 'compare' and 'equals' are reserved method names, we have to escape them">
	<cfargument	name="missingMethodName" type="string"	required="true"	hint=""	/>
	<cfargument	name="missingMethodArguments" type="struct" required="true"	hint=""/>
	
	<cfset local = {}>
	
	<!--- call the same method name, just with an $ before it, so ColdFusion doesn't get upset --->
	<cfinvoke component="#this#" method="$#arguments.missingMethodName#" argumentcollection="#arguments.missingMethodArguments#" returnvariable="local.result">
	<cfif structKeyExists(local, "result")>
		<cfreturn local.result />
	</cfif>
</cffunction>

<cffunction name="$compare" hint="compares 2 objects" access="public" returntype="numeric" output="false">
	<cfargument name="obj1" hint="the first object" type="string" required="Yes">
	<cfargument name="obj2" hint="the second object" type="string" required="Yes">
	<cfscript>
		var len1 = Len(arguments.obj1);
		var len2 = Len(arguments.obj2);
		var result = 0;
		
		if(len1 lt len2)
		{
			result = -1;
		}
		else if(len1 gt len2)
		{
			result = 1;
		}
		
		//have to java cast to make sure it corresponds to the interface
		return JavaCast("int", result);
    </cfscript>
</cffunction>

<!--- we probably don't need the below function but to fulfil the inerface' --->
<cffunction name="$equals" hint=" Indicates whether some other object is 'equal to' this comparator." access="public" returntype="boolean" output="false">
	<cfscript>
		return false;    	    
    </cfscript>
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->

</cfcomponent>