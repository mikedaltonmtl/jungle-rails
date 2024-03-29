/// <reference types="cypress" />

describe('jungle rails app', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("There is at least one product on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

});