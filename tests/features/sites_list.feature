Feature: Listing sites
  In order to administer my sites
  As a user
  I need to be able to list those sites.

  Background: I am authenticated
    Given I am authenticated

  @vcr sites_list_empty
  Scenario: List Sites
    When I run "terminus sites list"
    Then I should get:
    """
    You have no sites
    """

  @vcr sites_list
  Scenario: List Sites
    Given a site named "[[test_site_name]]"
    When I run "terminus sites list"
    Then I should get:
    """
    [[test_site_name]]
    """

  @vcr sites_list
  Scenario: Filter sites list by name
    Given a site named "[[test_site_name]]"
    When I run "terminus sites list --name=[[test_site_name]]"
    Then I should get:
    """
    [[test_site_name]]
    """

  @vcr sites_list
  Scenario: Filter sites list by name, excluding the test site
    Given a site named "[[test_site_name]]"
    When I run "terminus sites list --name=missing"
    Then I should not get: "[[test_site_name]]"
    And I should get: "You have no sites."
