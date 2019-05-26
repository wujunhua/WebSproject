jest.setMock('selenium-webdriver', webdriver);
// This file was generated using Selenium IDE
const tests = require("./commons.js");
global.Key = require('selenium-webdriver').Key;
global.URL = require('url').URL;
global.BASE_URL = configuration.baseUrl || 'http://localhost:8084/WebSproject/login.htm';
let vars = {};
jest.setTimeout(300000);
describe("Instructor Actions", () => {
  it("Instructor login; Create class", async () => {
    await tests["Instructor login; Create class"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Instructor login; Search and email", async () => {
    await tests["Instructor login; Search and email"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Instructor login; Search employee and delete", async () => {
    await tests["Instructor login; Search employee and delete"](driver, vars);
    expect(true).toBeTruthy();
  });
});
beforeEach(() => {
  vars = {};
});
afterEach(async () => (cleanup()));