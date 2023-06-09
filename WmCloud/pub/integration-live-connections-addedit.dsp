<HTML>
  <HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>

  <SCRIPT>
  function validateData(){

    var addConnectionform = document.forms['addConnectionForm'];
    addConnectionform.localAction.value=addConnectionform.action.value;

    if(isblank(addConnectionform.aliasName.value)){
      alert("Alias Name is a required field.");
      addConnectionform.aliasName.focus();
      return false;
    }

    if(isblank(addConnectionform.retry.value)){
      alert("Maximum Reconnection Attempts is a required field.");
      addConnectionform.retry.focus();
      return false;
    }

    if ( !isInteger(addConnectionform.retry.value) ) {
      alert("Specify an integer value for the Maximum Reconnection Attempts parameter.");
      addConnectionform.retry.focus();
      return false;
    }

    if ( !isInteger(addConnectionform.timeToLive.value) ) {
      alert("Specify a valid integer value for the Request Timeout parameter.");
      addConnectionform.timeToLive.focus();
      return false;
    }

    if ( !isIntegerGreaterThan(addConnectionform.timeToLive.value, 0) ) {
      alert("Specify a value greater than 0 for the Request Timeout parameter.");
      addConnectionform.timeToLive.focus();
      return false;
    }

    if ( !isInteger(addConnectionform.timeToLiveCache.value) ) {
      alert("Specify a valid integer value for the Time to Live parameter.");
      addConnectionform.timeToLiveCache.focus();
      return false;
    }

    if(isblank(addConnectionform.runAsUser.value)){
      alert("Run As User is a required field");
      addConnectionform.runAsUser.focus();
      return false;
    }

    return true;
  }

  function testConnection() {

    if ( validateData() ) {
      var addConnectionform = document.forms['addConnectionForm'];
      addConnectionform.localAction.value="test";
      return true;
    }
    else {
      return false;
    }
  }

    function added(message)
    {
        var sURL = 'integration-live.dsp?action=addFrom&message=' + message;
        if (webMethods_wM_AdminUI) {
          sURL += '&webMethods-wM-AdminUI=true';
        }
        location.href=encodeURI(sURL);
    }

    function addFailed(message)
    {
        message = "Unable to create On-Premise Account. Error : " + message;
        var sURL = 'integration-live.dsp?action=addFrom&errorMessage=' + message;
        if (webMethods_wM_AdminUI) {
          sURL += '&webMethods-wM-AdminUI=true';
        }
        location.href=encodeURI(sURL);
    }

    function updated(message)
    {
        var sURL = 'integration-live.dsp?action=addFrom&message=' + message;
        if (webMethods_wM_AdminUI) {
          sURL += '&webMethods-wM-AdminUI=true';
        }
        location.href=encodeURI(sURL);
    }

    function updateFailed(message)
    {
        message = "Unable to update On-Premise Account. Error : " + message;
        var sURL = 'integration-live.dsp?action=addFrom&errorMessage=' + message;
        if (webMethods_wM_AdminUI) {
          sURL += '&webMethods-wM-AdminUI=true';
        }
        location.href=encodeURI(sURL);
    }

    </SCRIPT>

  </HEAD>
  %ifvar action equals('edit')%
  <BODY onLoad="setNavigation('integration-live-connections-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_EditAccountScrn');">
  %else%
  <BODY onLoad="setNavigation('integration-live-connections-addedit.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_webMethodsCloud_CreateAccountScrn');">
  %endif%

<FORM id="addConnectionForm" NAME="addConnectionForm" method="POST">
  %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
  <input type="hidden" name="originalKey" VALUE="%value key.toString() encode(html)%">
  <input type="hidden" name="action" VALUE="%value action encode(html)%">
  <input type="hidden" name="localAction" VALUE="">

  <TABLE WIDTH="100%">

%ifvar localAction%
%switch localAction%
%case 'test'%
  %invoke wm.client.integrationlive.connections:testUMConnection%
        %ifvar message%
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%
  %onerror%
    <tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
  %endinvoke%
%case 'add'%
  %invoke wm.client.integrationlive.connections:createUMConnection%
        %ifvar message%
      <SCRIPT>added("%value message encode(javascript)%")</SCRIPT>
     %endif%
  %onerror%
      <SCRIPT>addFailed("%value errorMessage encode(javascript)%")</SCRIPT>
  %endinvoke%
%case 'edit'%
  %invoke wm.client.integrationlive.connections:updateUMConnection%
        %ifvar message%
      <SCRIPT>updated("%value message encode(javascript)%")</SCRIPT>
     %endif%
  %onerror%
      <SCRIPT>updateFailed("%value errorMessage encode(javascript)%")</SCRIPT>
  %endinvoke%
%endswitch%
%endif%

            <TR>
                <TD class="breadcrumb" colspan="3">
                   webMethods Cloud &gt; Accounts &gt;
          %ifvar action equals('edit')%
            Edit Account
          %else%
            Create Account
          %endif%
                </TD>
            </TR>

            <TR>
                <TD colspan="3">
                    <UL class="listitems">
					<script>
					createForm("htmlform_integration_live2", "integration-live.dsp", "POST", "BODY");
					</script>
                        <LI>
						<script>getURL("integration-live.dsp", "javascript:document.htmlform_integration_live2.submit();", "Return to On-Premise Accounts");</script>
						</LI>
                    </UL>
                </TD>
            </TR>
            <TR>
            <TD width="70%">
        %ifvar localAction%
			
        %else%
          %ifvar action equals('edit')%
            %invoke wm.client.integrationlive.connections:getUMConnection%				
              %ifvar message%
                <tr><td colspan="3">&nbsp;</td></tr>
                <tr><td class="message" colspan="3">%value message encode(html)%</td></tr>
              %endif%
              %onerror%
                <tr><td colspan="3">&nbsp;</td></tr>
                <tr><td class="message" colspan=3>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
          %endif%
        %endif%

              <TABLE class="tableView">
                <TR>
                  <TD class="heading" colspan="2">General Settings</TD>
                </TR>
          <tr>
            <td class="evenrow">Enable</td>
            <td class="evenrow-l">
              <input type="radio" id="isEnabled1" name="isEnabled" value="true" %ifvar isEnabled equals('true')% checked %endif%><label for="isEnabled1">Yes</label></input>
              <input type="radio" id="isEnabled2" name="isEnabled" value="false" %ifvar isEnabled equals('false')% checked %endif%><label for="isEnabled2">No</label></input>
            </td>
          </tr>

          <TR>
						<TD class="oddrow" nowrap><label for="aliasName">Alias Name</label></TD>

            %ifvar action equals('edit')%
                <TD class="oddrow-l">
                  <INPUT NAME="aliasName" id="aliasName" TYPE="TEXT" VALUE="%value aliasName encode(htmlattr)%" SIZE="50" readonly="true" style="color:#808080;">
                 </TD>
            %else%
                <TD class="oddrow-l">
                  <INPUT NAME="aliasName" id="aliasName" TYPE="TEXT" VALUE="%value aliasName encode(htmlattr)%" SIZE="50">
                 </TD>
            %endif%
          </TR>

                <TR>
            			<TD class="evenrow" nowrap><label for="description">Description</label></TD>
                  <TD class="evenrow-l">
                      <INPUT NAME="description" id="description" TYPE="TEXT" VALUE="%value description encode(htmlattr)%" SIZE="103">
                   </TD>
                </TR>

                <TR>
                  <TD class="oddrow" nowrap>Tenant Alias</TD>
    
                  <TD class="oddrow-l">
                  %invoke wm.client.integrationlive.account:listTenantAliases%
                  %ifvar action equals('edit')%
					  <input type="hidden" name="tenantAlias" id="tenantAlias" VALUE="%value ../tenantAlias encode(htmlattr)%">
                      <select disabled>
                  %else%
					  <select name="tenantAlias" id="tenantAlias">
                  %endif%

                %loop TenantAliases%
                     <option size="15" width=30% %ifvar ../tenantAlias vequals(tenantAlias)% selected %endif%value="%value tenantAlias encode(html)%">%value tenantAlias encode(html)%</option>
                %endloop%
                </select>
                %endinvoke%
                   </TD>
              </TR>
    
    
          <TR>
						<TD class="oddrow" nowrap><label for="stage">Stage</label></TD>

            <TD class="oddrow-l">
                %invoke wm.client.integrationlive.connections:getStages%
                %ifvar action equals('edit')%
					<input type="hidden" name="stage" id="stage" VALUE="%value ../stage encode(htmlattr)%">
                    <select disabled>
                %else%
					<select name="stage" id="stage">
                %endif%

                %loop stages%
                  <option size="15" width=30% %ifvar ../stage vequals(stageKey)% selected %endif%value="%value stageKey encode(html)%">%value stageDisplay encode(html)%</option>
                %endloop%
                </select>
                %endinvoke%
             </TD>
          </TR>

                <TR>
                  <TD class="heading" colspan="2">Account Settings</TD>
                </TR>

                <TR>
            			<TD class="evenrow" nowrap><label for="retry">Maximum Reconnection Attempts</label></TD>
                  <TD class="evenrow-l">
                    %ifvar action equals('edit')%
                       <INPUT NAME="retry" id="retry" TYPE="TEXT" VALUE="%value retry encode(htmlattr)%">
                     %else%
                %ifvar localAction equals('test')%
                  <INPUT NAME="retry" id="retry" TYPE="TEXT" VALUE="%value retry encode(htmlattr)%">
                %else%
                  <INPUT NAME="retry" id="retry"  TYPE="TEXT" VALUE="5">
                %endif%
                     %endif%
                   </TD>
                </TR>

          <TR>
            			<TD class="oddrow" nowrap><label for="timeToLive">Request Timeout</label></TD>
                  <TD class="oddrow-l">
                    %ifvar action equals('edit')%
                       <INPUT NAME="timeToLive" id="timeToLive" TYPE="TEXT" VALUE="%value timeToLive encode(htmlattr)%">
                     %else%
                %ifvar localAction equals('test')%
                  <INPUT NAME="timeToLive" id="timeToLive" TYPE="TEXT" VALUE="%value timeToLive encode(htmlattr)%">
                %else%
                  <INPUT NAME="timeToLive" id="timeToLive"  TYPE="TEXT" VALUE="60000">
                %endif%
                     %endif%
              milliseconds
                   </TD>
                </TR>

          <TR>
            			<TD class="evenrow" nowrap><label for="timeToLiveCache">Time to Live</label></TD>
                  <TD class="evenrow-l">
                    %ifvar action equals('edit')%
                       <INPUT NAME="timeToLiveCache" id="timeToLiveCache" TYPE="TEXT" VALUE="%value timeToLiveCache encode(htmlattr)%">
                     %else%
                %ifvar localAction equals('test')%
                  <INPUT NAME="timeToLiveCache" id="timeToLiveCache" TYPE="TEXT" VALUE="%value timeToLiveCache encode(htmlattr)%">
                %else%
                  <INPUT NAME="timeToLiveCache" id="timeToLiveCache"  TYPE="TEXT" VALUE="60">
                %endif%
                     %endif%
              seconds
                   </TD>
                </TR>

                <TR>
            			<TD class="oddrow" nowrap><label for="onPremiseHosts">Allowed On-Premise Hosts</label></TD>
                  <TD class="oddrow-l">
                    %ifvar action equals('edit')%
                       <INPUT NAME="onPremiseHosts" id="onPremiseHosts" TYPE="TEXT" VALUE="%value onPremiseHosts encode(htmlattr)%" SIZE="103">
                     %else%
                       <INPUT NAME="onPremiseHosts" id="onPremiseHosts" TYPE="TEXT" VALUE="%value onPremiseHosts encode(htmlattr)%" SIZE="103">
                     %endif%

                      Comma (,) separated IP Addresses
                   </TD>
                </TR>

          <!--  RUN AS USER SUB -->
          <SCRIPT>
            //This function can be changed to do something with the user
            function callback(val){
            document.addConnectionForm.runAsUser.value=val;
            }
          </SCRIPT>

          <TR>
						  <TD class="evenrow"><label for="runAsUser">Run As User</label></TD>
              <TD class="evenrow-l">
              <input name="runAsUser" id="runAsUser" size=20 value="%value runAsUser%"></input>
              <link rel="stylesheet" type="text/css" href="../WmRoot/subUserLookup.css" />
              <script type="text/javascript" src="../WmRoot/subUserLookup.js"></script>
              <a class="submodal" href="../WmRoot/subUserLookup.dsp"><img border=0 align="bottom" alt="Select Run As User"  src="../WmRoot/icons/magnifyglass.gif"/></a>
              </TD>
          </TR>
          <!-- END RUN AS USER SUB -->
		  
					<input type="hidden" name="isEnabled" VALUE="%value isEnabled%">

          <TR>
            <TD colspan="3" class="action" >
              <INPUT type="submit" value="Test Account Settings" onClick="return testConnection();">
              <input type="submit" name="submit" value="Save Changes" onclick="return validateData();">
            </TD>
          </TR>

              </TABLE>
            </TD>
            </TR>
    </TABLE>
  </FORM>
 </BODY>
</HTML>
