/// <reference types="cypress" />

describe('jungle rails app', () => {
  beforeEach(() => {
    cy.visit('http://0.0.0.0:3000');
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Before adding an item, the cart in the nav bar displays a quantity of one", () => {
    cy.get("li.nav-item.end-0").should("contain", "My Cart (0)");
  });  

  it("When clicking the add button, the cart in the nav bar displays a quantity of one", () => {
    // Click on the add to cart button of the first product
    cy.get("form.button_to").first().submit();
    // Check the quantity of the cart items in the nav bar
    cy.get("li.nav-item.end-0").should("contain", "My Cart (1)");
  });

});