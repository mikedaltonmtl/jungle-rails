/// <reference types="cypress" />

describe('jungle rails app', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("When clicking on a product, the product detail page is visible", () => {
    // The same product that was clicked on should be displayed
    cy.get('[alt="Scented Blade"]').click();
    cy.get('[alt="Scented Blade"]').should("be.visible");
    // There should only be one product displayed
    cy.get("article.product-detail").should("have.length", 1);
  });

});