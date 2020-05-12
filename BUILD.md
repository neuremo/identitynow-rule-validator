![SailPoint](https://files.accessiq.sailpoint.com/modules/builds/static-assets/perpetual/sailpoint/logo/1.0/sailpoint_logo_color_228x50.png)

# IdentityNow Rule Validator

Date: 2020-05-12

Version: 1.0.1

Author: [Neil McGlennon](neil.mcglennon@sailpoint.com)

## Build and Deploy

Build the Gem:

```bash
$ gem build identitynow_rule_validator.gemspec 
Enter PEM pass phrase:  
  Successfully built RubyGem
  Name: identitynow_rule_validator
  Version: 1.0.1
  File: identitynow_rule_validator-1.0.1.gem
```

Install the Gem (Locally):

```bash
$ sudo gem install --local identitynow_rule_validator-1.0.1.gem
Successfully installed identitynow_rule_validator-1.0.1
Parsing documentation for identitynow_rule_validator-1.0.1
Done installing documentation for identitynow_rule_validator after 0 seconds
1 gem installed
```

Publish gem:

```bash
$ gem push identitynow_rule_validator-1.0.1.gem 
Enter your RubyGems.org credentials.
Don't have an account yet? Create one at https://rubygems.org/sign_up
   Email:   neil.mcglennon@sailpoint.com
Password:   

Signed in.
Pushing gem to https://rubygems.org...
Successfully registered gem: identitynow_rule_validator (1.0.1)
```

Remove old version gem:

```bash
$ gem yank identitynow_rule_validator -v 1.0.0
Yanking gem from https://rubygems.org...
Successfully deleted gem: identitynow_rule_validator (1.0.0)
```

