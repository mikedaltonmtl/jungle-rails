/// <reference types="cypress" />

describe('jungle rails app', () => {

  beforeEach(() => {
    cy.visit('/');
  });

  it("The user can signup to the app and logout", () => {
    cy.get("a.nav-link").contains("Signup").click();
    // Complete the form fields
    cy.get("#user_first_name")
    .type("FirstName").should("have.value", "FirstName");
    cy.get("#user_last_name")
    .type("LastName").should("have.value", "LastName");
    cy.get("#user_email")
    .type("email@gmail.com").should("have.value", "email@gmail.com");
    cy.get("#user_password")
    .type("password").should("have.value", "password");
    cy.get("#user_password_confirmation")
    .type("password").should("have.value", "password");
    // Submit the form
    cy.get(".btn-primary").click();
    // Verify that the login information is visible in the nav bar
    cy.get("span.nav-link").contains("FirstName LastName").should("be.visible");
    // Logout
    cy.get("a.nav-link").contains("Logout").click();
  });


  // next we try to log in directly without the signup part
  // using user1 from the file: cypress_rails.rb
  it("The user can login to a pre-existing account", () => {
    cy.get("a.nav-link").contains("Login").click();
    // Complete the form fields
    cy.get("#email")
    .type("dave@test.com").should("have.value", "dave@test.com");
    cy.get("#password")
    .type("alligator").should("have.value", "alligator");
    // Submit the form
    cy.get(".btn-primary").click();
    // Verify that the login information is visible in the nav bar
    cy.get("span.nav-link").contains("Dave Test").should("be.visible");
  });

});