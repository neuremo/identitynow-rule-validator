#!/usr/bin/env ruby
require 'identitynow_rule_validator'

findings = IdentityNowRuleValidator.validate_directory( ARGV[0] )

(findings.nil? || findings.empty? ) ? exit(0) : exit(1)
