
![SailPoint](https://files.accessiq.sailpoint.com/modules/builds/static-assets/perpetual/sailpoint/logo/1.0/sailpoint_logo_color_228x50.png)

# IdentityNow Rule Validator

Date: 2020-05-12

Version: 1.0.1

Author: [Neil McGlennon](neil.mcglennon@sailpoint.com)

## Overview

The IdentityNow Rule Validator is a simple tool to validate IdentityNow rules for malformed or incorrect code fragments, and help make sure they conform to the SailPoint IdentityNow Rule Guide before rule submission.  While this does check code fragments, it is not a code parser or linter; it does not check the code for syntax or completeness.  This is not designed to replace any sort of unit testing you might do outside of IdentityNow.

Running the IdentityNow Rule Validator against your rules before submission helps look for problems early on.  It is designed to help catch common items that often trip up rule reviews, and provide immediate feedback during the rule writing process.  This however is not a guarantee that the rule will be approved or doesn't have other flaws.  



## New Features

### Version 1.0.1

- Initial release!



## Requirements

Before you use this, you will need to follow the following instructions:

- Download and install [Ruby](https://www.ruby-lang.org/en/).  Verify you have Ruby 2.5+ installed by running the following:

```bash
$ ruby -v
ruby 2.5.0p0 (2017-12-25 revision 61468) [x86_64-darwin16]
```

*Note: No external networking is needed for this tool, other than downloading and installing the Ruby GEM.*

## Support / Features

This utility is developed by SailPoint Technology Services, and its usage is covered via SailPoint Expert Services.  If you have any issues, bugs, or feature requests, please submit them to SailPoint Expert Services.  

## Installation and Updates

*Note:  If using a Mac, the below commands will require you to use sudo to perform them.  To use sudo, simply put the term sudo in front of the command.  It will prompt you for your computer password if you haven't already authenticated in that terminal session.  Example: `sudo gem install identitynow_rule_validator`*

To install this gem in your local environment:

```bash
$ gem install identitynow_rule_validator
Successfully installed identitynow_rule_validator-1.0.1
Parsing documentation for identitynow_rule_validator-1.0.1
Done installing documentation for identitynow_rule_validator-1.0.1 after 0 seconds
1 gem installed
```

*Note: External networking is required to be able to download this tool from rubygems.org.*

### Update Installation

To check to see if the gem is out of date:

```bash
$ gem outdated|grep identitynow_rule_validator
identitynow_rule_validator (1.0.0 < 1.0.1)
```

To update the gem if out of date:

```bash
$ gem update identitynow_rule_validator
Updating installed gems
Updating identitynow_rule_validator
Fetching: identitynow_rule_validator-1.0.1.gem (100%)
Successfully installed identitynow_rule_validator-1.0.1
Parsing documentation for identitynow_rule_validator-1.0.1
Gems updated: identitynow_rule_validator
```

### Uninstall / Removal

To clean up your installation (This will uninstall all installed *identitynow_rule_validator* gems that are not current.):

```bash
$ sudo gem cleanup identitynow_rule_validator
Cleaning up installed gems...
Attempting to uninstall identitynow_rule_validator-1.0.1
Successfully uninstalled identitynow_rule_validator-1.0.1
Clean Up Complete
```



## Execution

This gem has a very simple  interface for execution.  All is needed is to call the *identitynow_rule_validator* by a simple Ruby script as follows:

File: `validate.rb`

```ruby
#!/usr/bin/env ruby
require 'identitynow_rule_validator'
IdentityNowRuleValidator.validate_directory( ARGV[0] )
```

You can modify your script as you see fit, to meet your needs.

The execution from the example will look something like this:

```
$ ./validate.rb "/tmp/rules"
--------------------------------------------------------------
 IdentityNow Rule Validator 
--------------------------------------------------------------
 Version: 1.0.1
 Date: 2020-05-12
 Author: Neil McGlennon (neil.mcglennon@sailpoint.com)
--------------------------------------------------------------
Validating files from directory: /tmp/rules
	Rule - BeforeProvisioning - Before Provisioning AD.xml
	Rule - CertificationExclusion - AD Certifiable Groups.xml
	Rule - Generic - Common Exclusion Rule Library.xml
	Rule - IdentityAttribute - Calculate Lifecycle State.xml
	Rule - IdentitySelector - Finance.xml
	Rule - JDBCProvision - Mainframe.xml
	Rule - WebServicesBeforeOperationRule - Generate Header.xml

/tmp/rules
Rule - CertificationExclusion - AD Certifiable Groups.xml

	Line 3: <Rule language='beanshell' name='AD Certifiable Groups' type='CertificationExc
	Warning: Deprecated Rule Type: CertificationExclusion rules are deprecated.  Consider configuration via certification campaign filters instead.

/tmp/rules
Rule - Generic - Common Exclusion Rule Library.xml

	Line 111: Custom custom = context.getObjectByName( Custom.class, listName );
	Error: Cannot get objects other than sailpoint.object.Identity or sailpoint.object.Link objects.

	Line 138: allowedRoles.add( context.getObject( Bundle.class, profileName ) );
	Error: Cannot get objects other than sailpoint.object.Identity or sailpoint.object.Link objects.

/tmp/rules
Rule - IdentitySelector - Finance.xml

	Line 3: <Rule language='beanshell' name='Finance' type='IdentitySele
	Warning: Deprecated Rule Type: IdentitySelector rules are deprecated.  Consider configuration via rule assignment criteria instead.

	Line 18: List links = identity.getLinks();
	Error: The function 'getLinks' is deprecated.  Use an identity search instead.

/tmp/rules
Rule - JDBCProvision - Mainframe.xml

	Line 24: System.out.println( "plan [" + plan.toXml() + "]" );
	Warning: Remove any System.out configurations in favor of logging statements.

	Line 49: System.out.println( "Operation [" + account.getOperation() + "] detected." );
	Warning: Remove any System.out configurations in favor of logging statements.

/tmp/rules
Rule - WebServicesBeforeOperationRule - Generate Header.xml

	Line 25: public static String genRandomString(boolean includeNumbers, boolean mixedCase,...
	Warning: Remove references to 'static' in methods. This can cause unexpected behavior.
```

