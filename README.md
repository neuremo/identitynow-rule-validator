
![SailPoint](https://files.accessiq.sailpoint.com/modules/builds/static-assets/perpetual/sailpoint/logo/1.0/sailpoint_logo_color_228x50.png)

# IdentityNow Rule Validator

Date: 2020-01-28

Version: 1.0.0b

Author: [Neil McGlennon](neil.mcglennon@sailpoint.com)

## Overview

A tool to validate IdentityNow rules to make sure they conform to IdentityNow Rule Guidelines.



## Build and Deploy

Build the Gem:

```bash
$ gem build identitynow_rule_validator.gemspec 
Enter PEM pass phrase:
  Successfully built RubyGem
  Name: identitynow_rule_validator
  Version: 1.0.0b
  File: identitynow_rule_validator-1.0.0b.gem
```

Install the Gem (Locally):

```bash
$ gem install --local identitynow_rule_validator-1.0.0b.gem
Password:
Successfully installed identitynow_rule_validator-1.0.0b
Parsing documentation for identitynow_rule_validator-1.0.0b
Installing ri documentation for identitynow_rule_validator-1.0.0b
Done installing documentation for identitynow_rule_validator after 0 seconds
1 gem installed
```

Publish gem:

```bash
$ gem push identitynow_rule_validator-1.0.0b.gem 
Enter your RubyGems.org credentials.
Don't have an account yet? Create one at https://rubygems.org/sign_up
   Email:   neil.mcglennon@sailpoint.com
Password:   

Signed in.
Pushing gem to https://rubygems.org...
Successfully registered gem: identitynow_rule_validator (1.0.0b)
```

Remove old version gem:

```bash
$ gem yank identitynow_rule_validator -v 0.0.1b
Yanking gem from https://rubygems.org...
Successfully deleted gem: identitynow_rule_validator (0.0.1b)
```



## Prerequisites / Installation

Before you use this, you will need to follow the following instructions:

- Download and install [Ruby](https://www.ruby-lang.org/en/). If you are running a macOS, we recommend installing this via [Homebrew](https://brew.sh/) by running:

```bash
$ brew install ruby
```

- Verify you have Ruby 2.5+ installed by running the following:

```bash
$ ruby -v
ruby 2.5.0p0 (2017-12-25 revision 61468) [x86_64-darwin16]
```

- Install the **Colorize** gem:

```bash
$ gem install colorize
Successfully installed colorize-0.8.1
Parsing documentation for colorize-0.8.1
Done installing documentation for colorize after 0 seconds
1 gem installed
```



### Installation and Updates

NOTE:  If using a Mac, the below commands will require you to use sudo to perform them.  To use sudo, simply put the term sudo in front of the command.  It will prompt you for your computer password if you haven't already authenticated in that terminal session.  Example: `sudo gem install identitynow_rule_validator`

To install this gem in your local environment:

```bash
$ gem install identitynow_rule_validator --pre
Successfully installed identitynow_rule_validator-1.0.0b
Parsing documentation for identitynow_rule_validator-1.0.0b
Done installing documentation for identitynow_rule_validator-1.0.0b after 0 seconds
1 gem installed
```

To check to see if the gem is out of date:

```bash
$ gem outdated|grep identitynow_rule_validator
identitynow_rule_validator (0.0.1b < 1.0.0b)
```

To update the gem if out of date:

```bash
$ gem update identitynow_rule_validator
Updating installed gems
Updating identitynow_rule_validator
Fetching: identitynow_rule_validator-1.0.0b.gem (100%)
Successfully installed identitynow_rule_validator-1.0.0b
Parsing documentation for identitynow_rule_validator-1.0.0b
Installing ri documentation for identitynow_rule_validator-1.0.0b
Installing darkfish documentation for identitynow_rule_validator-1.0.0b
Done installing documentation for identitynow_rule_validator after 0 seconds
Parsing documentation for identitynow_rule_validator-1.0.0b
Done installing documentation for identitynow_rule_validator after 0 seconds
Gems updated: identitynow_rule_validator
```

To clean up your installation (This will uninstall all installed *identitynow_rule_validator* gems that are not current.):

```bash
$ sudo gem cleanup identitynow_rule_validator
Cleaning up installed gems...
Attempting to uninstall identitynow_rule_validator-1.0.0b
Successfully uninstalled identitynow_rule_validator-1.0.0b
Clean Up Complete
```



## Execution

This gem has a very simple  interface for execution.  All is needed is to call the *identitynow_rule_validator* by a simple Ruby script as follows:

File: `validate.rb`

```ruby
#!/usr/bin/env ruby
require 'identitynow_rule_validator'

input = "/Users/neil.mcglennon/path/to/some/rules/" # Change this to your folder containing XML rules.

IdentityNowRuleValidator.validate_directory( input )
```

The execution will look something like this:

```
$ ./validate.rb 
--------------------------------------------------------------
 IdentityNow Rule Validator 
--------------------------------------------------------------
 Version: 1.0.0b
 Date: 2020-01-21
 Author: Neil McGlennon (neil.mcglennon@sailpoint.com)
--------------------------------------------------------------
Validating files from directory: /Users/neil.mcglennon/.../rules/
	Rule - BeforeProvisioning - Before Provisioning AD.xml
	Rule - CertificationExclusion - AD Certifiable Groups.xml
	Rule - Generic - Common Exclusion Rule Library.xml
	Rule - IdentityAttribute - Calculate Lifecycle State.xml
	Rule - IdentitySelector - Finance.xml
	Rule - JDBCProvision - Mainframe.xml
	Rule - WebServicesBeforeOperationRule - Generate Header.xml

/Users/neil.mcglennon/.../rules
Rule - CertificationExclusion - AD Certifiable Groups.xml

	Line 3: <Rule language='beanshell' name='AD Certifiable Groups' type='CertificationExc
	Warning: Deprecated Rule Type: CertificationExclusion rules are deprecated.  Consider configuration via certification campaign filters instead.

/Users/neil.mcglennon/.../rules
Rule - Generic - Common Exclusion Rule Library.xml

	Line 111: Custom custom = context.getObjectByName( Custom.class, listName );
	Error: Cannot get objects other than sailpoint.object.Identity or sailpoint.object.Link objects.

	Line 138: allowedRoles.add( context.getObject( Bundle.class, profileName ) );
	Error: Cannot get objects other than sailpoint.object.Identity or sailpoint.object.Link objects.

/Users/neil.mcglennon/.../rules
Rule - IdentitySelector - Finance.xml

	Line 3: <Rule language='beanshell' name='Finance' type='IdentitySele
	Warning: Deprecated Rule Type: IdentitySelector rules are deprecated.  Consider configuration via rule assignment criteria instead.

	Line 18: List links = identity.getLinks();
	Error: The function 'getLinks' is deprecated.  Use an identity search instead.

/Users/neil.mcglennon/.../rules
Rule - JDBCProvision - Mainframe.xml

	Line 24: System.out.println( "plan [" + plan.toXml() + "]" );
	Warning: Remove any System.out configurations in favor of logging statements.

	Line 49: System.out.println( "Operation [" + account.getOperation() + "] detected." );
	Warning: Remove any System.out configurations in favor of logging statements.

/Users/neil.mcglennon/.../rules
Rule - WebServicesBeforeOperationRule - Generate Header.xml

	Line 25: public static String genRandomString(boolean includeNumbers, boolean mixedCase,...
	Warning: Remove references to 'static' in methods. This can cause unexpected behavior.
```

