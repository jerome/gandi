USAGE
=====

require 'gandi'
session = Gandi::Session.connect(:login => "FO1234-GANDI", :password => "foobar")

session.password("new_password")
session.domain_list
session.account_balance

domain  = "example.org"
period  = 1
owner_handle    = "AA1234-GANDI"
admin_handle    = "BB2345-GANDI"
tech_handle     = "CC3456-GANDI"
billing_handle  = "DD4567-GANDI"
ns_list  = ["ns1.example.net", "ns2.example.net", "ns1.example.com"]

operation = session.domain_create( domain, period,
                                   owner_handle, admin_handle,
                                   tech_handle, billing_handle,
                                   ns_list)

session.operation_list :state => "PENDING"

TODO
====
Tests
Gem release
Argument checking for all Gandi methods
Documentation
